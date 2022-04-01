from django import forms

from .models import Answer, Question, Comment

class QuestionForm(forms.ModelForm):
    class Meta: # 정보를 제공하는 (설정하는) 클래스
        model = Question # 자동 변환 Model 클래스
        fields = [ 'subject', 'content' ] # 자동 변환 대상 필드 (변수, 컬럼)
        labels = {
            'subject': "제목", # subject field는 제목으로 표시하는 설정
            'content': "내용",  # content field는 내용으로 표시하는 설정            
        }

class AnswerForm(forms.ModelForm):
    class Meta:
        model = Answer
        fields = [ 'content' ]
        labels = {
            'content': '답변내용'
        }

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = [ 'content' ]
        labels = {
            'content': '댓글내용'
        }