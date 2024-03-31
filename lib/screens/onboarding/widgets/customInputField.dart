// ignore_for_file: file_names

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
                borderSide: const BorderSide(color: Colors.white)),
            hintText: text,
            contentPadding: const EdgeInsets.all(20)),
      ),
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController country;
  final TextEditingController phone;
  const PhoneNumberInput(
      {super.key, required this.country, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Expanded(
            child: TextField(
              controller: country,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintText: "+91",
                  contentPadding: const EdgeInsets.all(20)),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                hintText: "Your phone number",
                contentPadding: const EdgeInsets.all(20)),
          ),
        ),
      ],
    );
  }
}
