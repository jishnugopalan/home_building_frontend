import 'package:flutter/material.dart';

class ChatMessage {
  final String messageContent;
  final String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Hello, how can I help you today?",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Hi, I have a question about my account.",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Sure, I'd be happy to help. What's your question?",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "I'm having trouble logging in.",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Ok, let me see if I can help you with that.",
        messageType: "receiver"),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Window"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: messages[index].messageType == "receiver"
                          ? Colors.grey[300]
                          : Colors.blue[200],
                    ),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .004),
            height: 60,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * .01),
                  child: SizedBox( 
                    width: MediaQuery.of(context).size.height * .385,
                    child: Expanded(
                  
                  child: TextField(
                    maxLines: null,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.keyboard),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                  ),
                ),
                
                SizedBox(
                  width: MediaQuery.of(context).size.height * .06,
                  height: MediaQuery.of(context).size.height * .06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                    onPressed: () {
                      _sendMessage();
                    },
                    child: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String text = _textEditingController.text;
    if (text.isNotEmpty) {
      ChatMessage message =
          ChatMessage(messageContent: text, messageType: "sender");
      setState(() {
        messages.add(message);
      });
      _textEditingController.clear();
    }
  }
}
