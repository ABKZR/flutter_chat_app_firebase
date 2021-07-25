import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_firebase/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);
  Future getUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatdocs = snapshot.data!.docs;

                return ListView.builder(
                    reverse: true,
                    itemCount: chatdocs.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: chatdocs[index]['text'],
                        username: chatdocs[index]['username'],
                        isMe: chatdocs[index]['userId'] ==
                            futureSnapshot.data.uid,
                        imageUrl: chatdocs[index]['user_image'],
                      );
                      // return Text(chatdocs[index]['text']);
                    });
              });
        });
  }
}
