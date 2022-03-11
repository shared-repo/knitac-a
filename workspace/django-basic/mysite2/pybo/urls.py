from django.urls import path

from .views import base_views, question_views, answer_views, comment_views

app_name = "pybo" # 경로 이름에 대한 namespace : pybo:index, pybo:detail 사용하도록 설정

# config/urls.py의 설정과 결합해서 최종 경로 결정
urlpatterns = [
    # path("", base_views.index), # url : "pybo/" + "" -> "pybo/"
    # path("<int:question_id>/", base_views.detail), # url : "pybo/" + "숫자" -> "pybo/숫자"

    path("", base_views.index, name="index"),
    path("<int:question_id>/", base_views.detail, name="detail"),
    
    path("question/create/", 
         question_views.question_create, 
         name='question_create'),
    path("question/modify/<int:question_id>",
         question_views.question_modify,
         name="question_modify"), 
    path("question/delete/<int:question_id>",
         question_views.question_delete,
         name="question_delete"),

    path("answer/create/<int:question_id>/", 
         answer_views.answer_create, 
         name="answer_create"),
    path("answer/modify/<int:answer_id>",
         answer_views.answer_modify,
         name="answer_modify"), 
    path("answer/delete/<int:answer_id>",
         answer_views.answer_delete,
         name="answer_delete"),

    path("comment/create/question/<int:question_id>",
         comment_views.comment_create_question,
         name="comment_create_question"),
    path("comment/modify/question/<int:comment_id>",
         comment_views.comment_modify_question,
         name="comment_modify_question"), 
    path("comment/delete/question/<int:comment_id>",
         comment_views.comment_delete_question,
         name="comment_delete_question"),

    path("comment/create/answer/<int:answer_id>",
         comment_views.comment_create_answer,
         name="comment_create_answer"),
    path("comment/modify/answer/<int:comment_id>",
         comment_views.comment_modify_answer,
         name="comment_modify_answer"),
    path("comment/delete/answer/<int:comment_id>",
         comment_views.comment_delete_answer,
         name="comment_delete_answer"), 

]