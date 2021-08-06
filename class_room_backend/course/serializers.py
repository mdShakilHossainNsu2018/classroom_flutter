from rest_framework import serializers
from .models import Course


class CourseSerializer(serializers.HyperlinkedModelSerializer):
    # class_days: "st"
    # course_code: "tes"
    # course_name: "test"
    # course_section: 2
    # created_at: "2020-12-01T19:07:26.806067Z"
    # end_time: "2020-12-06T06:07:00Z"
    # start_time: "2020-12-02T03:09:00Z"
    # updated_at: "2020-12-08T09:33:42.334884Z"
    # url: "http://127.0.0.1:8000/api/courses/courses/1/"
    # users: Array(1)
    # 0: "http://127.0.0.1:8000/api/users/users/6/"
    class Meta:
        model = Course
        fields = ['id', 'url', 'course_name', 'course_section', 'course_code', 'class_days', 'start_time', 'end_time', 'created_at', 'updated_at', 'users' ]
