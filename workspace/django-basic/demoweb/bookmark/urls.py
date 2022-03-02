
from django.urls import path

from bookmark import views


urlpatterns = [
    path("", views.index),
    path("<int:bookmark_id>/", views.detail),
]