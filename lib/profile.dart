// ignore_for_file: prefer_const_constructors

import 'package:celebstar/providers/PageIndex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/GoogleSignin.dart';

class ProfilePage extends StatefulWidget {
  var userData;

  ProfilePage();
  ProfilePage.fromUser(this.userData);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData;

  final double coverHeight = 240;
  final double profileHeight = 144;

  String about =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehe";

  @override
  Widget build(BuildContext context) {
    userData = widget.userData;
    userData ??= FirebaseAuth.instance.currentUser;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildTop(),
        buildContent(context),
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: profileHeight / 2 + 10),
      child: Column(
        children: [
          Text(
            userData.displayName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            userData.email,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesomeIcons.slack),
              const SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.github),
              const SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.twitter),
              const SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.linkedin),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              IconButton(
                onPressed: () {
                  openDialog(context);
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              about,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(300, 50)),
            onPressed: () {
              Provider.of<GoogleSigninProvider>(context, listen: false)
                  .logout()
                  .then(
                (_) {
                  Provider.of<PageIndexProvider>(context, listen: false)
                      .setIndex(0);
                },
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: Colors.black,
            ),
            label: const Text("Logout"),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future openDialog(context) {
    var ctr = TextEditingController(text: about);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit About"),
        content: TextField(
          controller: ctr,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            hintText: "Enter your About",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancle"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                about = ctr.text;
              });
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  Widget buildSocialIcon(IconData icon) {
    return CircleAvatar(
      radius: 25,
      child: Center(
        child: Icon(
          icon,
          size: 32,
        ),
      ),
    );
  }

  Widget buildTop() {
    final double top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(userData.photoURL),
    );
  }

  Widget buildCoverImage() {
    return Container(
      color: Colors.grey,
      child: Image.network(
        "https://source.unsplash.com/random/",
        fit: BoxFit.cover,
        height: coverHeight,
        width: double.infinity,
      ),
    );
  }
}
