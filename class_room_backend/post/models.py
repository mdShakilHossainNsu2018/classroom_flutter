from django.contrib.auth import get_user_model
from django.db import models

from course.models import Course

User = get_user_model()
post_type = (('assignment', 'assignment',), ('post', 'post'))


class Post(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    context = models.CharField(max_length=500)
    attachment = models.FileField(blank=True, null=True, upload_to='attachment/')
    due_date = models.DateField(blank=True, null=True)
    due_time = models.TimeField(blank=True, null=True)
    type = models.CharField(choices=post_type, max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.type + ": " + self.context


# class Assignment(models.Model):
#     course = models.ForeignKey(Course, on_delete=models.CASCADE)
#     context = models.CharField(max_length=500)
#     attachment = models.FileField(blank=True, null=True)

class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    comment = models.CharField(max_length=250)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.comment

    # class Meta:
    #     ordering = ['-created_at']






