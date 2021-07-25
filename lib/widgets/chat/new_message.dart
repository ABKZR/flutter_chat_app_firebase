import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
  final user = await FirebaseAuth.instance.currentUser;
  final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
   await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user!.uid, 
      'username': userData['username'],
      'user_image': userData['image_url'],
    });
    _messageController.clear();
  }
  var _messageController = TextEditingController();
  var _enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Send a message ...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
