from django import template

register = template.Library()

# @ : annotation -> 함수, 클래스 등을 어떻게 처리해야 되는지에 대한 지시문
@register.filter # 여기서는 sub 함수를 django template의 필터로 등록하는 지시문
def sub(value, arg):
    return value - arg