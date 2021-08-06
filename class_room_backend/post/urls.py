from django.urls import path, include
from .views import CreatePost, CreateComment, PostViewByCourse


# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('create/', CreatePost.as_view()),
    path('', PostViewByCourse.as_view()),
    path('commnet/', CreateComment.as_view()),
]
