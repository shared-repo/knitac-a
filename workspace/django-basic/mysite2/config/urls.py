"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path
from django.conf.urls.static import static

from config import settings

from . import views
from pybo import views as pybo_views

urlpatterns = [
    path('', views.index, name='index'),

    path('admin/', admin.site.urls),

    # path('pybo/', pybo_views.index), # http://.../pybo 요청이 오면 views.index 호출
    path('pybo/', include('pybo.urls')), # http://.../pybo 관련 요청이 오면 pybo.urls.py의 설정 내용 사용
    path('common/', include('common.urls')), # http://.../common 관련 요청이 오면 common.urls.py의 설정 내용 사용
]# + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
