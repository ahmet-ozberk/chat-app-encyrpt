import 'package:chat_app_encyrpt/encrypt/encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final TextEditingController _textController = TextEditingController();
  void _sendMessage() async {
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
      height: 50,
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade200,
          ],
        ),
        border: Border.all(color: Colors.black45),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Şifreli Mesajınızı Giriniz',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() {
                    _enteredMessage = encyption(message: value);
                  });
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange.shade800),
                color: Colors.white),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.orange, size: 17),
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
