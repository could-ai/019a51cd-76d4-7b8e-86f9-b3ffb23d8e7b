import 'package:flutter/material.dart';

// A data model for a single chat message
class Message {
  final String text;
  final bool isFromUser;

  Message({required this.text, required this.isFromUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add the initial welcome message from the AI
    _addBotMessage(
        "Main tumhara “LovableSeek” AI assistant hoon — ek samajhdaar, friendly aur helpful AI jo tumhare har sawaal ka simple aur pyaar bhara jawab deta hai 💫\n\nChalo shuru karte hain! Batao, aaj kis cheez mein madad kar sakta hoon? 🙂");
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, Message(text: text, isFromUser: true));
    });

    // Simulate a bot response
    Future.delayed(const Duration(milliseconds: 500), () {
      _addBotMessage("Ye to bahut accha sawaal hai! ✨ Main iske baare mein soch raha hoon...");
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.insert(0, Message(text: text, isFromUser: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LovableSeek AI ❤️'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isUser = message.isFromUser;
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isUser ? Colors.pink[200] : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            message.text,
            style: TextStyle(color: isUser ? Colors.white : Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Aapka sawaal yahan likhein...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.pinkAccent),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}
