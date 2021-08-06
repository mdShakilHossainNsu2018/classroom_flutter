from django.urls import path
from .views import ChatterBotApiView


# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', ChatterBotApiView.as_view()),
]
