// pages/chat_page.dart
import 'package:chat_app/models/massages.dart'; // Removed duplicate import
import 'package:chat_app/widgets/chatBuble.dart'; // Assuming this widget is already implemented
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static String id = 'chatpage';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Customize your app bar color
        title: Row(
          children: [
            Image.asset('assets/images/scholar.png'), // Your app's logo
            const Text(
              "Chat",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // StreamBuilder to listen for real-time updates to the Firestore collection
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                // Handle loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // If no messages, show a message saying "No messages yet"
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }

                // Map Firestore documents to the Messages model
                List<Massages> messageList = snapshot.data!.docs
                    .map((doc) => Massages.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                // Display messages in a ListView
                return ListView.builder(
                  reverse: true, // To show the most recent message at the bottom
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final message = messageList[index].massage;
                    final isSender = messageList[index].isSender;

                    // Corrected return statement with conditional logic
                    return isSender
                        ? ChatBubble(message: message, isSender: isSender)
                        : ChatBubbleForReceiver(message: message, isSender: isSender);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    // Handle message submission
                    if (_controller.text.isNotEmpty) {
                      // Send message to Firestore
                      messages.add({
                        'message': _controller.text,
                        'isSender': true, // Assuming current user is the sender
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _controller.clear(); // Clear the input field after sending
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
