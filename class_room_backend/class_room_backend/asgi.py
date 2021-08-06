"""
ASGI config for class_room_backend project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/asgi/
"""

import os
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.core.asgi import get_asgi_application

import course.routing
import siteblocker.routing

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'class_room_backend.settings')

application = get_asgi_application()


application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    # Just HTTP for now. (We can add other protocols later.)
    "websocket": AuthMiddlewareStack(
        URLRouter(
            course.routing.websocket_urlpatterns +
            siteblocker.routing.websocket_urlpatterns,
        )
    ),
})
