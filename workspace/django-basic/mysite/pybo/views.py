from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render

# from pybo.models import Question
from .models import Question

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
    # question = Question.objects.get(id=question_id)
    question = get_object_or_404(Question, pk=question_id) # 데이터가 없으면 404 응답 처리
    context = { "question": question }
    return render(request, 
                  "pybo/question_detail.html",
                  context)
