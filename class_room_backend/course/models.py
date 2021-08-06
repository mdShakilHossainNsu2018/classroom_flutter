from django.db import models
from django.contrib.auth import get_user_model


Days = (
    ('st', 'st'),
    ('mw', 'mw'),
    ('ra', 'ra'),
)

User = get_user_model()


class Course(models.Model):
    course_name = models.CharField(blank=False, null=False, max_length=50)
    course_code = models.CharField(blank=False, null=False, max_length=50)
    course_section = models.IntegerField(blank=False, null=False)
    start_time = models.TimeField(blank=False, null=False)
    end_time = models.TimeField(blank=False, null=False)
    class_days = models.CharField(choices=Days, blank=False, null=False, max_length=50)
    users = models.ManyToManyField(User)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.course_code + str(self.course_section)
