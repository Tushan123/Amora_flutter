import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool?)? onChange;
  const CheckBox(
      {super.key,
      required this.text,
      required this.value,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
