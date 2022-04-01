
from time import strftime
from django.http import HttpResponse
from django.shortcuts import render


def index(request):
    return render(request, 'home.html')

def ajax_form(request):
    return render(request, 'ajax-form.html')

def ajax_data(request):
    import time
    time.sleep(5)

    from datetime import datetime 
    now = datetime.now()
    time_string = now.strftime("%Y-%m-%d %H:%M:%S")

    return HttpResponse(time_string)    