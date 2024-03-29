import 'package:amora/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../models/model.dart';

class UserCard extends StatefulWidget {
  final User user;
  final MatchEngine engine;
  const UserCard({
    super.key,
    required this.user,
    required this.engine,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  List<Widget> generateItems() {
    List<Widget> images = [];
    for (int i = 1; i < widget.user.imageUrls.length; i++) {
      images.add(
        SizedBox(
          height: 580,
          child: CachedNetworkImage(
            imageUrl: widget.user.imageUrls[i]['url'],
            placeholder: (context, url) => Image.asset(
              "assets/images/portrait.jpg",
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => const Icon(
                Icons.error), // Widget to display if image fails to load
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: 680,
                    child: CachedNetworkImage(
                      imageUrl: widget.user.imageUrls[0]['url'],
                      placeholder: (context, url) => Image.asset(
                        "assets/images/portrait.jpg",
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons
                          .error), // Widget to display if image fails to load
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.user.name}, ${widget.user.age}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Couture'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              widget.user.jobTitle,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Couture'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
                Container(
                  // height: 500,
                  color: const Color.fromARGB(255, 252, 247, 178),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "About Me ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Superior'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.user.bio,
                            style: const TextStyle(
                                wordSpacing: 2.5,
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Superior'),
                          ),
                          widget.user.interests != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Interests",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Superior'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: widget.user.interests!
                                            .map((interest) => InterestCard(
                                                  interestName: interest,
                                                  onPressd: () {},
                                                ))
                                            .toList())
                                  ],
                                )
                              : const SizedBox(),
                        ]),
                  ),
                ),
                ...generateItems(),
                Container(
                  //  height: 400,
                  color: const Color.fromARGB(255, 252, 247, 178),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Ionicons.location_sharp,
                              size: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${widget.user.name[0]}`s location",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Superior'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          widget.user.location,
                          style: const TextStyle(
                              wordSpacing: 2.5,
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Superior'),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.amber,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  widget.engine.currentItem?.nope();
                                },
                                icon: const Icon(
                                  Icons.thumb_down,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 20,
              bottom: 30,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.amber,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      widget.engine.currentItem?.like();
                    },
                    icon: const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
