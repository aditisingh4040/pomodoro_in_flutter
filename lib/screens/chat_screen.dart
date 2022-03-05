
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoro_in_flutter/constants_flash.dart';

class ChatScreen extends StatefulWidget {
  static String id ='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser =user;
      }
    } catch(e) {
      print(e);
    }
  }

  //void getMessages() async {
   // final messagess = await firestore.collection('messagess').get();
    //for (var message in messagess.documents) {
      //print(message.data);
    //}
  //}

  void messagesStream()async {
    await for (var snapshots in  firestore.collection('messagess').snapshots()) {
     for(var message in snapshots.docs) {
       print(message.data);
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
 //              _auth.signOut();
  //             Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder <QuerySnapshot>(
              stream: firestore.collection('messagess').snapshots(),
              builder: (context, snapshots) {
                if(snapshots.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                  final messages = snapshots.data.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                   final messageText = message.data();
                   final messageSender = message.data();

                    final messageWidget =
                         Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: messageWidgets,
                  );

              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText =value;
                      },
                      decoration: kMessageTextFieldDecoration
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                     //messageText + loggedInUser.email
                      firestore.collection('messagess').add({
                        'text':messageText,
                        'sender':loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
