from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render

# from pybo.models import Question
from .models import Answer, Question
from .forms import QuestionForm

# Create your views here.

def index(request):
    # 테스트 1 : 단순 문자열 반환
    # return HttpResponse("Hello, Django Web Application Programming World !!!")
    
    # 테스트 2 : 동적 문자열 반환 (매 요청마다 다른 데이터를 반환 - 여기서는 시간 )
    # from datetime import datetime
    # now = datetime.now()
    # # strftime : 지정된 서식에 따라 날짜를 문자열로 변환
    # time_str = now.strftime("%Y-%m-%d %H:%M:%S") 
    
    # return HttpResponse(time_str) # HttpResponse : 응답 전송하는 객체

    # 테스트 3 : HTML 반환 - 템플릿 사용
    # questions = Question.objects.all() # 데이터베이스의 데이터 조회 ( ORM 자동화 기법 사용 )
    questions = Question.objects.order_by('-create_date') # 데이터베이스의 데이터 조회 ( ORM 자동화 기법 사용 )
    context = { "questions": questions }
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


def answer_create(request, question_id):
    # 브라우저에서 전송한 데이터 읽기
    # request : 요청 정보를 담고 있는 객체
    # request.POST : post 방식으로 전송된 데이터 담고 있는 dict 객체
    content = request.POST.get('content')

    # 읽은 데이터 사용 (db에 데이터 저장)
    from django.utils import timezone
    question = get_object_or_404(Question, pk=question_id)
    answer = Answer()
    answer.question = question
    answer.content = content 
    answer.create_date = timezone.now()
    answer.save() # 데이터베이스에 데이터 저장
    
    # context = { "question": question }
    # return render(request, 
    #               "pybo/question_detail.html",
    #               context)
    return redirect('pybo:detail', question_id=question_id)

# def question_create(request):
#     if request.method == 'GET':
#         # 1. 화면을 보여주거나 ( GET 요청 )
#         return render(request, 'pybo/question_form.html')
#     else:
#         # 2. 데이터를 처리하거나 ( POST 요청 )
#         from django.utils import timezone        
#         subject = request.POST.get('subject') # <input ... name='subject' 에 입력된 데이터 읽기
#         content = request.POST.get('content') # <input ... name='content' 에 입력된 데이터 읽기
#         question = Question(subject=subject, content=content, create_date=timezone.now())        
#         question.save()
#         return redirect('pybo:index')

def question_create(request):
    if request.method == 'GET':
        # 1. 화면을 보여주거나 ( GET 요청 )
        return render(request, 'pybo/question_form.html')
    else:
        # 2. 데이터를 처리하거나 ( POST 요청 )
        from django.utils import timezone        
        form = QuestionForm(request.POST)
        if form.is_valid(): # Model 정의에 따라 수행한 데이터의 유효성 검사 결과 반환
            question = form.save(commit=False) # request.POST의 데이터를 Question 모델 객체에 저장
            question.create_date = timezone.now()
            question.save()
            return redirect('pybo:index')
        else:
            context = { "form": form } # 유효성 검사 실패 정보가 포함된 form을 template에 전달
            return render(request, 'pybo/question_form.html', context)

