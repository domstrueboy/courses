import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  Message(this.message, this.username, this.userImage, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
                ),
              ),
              width: 150,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -5,
          left: isMe ? null : 136,
          right: isMe ? 136 : null,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: userImage == null ? null : NetworkImage(userImage),
            child: userImage == null ? Text(username) : null,
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
