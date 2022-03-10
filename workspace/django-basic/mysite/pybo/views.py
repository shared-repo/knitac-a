from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.core.paginator import Paginator

from django.contrib.auth.decorators import login_required

from django.utils import timezone

# from pybo.models import Question
from .models import Answer, Question
from .forms import AnswerForm, QuestionForm

# Create your views here.

def index(request):
    questions = Question.objects.order_by('-create_date') # 데이터베이스의 데이터 조회 ( ORM 자동화 기법 사용 )
    
    page = request.GET.get('page', '1') # ?page=x에서 x의 값 읽기. 없으면 1반환
    paginator = Paginator(questions, 10) # 페이징 관리자 만들기
    page_object = paginator.get_page(page) # 현재 페이지 요청
    page_list = list(range(max(page_object.number - 5, 1), 
                           min(page_object.number + 5, paginator.page_range.stop)))

    context = { "questions": page_object, "page_list": page_list }
    return render(request, 
                  "pybo/question_list.html", 
                  context) # pybo/question_list.html 을 사용해서 응답 html을 반환하는 명령

def detail(request, question_id):
    # question = Question.objects.get(id=question_id) # 데이터가 없으면 오류 발생 및 500 응답 처리
    question = get_object_or_404(Question, pk=question_id) # 데이터가 없으면 404 응답 처리
    context = { "question": question }
    return render(request, 
                  "pybo/question_detail.html",
                  context)


# def answer_create(request, question_id):
#     # 브라우저에서 전송한 데이터 읽기
#     # request : 요청 정보를 담고 있는 객체
#     # request.POST : post 방식으로 전송된 데이터 담고 있는 dict 객체
#     content = request.POST.get('content')

#     # 읽은 데이터 사용 (db에 데이터 저장)
#     question = get_object_or_404(Question, pk=question_id)
#     answer = Answer(question=question, content=content, create_date=timezone.now())
#     answer.save() # 데이터베이스에 데이터 저장
    
#     # context = { "question": question }
#     # return render(request, 
#     #               "pybo/question_detail.html",
#     #               context)
#     return redirect('pybo:detail', question_id=question_id)

def answer_create(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    form = AnswerForm(request.POST)
    if form.is_valid():
        answer = form.save(commit=False) # 객체 조작 후 데이터베이스에 적용 작업 보류
        answer.create_date = timezone.now()        
        answer.question = question
        answer.author = request.user # request.user : 로그인한 사용자 정보 (User 객체)
        answer.save() # 데이터베이스에 데이터 저장
        return redirect('pybo:detail', question_id=question_id)
    else:
        context = { "form" : form, "question": question }
        return render(request, 'pybo/question_detail.html', context)

# def question_create(request):
#     if request.method == 'GET':
#         # 1. 화면을 보여주거나 ( GET 요청 )
#         return render(request, 'pybo/question_form.html')
#     else:
#         # 2. 데이터를 처리하거나 ( POST 요청 )        
#         subject = request.POST.get('subject') # <input ... name='subject' 에 입력된 데이터 읽기
#         content = request.POST.get('content') # <input ... name='content' 에 입력된 데이터 읽기
#         question = Question(subject=subject, content=content, create_date=timezone.now())        
#         question.save()
#         return redirect('pybo:index')
@login_required(login_url='common:login') # 로그인하지 않은 상태로 호출되면 로그인으로 자동 이동 처리 설정
def question_create(request):
    if request.method == 'GET':
        # 1. 화면을 보여주거나 ( GET 요청 )
        return render(request, 'pybo/question_form.html')
    else:
        # 2. 데이터를 처리하거나 ( POST 요청 )     
        form = QuestionForm(request.POST)
        if form.is_valid(): # Model 정의에 따라 수행한 데이터의 유효성 검사 결과 반환
            question = form.save(commit=False) # request.POST의 데이터를 Question 모델 객체에 저장
            question.create_date = timezone.now()
            question.author = request.user # request.user : 로그인한 사용자 정보 (User 객체)
            question.save()
            return redirect('pybo:index')
        else:
            context = { "form": form } # 유효성 검사 실패 정보가 포함된 form을 template에 전달
            return render(request, 'pybo/question_form.html', context)


def question_delete(request, question_id):
    # questions = Question.objects.filter(id=question_id)
    # if len(questions) == 0:
    #     # 404 반환
    #     pass
    # else:
    #     question = questions[0]
    #     question.delete()
    question = get_object_or_404(Question, pk=question_id)
    question.delete()

    return redirect('pybo:index')

def answer_delete(request, answer_id):
    answer = get_object_or_404(Answer, pk=answer_id)
    question_id = answer.question.id
    answer.delete()

    return redirect('pybo:detail', question_id)

@login_required(login_url='common:login')
def question_modify(request, question_id):
    question = get_object_or_404(Question, pk=question_id) # 수정 대상 Question 조회

    if request.method == 'GET': # 화면 표시 요청
        question_form = QuestionForm(instance=question) # QuestionModel을 사용해서 QuestionForm을 만들기
        return render(request, 'pybo/question_form.html', { "form":  question_form })
    else: # 수정 요청 ( 데이터 처리 요청 )
        form = QuestionForm(request.POST, instance=question)
        if form.is_valid():
            question2 = form.save(commit=False)
            question2.modify_date = timezone.now()
            question2.save()

            return redirect('pybo:detail', question_id)
        else:
            return render(request, 'pybo/question_form.html', { "form":  QuestionForm(instance=question) })

