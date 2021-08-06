import json
from channels.generic.websocket import WebsocketConsumer, AsyncWebsocketConsumer


class ClassRoomConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['course_id']
        self.room_group_name = 'course_%s' % self.room_name

        # Join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        posted_by = text_data_json['posted_by']
        # message = text_data

        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message,
                'posted_by': posted_by,
            }
        )

        # await self.send(text_data=json.dumps({
        #     'message': message
        # }))

        # Receive message from room group
    async def chat_message(self, event):
        message = event['message']
        posted_by = event['posted_by']

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'message': message,
            'posted_by': posted_by,
        }))


