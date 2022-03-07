from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render
from django.core.paginator import Paginator

from bookmark.models import Bookmark

# Create your views here.

def index(request):
    # return HttpResponse("Hello, Bookmark App !!!!!")

    bookmarks = Bookmark.objects.all()

    page = request.GET.get('page', 1)
    paginator = Paginator(bookmarks, 10)
    page_object = paginator.get_page(page)
    page_list = list(range(max(page_object.number - 5, 1), min(page_object.number + 5, paginator.count + 1)))
    params = { "bookmarks": page_object, "page_list": page_list }
    return render(request, 
                  "bookmark/list.html",
                  context=params) # list.html template에게 전달하는 데이터

def detail(request, bookmark_id):
    bookmark = get_object_or_404(Bookmark, pk=bookmark_id)
    params = { "bookmark": bookmark }
    return render(request, 
                  "bookmark/detail.html",
                  context=params)