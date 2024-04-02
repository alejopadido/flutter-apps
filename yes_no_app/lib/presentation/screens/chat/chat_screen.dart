import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/their_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/share/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.eyaldror.com/wp-content/uploads/2017/08/chatbot-app-1024x1024.jpg'),
          ),
        ),
        title: const Text('ChatBot 🤖'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    final mainContent = chatProvider.messageList.isEmpty
        ? const Expanded(
            child: Center(
              child: Text('No messages yet...'),
            ),
          )
        : Expanded(
            child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return (message.fromWho == FromWho.theirs)
                    ? TheirMessageBubble(
                        message: message,
                      )
                    : MyMessageBubble(
                        message: message,
                      );
              },
            ),
          );

    return SafeArea(
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            mainContent,
            // !Message Text Box
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
