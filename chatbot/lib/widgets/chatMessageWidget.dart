// ignore_for_file: implementation_imports, file_names

import 'package:chatbot/model.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;

  const ChatMessageWidget({
    super.key,
    required this.text,
    required this.chatMessageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (chatMessageType == ChatMessageType.bot ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 230),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (chatMessageType == ChatMessageType.bot ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 10),
    //   padding: const EdgeInsets.all(16),
    //   color: chatMessageType == ChatMessageType.bot ? botBackgroundColor : backgroundColor,
    //   child: Row(
    //     children: [
    //       chatMessageType == ChatMessageType.bot
    //           ? Container(
    //               margin: const EdgeInsets.only(right: 16),
    //               child: CircleAvatar(
    //                 backgroundColor: avatarbackgroundColor,
    //                 child: Image.asset(
    //                   'assets/bot.png',
    //                   color: Colors.white,
    //                   scale: 1.5,
    //                 ),
    //               ),
    //             )
    //           : Container(
    //               margin: const EdgeInsets.only(right: 16),
    //               child: const CircleAvatar(
    //                 child: Icon(Icons.person),
    //               ),
    //             ),
    //       Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               padding: chatMessageType == ChatMessageType.bot ? const EdgeInsets.only(bottom: 30, left: 12) : const EdgeInsets.all(10),
    //               decoration: const BoxDecoration(
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(8),
    //                 ),
    //               ),
    //               child: Text(
    //                 text,
    //                 style: const TextStyle(
    //                     fontSize: 15,
    //                     color: Colors.white, //font color
    //                     fontStyle: FontStyle.italic),
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
