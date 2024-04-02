import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final getYesNoAnswer = GetYesNoAnswer();
  final ScrollController chatScrollController = ScrollController();

  List<Message> messageList = [];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.mine);
    messageList.add(newMessage);

    if (newMessage.text.endsWith('?')) {
      theirReply();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> theirReply() async {
    final theirMessage = await getYesNoAnswer.getAnswer();

    messageList.add(theirMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 300));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, // Offset
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
