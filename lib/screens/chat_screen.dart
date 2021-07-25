import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_firebase/widgets/chat/messages.dart';
import 'package:flutter_chat_app_firebase/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        centerTitle: true,
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert,color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(
                  child: Container(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
              value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier)async{
              if(itemIdentifier == 'logout'){
               await FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages(),),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
