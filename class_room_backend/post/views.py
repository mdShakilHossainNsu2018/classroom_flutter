from rest_framework import generics, views
from rest_framework.request import Request
from rest_framework.response import Response

from .models import Post, Comment
from .serializers import PostSerializer, CommentSerializer


class CreatePost(generics.CreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class PostViewByCourse(views.APIView):

    def get(self, request, format=None):

        if 'course' not in request.query_params:
            return Response({"data": "Please provide course query prams."})

        post_data = Post.objects.all().filter(course=request.query_params.get('course')).order_by('-created_at')

        serializer_context = {
            'request': request,
        }

        post = PostSerializer(post_data, many=True, context=serializer_context)

        return Response(post.data)


class CreateComment(generics.CreateAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer



