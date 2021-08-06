from django.urls import path

from . import consumers

websocket_urlpatterns = [
    path('ws/room/<int:course_id>/', consumers.ClassRoomConsumer.as_asgi()),
]

