from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

class UserForm(UserCreationForm):

    class Meta:
        model = User
        fields = ["username", "email"]
        # labels = {
        #     "username": "사용자이름",
        #     "email": "이메일"
        # }