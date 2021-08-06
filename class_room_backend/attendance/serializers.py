from rest_framework.serializers import ModelSerializer
from rest_framework_bulk import (
    BulkListSerializer,
    BulkSerializerMixin,
)

from .models import Attendance


class AttendanceSerializer(BulkSerializerMixin, ModelSerializer):
    class Meta(object):
        model = Attendance
        fields = '__all__'
        # only necessary in DRF3
        list_serializer_class = BulkListSerializer
