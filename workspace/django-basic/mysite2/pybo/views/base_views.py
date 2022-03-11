from django.shortcuts import get_object_or_404, render
from django.core.paginator import Paginator

from ..models import Question

def index(request):
    questions = Question.objects.order_by('-create_date') # 데이터베이스의 데이터 조회 ( ORM 자동화 기법 사용 )
    
    page = request.GET.get('page', '1') # ?page=x에서 x의 값 읽기. 없으면 1반환
    paginator = Paginator(questions, 10) # 페이징 관리자 만들기
    page_object = paginator.get_page(page) # 현재 페이지 요청
    page_list = list(range(max(page_object.number - 5, 1), 
                           min(page_object.number + 5, paginator.page_range.stop)))

    context = { "questions": page_object, "page_list": page_list }
    return render(request, 
                  "pybo/question_list.html", 
                  context) # pybo/question_list.html 을 사용해서 응답 html을 반환하는 명령

def detail(request, question_id):
    # question = Question.objects.get(id=question_id) # 데이터가 없으면 오류 발생 및 500 응답 처리
    question = get_object_or_404(Question, pk=question_id) # 데이터가 없으면 404 응답 처리
    context = { "question": question }
    return render(request, 
                  "pybo/question_detail.html",
                  context)