import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserLikeCard extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  const UserLikeCard(
      {super.key,
      required this.url,
      required this.height,
      required this.width});

  @override
  State<UserLikeCard> createState() => _UserLikeCardState();
}

class _UserLikeCardState extends State<UserLikeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: widget.url,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Image.asset("assets/images/portrait.jpg"),
          ),
        ),
      ),
    );
  }
}
