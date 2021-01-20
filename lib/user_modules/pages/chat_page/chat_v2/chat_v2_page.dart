import 'package:flutter/material.dart';
import 'package:hourli/global_module/components/chat_components/flat_chat_message.dart';
import 'package:hourli/global_module/components/chat_components/flat_message_input_box.dart';
import 'package:hourli/global_module/components/chat_components/flat_page_wrapper.dart';

class ChatPage extends StatefulWidget {
  static final String id = "ChatPage";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: FlatPageWrapper(
          backgroundColor: Colors.white60,
          scrollType: ScrollType.floatingHeader,
          reverseBodyList: false,
          children: [
            FlatChatMessage(
              message: "Hello World!, This is the first message.",
              messageType: MessageType.achievement,
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message: "Typing another message from the input box.",
              messageType: MessageType.sent,
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message: "Message Length Small.",
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message:
                  "Message Length Large. This message has more text to configure the size of the message box.",
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message: "Meet me tomorrow at the coffee shop.",
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message: "Around 11 o'clock.",
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message:
                  "Flat Social UI kit is going really well. Hope this finishes soon.",
              showTime: true,
              time: "2 mins ago",
            ),
            FlatChatMessage(
              message: "Final Message in the list.",
              showTime: true,
              time: "2 mins ago",
            ),
          ],
          footer: FlatMessageInputBox(
            roundedCorners: true,
            // prefix: FlatActionButton(
            //   iconData: Icons.add,
            //   iconSize: 24.0,
            // ),
            // suffix: FlatActionButton(
            //   iconData: Icons.image,
            //   iconSize: 24.0,
            // ),
          ),
        ),
      ),
    );
  }
}
