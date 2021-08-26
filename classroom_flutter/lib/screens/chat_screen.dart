import 'dart:convert';

import 'package:classroom_flutter/constants/constants.dart';
import 'package:classroom_flutter/controller/apis/chat_bot.dart';
import 'package:classroom_flutter/models/bot_message_model.dart';
import 'package:classroom_flutter/models/bot_response_model.dart';
import 'package:classroom_flutter/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat-screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? _messageText;

  final _messageController = TextEditingController();
  ChatBOTAPI _botapi = ChatBOTAPI();
  ScrollController _scrollController = ScrollController();

  List<BotMessageModel> _botMessageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Screen"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ListView.builder(
                // controller: _scrollController,
                scrollDirection: Axis.vertical,

                itemBuilder: (context, index) {
                  return MessageBubble(
                    isMe: _botMessageList[index].type == BotResponseType.HUMEN,
                    text: _botMessageList[index].message,
                  );
                },
                itemCount: _botMessageList.length,
              )),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        onChanged: (value) {
                          //Do something with the user input.
                          _messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Implement send functionality.
                        _messageController.clear();
                        var response = await _botapi.getChatBOTResponse(
                            text: _messageText!);

                        if (response.statusCode == 200) {
                          print(response.body);

                          setState(() {
                            BotResponseModel botResponseModel =
                                BotResponseModel.fromJson(
                                    jsonDecode(response.body));
                            BotMessageModel humanMessage = BotMessageModel(
                                message: botResponseModel.inResponseTo,
                                type: BotResponseType.HUMEN);
                            _botMessageList.add(humanMessage);

                            BotMessageModel botMessage = BotMessageModel(
                                message: botResponseModel.text,
                                type: BotResponseType.BOT);
                            _botMessageList.add(botMessage);
                            // _scrollController.animateTo(
                            //     _scrollController.position.maxScrollExtent,
                            //     duration: Duration(milliseconds: 200),
                            //     curve: Curves.easeOut);
                          });
                        }
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
