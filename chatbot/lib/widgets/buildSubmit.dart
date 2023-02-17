// ignore_for_file: file_names

import 'package:chatbot/constants.dart';
import 'package:flutter/material.dart';

Widget buildSubmit(bool isLoading) {
  return Visibility(
      visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.send_rounded,
            color: kGrayColor,
          ),
        ),
      ));
}
