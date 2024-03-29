import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  final String textData;
  const ContentBox({super.key, required this.textData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 225, 137)),
      child: Text(
        textData,
        style: const TextStyle(
            fontFamily: "Libre", fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }
}
