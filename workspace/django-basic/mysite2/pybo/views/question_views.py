from django.shortcuts import get_object_or_404, redirect, render

from django.contrib.auth.decorators import login_required

from django.utils import timezone

from ..models import Question
from ..forms import QuestionForm

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

def question_delete(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    question.delete()

    return redirect('pybo:index')