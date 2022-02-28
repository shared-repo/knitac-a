from django.db import models

# Create your models here.

# 모델 클래스 만들기 --> 테이블 만들기
class Question (models.Model):
    # 필드 만들기 --> 컬럼 만들기
    subject = models.CharField(max_length=200)
    content = models.TextField()
    create_date = models.DateTimeField()

    def __str__(self): # __str__ : 객체(인스턴스의) 정보를 간단한 문자열로 반환하는 약속된 함수
        return self.subject

class Answer (models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    content = models.TextField()
    create_date = models.DateTimeField()

    def __str__(self):
        if len(self.content) < 15:
            return self.content
        else:
            return self.content[:15] + "..."
