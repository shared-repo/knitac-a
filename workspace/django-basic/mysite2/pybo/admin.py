from django.contrib import admin

from pybo.models import Question, Answer

# Register your models here. ( 관리자 화면에 노출해서 사용할 수 있도록 등록 )

class QuestionAdmin(admin.ModelAdmin): # 관리자 기능을 위한 설정
    search_fields = ["subject"] # 검색 기준 컬럼(필드) 지정 -> 화면에 검색 기능 추가

admin.site.register(Question, QuestionAdmin)
admin.site.register(Answer)
