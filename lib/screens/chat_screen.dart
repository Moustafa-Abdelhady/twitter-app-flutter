import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

final _firestore = FirebaseFirestore.instance;
// lat User signedInUser;
// String? email;

String? getCookie(String key) {
  final cookies = html.document.cookie!.split(';');
  for (var cookie in cookies) {
    final keyValue = cookie.split('=');
    if (keyValue[0].trim() == key) {
      return keyValue[1];
    }
  }
  return null;
}
  final email = getCookie('username');
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

 

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;
  // String? email;

  // void geMessages() async {
  //   final message = await _firestore.collection('chatTwitter').get();
  //   for (var message in message.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStreams() async {
    await for (var snapshot
        in _firestore.collection("chatTwitter").snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Row(
          children: [
             Image.asset("assets/twitterlogo.png", height: 15,),
            SizedBox(width: 10),
            Text('Message Me $email'),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         messagesStreams();
        //         // geMessages();
        //         // add here logo
        //         _auth.signOut();
        //         // Navigator.pop();
        //       },
        //       icon: Icon(Icons.close)
        //       )
        // ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessageStreamBuilder(),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: Colors.blue,
              width: 2,
            ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                      // email = "mostaf@gmail.com";
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'Write Your Message here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection("chatTwitter").add({
                      'sender': email,
                      'text': messageText,
                      'time': FieldValue.serverTimestamp(),
                    });
                  },
                  child: Text(
                    'send',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('chatTwitter').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MesageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          // add here a spinner
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue[300],
            ),
          );
        }

        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get("sender");
          final currentUser = email;

          if (currentUser == messageSender) {
            // the code of the message from the signed inuser
            print(currentUser);
            print('=======');
            print(messageSender);
          }

          final messageWidget = MesageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MesageLine extends StatelessWidget {
  const MesageLine({this.sender, this.text, required this.isMe, super.key});
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Text(
                '$text',
                // '$text - $sender',
                style: TextStyle(
                    fontSize: 16,
                    color: isMe ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
