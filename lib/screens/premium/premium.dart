import 'package:flutter/material.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
      child: Column(
        children: [
          const Text(
            "Get your plans to get more matches",
            style: TextStyle(fontFamily: "Couture"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text("Premium ${index + 1}")),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      //Container(
      //   height: 660,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     color: Colors.amber,
      //   ),
      //   child: const Center(child: Text("Premium")),
      // ),
    );
  }
}
