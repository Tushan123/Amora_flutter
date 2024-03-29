import 'package:flutter/material.dart';

class TitleWithIcon extends StatelessWidget {
  final String textData;
  final Icon? icon;
  const TitleWithIcon({super.key, required this.textData, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(textData), IconButton(onPressed: null, icon: icon!)],
    );
  }
}
