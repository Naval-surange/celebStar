import 'package:flutter/material.dart';
import 'package:celebstar/threadCard.dart';

class ExplorePage extends StatelessWidget {
  var threadData = {
    "title": "Exestance of Alec Benjiman",
    "celeb": "Alec Benjiman",
    "image": "assets/images/thread.jpeg",
    "imageURL": "https://source.unsplash.com/random/200x200",
    "description":
        "Does alec benjiman exists or he is just a myth created by illuminati to make people believe that he is a real person?",
    "likes": "420",
    "comments": "69",
    "views": "1111",
    "time": "100",
  };

  @override
  Widget build(BuildContext context) {
    var threads = [
      ThreadCard(threadData),
      ThreadCard(threadData),
      ThreadCard(threadData),
      ThreadCard(threadData),
      ThreadCard(threadData),
      ThreadCard(threadData),
    ];

    return SingleChildScrollView(
      child: ThreadList(
        threads,
      ),
    );
  }
}
