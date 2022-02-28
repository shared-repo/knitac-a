from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.

def index(request):
    # return HttpResponse("Hello, Django Web Application Programming World !!!")
    
    from datetime import datetime
    now = datetime.now()
    # strftime : 지정된 서식에 따라 날짜를 문자열로 변환
    time_str = now.strftime("%Y-%m-%d %H:%M:%S") 
    
    return HttpResponse(time_str) # HttpResponse : 응답 전송하는 객체
