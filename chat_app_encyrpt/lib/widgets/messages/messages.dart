import 'package:chat_app_encyrpt/widgets/messages/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (BuildContext context, AsyncSnapshot future) {
        if (future.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final ch = snapshot.data?.docs;

            return ListView.builder(
              reverse: true,
              itemCount: ch?.length,
              itemBuilder: (context, index) => MessageBubble(
                  ch?[index]['text'], ch?[index]['userId'] == future.data.uid,key: ValueKey(ch?[index].id),),
            );
          },
        );
      },
    );
  }
}
