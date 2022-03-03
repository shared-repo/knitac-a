
from django.urls import path

from bookmark import views

app_name = "bookmark"

urlpatterns = [
    path("", views.index, name="index"),
    path("<int:bookmark_id>/", views.detail, name="detail"),
]