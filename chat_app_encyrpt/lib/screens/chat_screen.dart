import 'package:chat_app_encyrpt/widgets/messages/messages.dart';
import 'package:chat_app_encyrpt/widgets/messages/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Messages()), NewMessage()],
        ),
      ),
    );
  }
}

/*
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('chats/MX0LbIUHnA29LvUSXbT3/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data?.docs;
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(documents?[index]['text']),
              ),
            );
          })
*/
