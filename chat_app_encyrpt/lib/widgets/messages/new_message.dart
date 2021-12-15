import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final TextEditingController _textController = TextEditingController();
  void _sendMessage()async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
    });
    _textController.clear();
    if (_enteredMessage.trim().isEmpty) {
      return;
    }
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Mesaj gönder',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(8.0),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
