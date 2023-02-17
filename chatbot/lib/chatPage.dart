// ignore_for_file: file_names

import 'package:chatbot/model.dart';
import 'package:chatbot/widgets/chatMessageWidget.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'widgets/buildSubmit.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late bool isLoading;
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "OpenAI's ChatGPT",
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: botBackgroundColor,
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
              Visibility(
                visible: isLoading,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    //input field
                    _buildInput(),
                    //submit button
                    buildSubmit(isLoading),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _messages.length,
      controller: _scrollController,
      itemBuilder: ((context, index) {
        var message = _messages[index];

        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      }),
    );
  }
}
