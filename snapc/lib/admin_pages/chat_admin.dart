import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapc/components/my_app_bar.dart';

class ChatAdmin extends StatefulWidget {
  final String email;
  const ChatAdmin({
    super.key,
    required this.email,
  });

  @override
  _ChatAdminState createState() => _ChatAdminState();
}

class _ChatAdminState extends State<ChatAdmin> {
  late User currentUser;

  // * firestore
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String pengirim;
  late final String otherUserEmail;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
    pengirim = currentUser.email.toString();
    //* dibawah ini akan di ubah menjadi widget.email dari halaman sebelumnya di admin dasboard
    otherUserEmail = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: 'C H A T'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('sender', isEqualTo: pengirim)
                  .where('receiver', isEqualTo: otherUserEmail)
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  var messageData = message.data() as Map<String, dynamic>;
                  var messageText = messageData['text'];
                  var messageSender = messageData['sender'];

                  var messageWidget = MessageWidget(
                    sender: messageSender,
                    text: messageText,
                    isMe: pengirim == messageSender,
                  );
                  if ((pengirim == messageSender &&
                          otherUserEmail == messageData['receiver']) ||
                      (pengirim == messageData['receiver'] &&
                          otherUserEmail == messageSender)) {
                    messageWidgets.add(messageWidget);
                  }
                }

                return ListView(
                  children: messageWidgets,
                );
              },
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Send a message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _firestore.collection('messages').add({
      'text': text,
      'sender': pengirim,
      'receiver': otherUserEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageWidget({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
  });

  String getSenderName() {
    return sender.split('@').first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: isMe
                  ? const EdgeInsets.only(left: 30.0)
                  : const EdgeInsets.only(right: 30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.green[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    getSenderName(),
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            180, // Atur lebar sesuai kebutuhan Anda
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
