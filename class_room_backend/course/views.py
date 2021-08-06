from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Course
from .serializers import CourseSerializer


# Create your views here.


class ReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.method in permissions.SAFE_METHODS


class CourseViewSet(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly, permissions.IsAdminUser | ReadOnly]


class GetCourses(APIView):
    # print('comming ')
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        courses = Course.objects.all().filter(users=request.user)

        serializer = CourseSerializer(courses, many=True, context={'request': request})

        return Response(serializer.data)






