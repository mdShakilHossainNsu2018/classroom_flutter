import json
from rest_framework import views
from django.views.generic import View
from django.http import JsonResponse
from chatterbot import ChatBot
from chatterbot.ext.django_chatterbot import settings


class ChatterBotApiView(views.APIView):
    """
    Provide an API endpoint to interact with ChatterBot.
    """

    chatterbot = ChatBot(**settings.CHATTERBOT)

    def post(self, request, format=None):

        """
        Return a response to the statement in the posted data.
        * The JSON data should contain a 'text' attribute.
        """

        # print(request.data['text'])

        # input_data = json.loads(request.body.decode('utf-8'))

        if 'text' not in request.data:
            return JsonResponse({
                'text': [
                    'The attribute "text" is required.'
                ]
            }, status=400)

        # print(input_data)

        response = self.chatterbot.get_response(request.data['text'])

        response_data = response.serialize()
        return JsonResponse(response_data, status=200)

    def get(self, request, format=None):
        """
        Return data corresponding to the current conversation.
        """
        return JsonResponse({
            'name': self.chatterbot.name
        })




