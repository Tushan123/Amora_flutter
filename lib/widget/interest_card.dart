import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final String interestName;
  final bool isEditing;
  final VoidCallback onPressd;
  const InterestCard(
      {super.key,
      required this.interestName,
      this.isEditing = false,
      required this.onPressd});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 150, minWidth: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: (isEditing == true)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        interestName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'AbrilFatface',
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Center(
                      child: IconButton(
                          onPressed: onPressd,
                          iconSize: 20,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    )
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    interestName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'AbrilFatface',
                        fontWeight: FontWeight.w300),
                  ),
                ),
        ));
  }
}
