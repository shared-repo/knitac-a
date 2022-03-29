from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render

from django.contrib.auth.decorators import login_required

from django.utils import timezone

from ..models import Answer, Question
from ..forms import AnswerForm

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

def answer_delete(request, answer_id):
    answer = get_object_or_404(Answer, pk=answer_id)
    question_id = answer.question.id
    answer.delete()

    return redirect('pybo:detail', question_id)

@login_required(login_url='common:login')
def answer_modify(request, answer_id):
    answer = get_object_or_404(Answer, pk=answer_id) # 수정 대상 Answer 조회
    if request.method == 'GET': # 화면 표시 요청
        answer_form = AnswerForm(instance=answer) # AnswerModel을 사용해서 AnswerForm을 만들기
        return render(request, 'pybo/answer_form.html', { "form":  answer_form })
    else: # 수정 요청 ( 데이터 처리 요청 )
        form = AnswerForm(request.POST, instance=answer)
        if form.is_valid():
            answer2 = form.save(commit=False)
            answer2.modify_date = timezone.now()
            answer2.save()

            return redirect('pybo:detail', answer.question.id)
        else:
            return render(request, 'pybo/answer_form.html', { "form":  AnswerForm(instance=answer) })

def ajax_answer_create(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    form = AnswerForm(request.POST)
    if form.is_valid():
        answer = form.save(commit=False) # 객체 조작 후 데이터베이스에 적용 작업 보류
        answer.create_date = timezone.now()        
        answer.question = question
        answer.author = request.user # request.user : 로그인한 사용자 정보 (User 객체)
        answer.save() # 데이터베이스에 데이터 저장
        return HttpResponse("success")
    else:
        return HttpResponse("fail")

def ajax_answer_list(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'pybo/ajax_answer_list.html', { "question" : question })
