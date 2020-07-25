import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/Message.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (ctx, i) => Message(messages[i]['text']),
        );
      },
    );
  }
}
