import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import 'package:celebstar/appBar.dart';
import 'package:celebstar/card.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
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
                  [
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                  ],
                ),
                CardList(
                  "Hollywood",
                  [
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                  ],
                ),
                CardList(
                  "Bollywood",
                  [
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                  ],
                ),
                CardList(
                  "Tollywood",
                  [
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                  ],
                ),
                CardList(
                  "Jollywood",
                  [
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                    ElevatedCard("Alec Benjiman"),
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: const AppBarWidget(),
        drawer: const NavDrawer(),
      ),
      theme: ThemeData.dark(),
    );
  }
}
