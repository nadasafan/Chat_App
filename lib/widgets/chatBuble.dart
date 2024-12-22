// widgets/chatBuble.dart
import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message, // Accept a message as a parameter
    required this.isSender, // Whether the bubble is for the sender or receiver
  });

  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft, // Dynamic alignment
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Padding inside the bubble
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.grey, // Different color for sender/receiver
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: isSender ? Radius.circular(30.0) : Radius.circular(0.0),
            bottomRight: isSender ? Radius.circular(0.0) : Radius.circular(30.0),
          ),
        ),
        child: Text(
          message, // Display the message
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForReceiver extends StatelessWidget {
  const ChatBubbleForReceiver({
    super.key,
    required this.message, // Accept a message as a parameter
    required this.isSender, // Whether the bubble is for the sender or receiver
  });

  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft, // Correct alignment
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Padding inside the bubble
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.greenAccent, // Different color for sender/receiver
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: isSender ? Radius.circular(30.0) : Radius.circular(0.0),
            bottomRight: isSender ? Radius.circular(0.0) : Radius.circular(30.0),
          ),
        ),
        child: Text(
          message, // Display the message
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
