from django.db import models

from django.contrib.auth.models import User

# Create your models here.

# 모델 클래스 만들기 --> 테이블 만들기
class Question (models.Model):
    # 필드 만들기 --> 컬럼 만들기
    subject = models.CharField(max_length=200)
    content = models.TextField()
    create_date = models.DateTimeField()

    # 작성자 필드 추가 ( User 모델 객체 참조 )
    author = models.ForeignKey(User, on_delete=models.CASCADE)

    # 수정일자 필드 추가
    modify_date = models.DateTimeField(null=True, blank=True)

    def __str__(self): # __str__ : 객체(인스턴스의) 정보를 간단한 문자열로 반환하는 약속된 함수
        return self.subject

class Answer (models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    content = models.TextField()
    create_date = models.DateTimeField()

    # 작성자 필드 추가 ( User 모델 객체 참조 )
    author = models.ForeignKey(User, on_delete=models.CASCADE)

    # 수정일자 필드 추가
    modify_date = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        if len(self.content) < 15:
            return self.content
        else:
            return self.content[:15] + "..."

class Comment (models.Model):

    author = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    create_date = models.DateTimeField()
    modify_date = models.DateTimeField(null=True, blank=True)
    
    # question과 answer에 대한 참조는 상호 배타적(question을 참조하면 answer를 참조할 수 없으며 역도 마찬가지)
    question = models.ForeignKey(Question, null=True, blank=True, on_delete=models.CASCADE)
    answer = models.ForeignKey(Answer, null=True, blank=True, on_delete=models.CASCADE)
    
    def __str__(self):
        if len(self.content) < 15:
            return self.content
        else:
            return self.content[:15] + "..."
