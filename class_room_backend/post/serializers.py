from rest_framework import serializers

from .models import Post, Comment


class CommentSerializer(serializers.ModelSerializer):
    username = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = Comment
        fields = '__all__'


class PostSerializer(serializers.ModelSerializer):
    username = serializers.ReadOnlyField(source='user.username')
    email = serializers.ReadOnlyField(source='user.email')
    comment_set = CommentSerializer(many=True, read_only=True)

    class Meta:
        model = Post
        fields = '__all__'
        # extra_fields = ['user']
    #
    # def get_field_names(self, declared_fields, info):
    #     expanded_fields = super(PostSerializer, self).get_field_names(declared_fields, info)
    #
    #     if getattr(self.Meta, 'extra_fields', None):
    #         return expanded_fields + self.Meta.extra_fields
    #     else:
    #         return expanded_fields



