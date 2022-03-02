


from django.urls import path

from . import views

# config/urls.py의 설정과 결합해서 최종 경로 결정
urlpatterns = [
    path("", views.index), # url : "pybo/" + "" -> "pybo/"
    path("<int:question_id>/", views.detail), # url : "pybo/" + "숫자" -> "pybo/숫자"

]