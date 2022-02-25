from django.db import models

# Create your models here.

# 모델 클래스 만들기 --> 테이블 만들기
class Question (models.Model):
    # 필드 만들기 --> 컬럼 만들기
    subject = models.CharField(max_length=200)
    content = models.TextField()
    create_date = models.DateTimeField()

class Answer (models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    content = models.TextField()
    create_date = models.DateTimeField()
