from django.contrib.auth.models import User
from rest_framework import views
from rest_framework import viewsets, status
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.response import Response

from course.models import Course
from .serializers import UserSerializer


# ViewSets define the view behavior.
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class CustomAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        # print(serializer.is_valid())
        if not serializer.is_valid():
            return Response({"error": "invalid credentials..."}, status=status.HTTP_401_UNAUTHORIZED)
        # serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        # print(user)
        token, created = Token.objects.get_or_create(user=user)
        # print(token)
        # if token is None:
        #     return Response()
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'username': user.username,
            'email': user.email,
            'is_staff': user.is_staff,
            'id': user.id,
        })


class GetUserByCourse(views.APIView):
    def get(self, request, format=None):
        if 'course' not in request.query_params:
            return Response({"data": "Please provide course query prams."}, status=status.HTTP_400_BAD_REQUEST)

        users = Course.objects.all().filter(id=request.query_params.get('course'))

        user_data = User.objects.all().filter(course__in=users)

        serializer_context = {
            'request': request,
        }

        users_serializer = UserSerializer(user_data, many=True, context=serializer_context)

        return Response(users_serializer.data)
