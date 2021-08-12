from django.contrib.auth.models import User
from rest_framework import serializers


# Serializers define the API representation.
from rest_framework.exceptions import ValidationError



class UserSerializer(serializers.HyperlinkedModelSerializer):
    # courses = CourseSerializer(many=True,)
    class Meta:
        model = User
        fields = ['id', 'url', 'username', 'email', 'password', 'is_staff', 'is_superuser']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def validate_email(self, value):
        data = self.get_initial()
        email = data.get('email')

        if User.objects.filter(email=email).exists():
            raise ValidationError("Email exists")

     #   if not email.endswith('northsouth.edu'):
     #       raise ValidationError('Only northsouth.edu email accepted.')
        return value

    # def validate_username(self, value):
    #     data = self.get_initial()
    #     username = data.get('username')
    #
    #     if not username.isdigit():
    #         raise ValidationError('Please user your Id only.')
    #     return value

    def create(self, validated_data):
        email = validated_data.get('email')
        username = validated_data.get('username')
        password = validated_data.get('password')
        is_staff = validated_data.get('is_staff')
        try:
            user = User.objects.create(username=username, email=email, is_staff=is_staff)
            user.set_password(password)
            user.save()
            return user
        except Exception as e:
            return e
