from django.shortcuts import get_object_or_404, redirect, render

from django.contrib.auth.decorators import login_required

from django.utils import timezone

from ..models import Question, Answer, Comment
from ..forms import CommentForm

@login_required(login_url="common:login")
def comment_create_question(request, question_id):

    question = get_object_or_404(Question, pk=question_id)

    if request.method == 'GET':
        return render(request, 'pybo/comment_form.html')
    else:
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False) # 1. 요청데이터 -> Comment로 데이터 이동 + 2. Comment -> 데이터베이스 (여기서는 2번 X)
            comment.author = request.user
            comment.create_date = timezone.now()
            comment.question = question
            # comment.answer = None # 필요 없음
            comment.save()

            return redirect("pybo:detail", question_id)
        else:
            return render(request, 'pybo/comment_form.html', { "form": form })

@login_required(login_url="common:login")
def comment_delete_question(request, comment_id):
    comment = get_object_or_404(Comment, pk=comment_id)
    comment.delete() # ORM Model 객체의 delete는 데이터베이스 테이블의 행 삭제 수행
    return redirect("pybo:detail", comment.question.id)

@login_required(login_url="common:login")
def comment_modify_question(request, comment_id):

    comment = get_object_or_404(Comment, pk=comment_id)

    if request.method == 'GET':
        return render(request, 'pybo/comment_form.html', { "form": CommentForm(instance=comment) })
    else:
        form = CommentForm(request.POST, instance=comment)
        if form.is_valid():
            comment = form.save(commit=False) # 1. 요청데이터 -> Comment로 데이터 이동 + 2. Comment -> 데이터베이스 (여기서는 2번 X)
            comment.modify_date = timezone.now()
            comment.save()

            return redirect("pybo:detail", comment.question.id)
        else:
            return render(request, 'pybo/comment_form.html', { "form": form })

#####################################################

@login_required(login_url="common:login")
def comment_create_answer(request, answer_id):

    answer = get_object_or_404(Answer, pk=answer_id)

    if request.method == 'GET':
        return render(request, 'pybo/comment_form.html')
    else:
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False) # 1. 요청데이터 -> Comment로 데이터 이동 + 2. Comment -> 데이터베이스 (여기서는 2번 X)
            comment.author = request.user
            comment.create_date = timezone.now()
            comment.answer = answer
            comment.save()

            return redirect("pybo:detail", answer.question.id)
        else:
            return render(request, 'pybo/comment_form.html', { "form": form })

@login_required(login_url="common:login")
def comment_modify_answer(request, comment_id):

    comment = get_object_or_404(Comment, pk=comment_id)

    if request.method == 'GET':
        return render(request, 'pybo/comment_form.html', { "form": CommentForm(instance=comment) })
    else:
        form = CommentForm(request.POST, instance=comment)
        if form.is_valid():
            comment = form.save(commit=False) # 1. 요청데이터 -> Comment로 데이터 이동 + 2. Comment -> 데이터베이스 (여기서는 2번 X)
            comment.modify_date = timezone.now()
            comment.save()

            return redirect("pybo:detail", comment.answer.question.id)
        else:
            return render(request, 'pybo/comment_form.html', { "form": form })

@login_required(login_url="common:login")
def comment_delete_answer(request, comment_id):
    comment = get_object_or_404(Comment, pk=comment_id)
    comment.delete() # ORM Model 객체의 delete는 데이터베이스 테이블의 행 삭제 수행
    return redirect("pybo:detail", comment.answer.question.id)