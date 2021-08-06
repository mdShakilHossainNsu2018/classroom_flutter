# Generated by Django 3.1.3 on 2020-12-08 07:58

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('course', '0005_course_users'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='course',
            name='users',
        ),
        migrations.AddField(
            model_name='course',
            name='users',
            field=models.ManyToManyField(to=settings.AUTH_USER_MODEL),
        ),
    ]
