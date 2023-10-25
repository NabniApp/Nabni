import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

class Communication extends StatefulWidget {
  const Communication({super.key});

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return CometChatConversationsWithMessages(
        conversationsConfiguration: ConversationsConfiguration(
            showBackButton: false, title: 'المحادثات', appBarOptions: []),
        messageConfiguration: MessageConfiguration());
  }
}
