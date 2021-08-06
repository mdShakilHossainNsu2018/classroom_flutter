from django.db import models


# Create your models here.
class TrainData(models.Model):
    question = models.CharField(blank=False, null=False, max_length=250)
    answer = models.CharField(blank=False, null=False, max_length=250)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.question
