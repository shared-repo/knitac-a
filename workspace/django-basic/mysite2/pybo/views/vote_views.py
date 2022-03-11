from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required

from ..models import Question, Answer

def vote_question(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    question.voter.add(request.user)
    question.save()
    return redirect('pybo:detail', question_id)

def vote_answer(request, answer_id):
    answer = get_object_or_404(Answer, pk=answer_id)
    answer.voter.add(request.user)
    answer.save()
    return redirect('pybo:detail', answer.question.id)