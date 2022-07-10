import 'package:flutter/material.dart';
import 'package:celebstar/card.dart';

class HomePage extends StatelessWidget {
  var cards = [
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
    ElevatedCard("Alec Benjiman"),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            CardList(
              "Most Viewed",
              [...cards],
            ),
            CardList(
              "Hollywood",
              [...cards],
            ),
            CardList(
              "Bollywood",
              [...cards],
            ),
            CardList(
              "Tollywood",
              [...cards],
            ),
            CardList(
              "Jollywood",
              [...cards],
            ),
          ],
        ),
      ),
    );
  }
}
