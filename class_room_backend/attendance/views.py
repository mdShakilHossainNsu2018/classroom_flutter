from rest_framework import views
from rest_framework.response import Response
from rest_framework_bulk import ListBulkCreateUpdateDestroyAPIView
from .models import Attendance
from .serializers import AttendanceSerializer


class AttendanceCreateView(ListBulkCreateUpdateDestroyAPIView):
    queryset = Attendance.objects.all()
    serializer_class = AttendanceSerializer


class GetAttendanceByUser(views.APIView):
    def get(self, request, format=None):
        user = request.query_params.get('user')
        course = request.query_params.get('course')

        queryset = Attendance.objects.all().filter(user=user, course=course)

        serializer = AttendanceSerializer(queryset, many=True)

        return Response(serializer.data)
