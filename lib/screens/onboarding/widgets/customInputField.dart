import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final String text;
  final TextInputType type;
  final Function(String)? onChange;
  final TextEditingController? controller;
  const UserInput(
      {super.key,
      required this.text,
      required this.type,
      this.onChange,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: type,
        onChanged: onChange,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            hintText: text,
            contentPadding: const EdgeInsets.all(20)),
      ),
    );
  }
}
