from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render

from bookmark.models import Bookmark

# Create your views here.

def index(request):
    # return HttpResponse("Hello, Bookmark App !!!!!")

    bookmarks = Bookmark.objects.all()
    params = { "bookmarks": bookmarks }
    return render(request, 
                  "bookmark/list.html",
                  context=params) # list.html template에게 전달하는 데이터

def detail(request, bookmark_id):
    bookmark = get_object_or_404(Bookmark, pk=bookmark_id)
    params = { "bookmark": bookmark }
    return render(request, 
                  "bookmark/detail.html",
                  context=params)