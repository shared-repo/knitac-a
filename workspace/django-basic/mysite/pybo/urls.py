


from django.urls import path

from . import views

app_name = "pybo" # 경로 이름에 대한 namespace : pybo:index, pybo:detail 사용하도록 설정

# config/urls.py의 설정과 결합해서 최종 경로 결정
urlpatterns = [
    # path("", views.index), # url : "pybo/" + "" -> "pybo/"
    # path("<int:question_id>/", views.detail), # url : "pybo/" + "숫자" -> "pybo/숫자"

    path("", views.index, name="index"),
    path("<int:question_id>/", views.detail, name="detail"),
    path("answer/create/<int:question_id>/", views.answer_create, name="answer_create"),

]