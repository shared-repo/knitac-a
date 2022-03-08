from multiprocessing import AuthenticationError
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login

from common.forms import UserForm

# Create your views here.

def signup(request):
    if request.method == 'GET':
        return render(request, 'common/signup.html')
    else:
        form = UserForm(request.POST)
        if form.is_valid():
            form.save(commit=True) # form의 데이터를 User 모델 객체에 저장 + 데이터베이스 적용 O
            
            # 1. 회원가입 후 로그인 화면으로 이동하는 방식
            # return redirect('common:login')

            # 2. 회원가입 후 자동으로 로그인
            username = form.cleaned_data.get('username') # 유효성 검사가 완료된 데이터 읽기
            password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=password) # 주어진 데이터로 데이터베이스의 데이터 조회
            login(request, user) # 세션에 데이터 저장
            return redirect('index')
        else:
            return render(request, 'common/signup.html', { "form": form })

