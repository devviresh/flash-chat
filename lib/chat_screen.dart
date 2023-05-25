import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('message').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Chat'),
        actions: [
          IconButton(
              onPressed: () {
                // messageStream();
                // getMessages();
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: _firestore
                .collection('messages')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final messages = snapshot.data?.docs.reversed;
                List<MessageBubble> messageBubble = [];
                for (var message in messages!) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final messageTime = DateFormat.Hm()
                      .format(message.data()['timestamp'].toDate());
                  final messageWidget = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    time: messageTime,
                    isMe: messageSender == loggedInUser.email,
                  );
                  messageBubble.add(messageWidget);
                }
                return ListView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  children: messageBubble,
                );
              }
              return Container(
                child: Text('no messages here!'),
              );
            },
          )),
          Container(
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    messageText = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      hintText: 'Write your message'),
                )),
                TextButton(
                    onPressed: () {
                      _controller.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'timestamp': Timestamp.now()
                      });
                    },
                    child: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.sender,
      required this.text,
      required this.time,
      required this.isMe});

  final String sender;
  final String text;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(isMe ? 70.0 : 10.0, 8.0, isMe ? 10.0 : 70.0, 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
              style: TextStyle(fontSize: 12.0, color: Colors.black54)),
          SizedBox(height: 3.0),
          Material(
            elevation: 5.0,
            color: isMe ? Colors.blue : Colors.redAccent,
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(10.0) : Radius.circular(0.0),
                topRight: isMe ? Radius.circular(0.0) : Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 5.0,
                children: [
                  Text('$text',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  Text('$time',
                      style: TextStyle(fontSize: 10.0, color: Colors.white54))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
