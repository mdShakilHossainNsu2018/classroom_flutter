import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.text,
    required this.isMe,
  });
  final String text;
  final bool isMe;

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment:
        //     isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe ? SizedBox.shrink() : Icon(Icons.support_agent),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 10,
                    color: isMe ? Colors.lightBlueAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 15,
                            color: isMe ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              isMe
                  ? Icon(
                      Icons.face,
                      color: Colors.lightBlueAccent,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
