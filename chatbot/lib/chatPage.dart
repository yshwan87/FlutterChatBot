// ignore_for_file: file_names

import 'dart:convert';

import 'package:chatbot/model.dart';
import 'package:chatbot/widgets/chatMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

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

  Future<String> generateResponse(String prompt) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": prompt,
          "temperature": 0,
          "max_tokens": 2000,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": "."
        },
      ),
    );

    Map<String, dynamic> newRes = jsonDecode(response.body);
    var multiline = newRes['choices'][0]['text'];
    var singleline = multiline.replaceAll("\n\n", "");
    return singleline;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Chat with AI",
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
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
                    _buildSubmit(),
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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(color: Colors.black),
          controller: _textController,
          decoration: const InputDecoration(
            hintText: "Write message...",
            hintStyle: TextStyle(color: Colors.black54),
          ),
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

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Colors.white,
        child: IconButton(
          onPressed: () {
            _textController.text.isEmpty ? "" : _setUserAndBotChat();
          },
          icon: const Icon(
            Icons.send_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  void _setUserAndBotChat() {
    setState(
      () {
        _messages.add(
          ChatMessage(
            text: _textController.text,
            chatMessageType: ChatMessageType.user,
          ),
        );
        isLoading = true;
      },
    );
    var input = "${_textController.text}.";
    _textController.clear();
    Future.delayed(const Duration(milliseconds: 50)).then((value) => _scrollDown());

    generateResponse(input).then(
      (value) {
        setState(
          () {
            isLoading = false;
            _messages.add(
              ChatMessage(
                text: value,
                chatMessageType: ChatMessageType.bot,
              ),
            );
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50)).then((value) => _scrollDown());
          },
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
