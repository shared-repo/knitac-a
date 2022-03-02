from django.db import models

# Create your models here.

class Bookmark(models.Model):
    title = models.CharField(max_length=100, blank=True)
    # url = models.CharField(max_length=500)
    url = models.URLField(unique=True)
    create_date = models.DateTimeField()

    def __str__(self):
        return self.title
