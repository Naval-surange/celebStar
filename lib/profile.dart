// ignore_for_file: prefer_const_constructors

import 'package:celebstar/providers/PageIndex.dart';
import 'package:celebstar/providers/firebaseStorage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/GoogleSignin.dart';
import 'package:celebstar/providers/User.dart';

class ProfilePage extends StatefulWidget {
  var uid;

  // ProfilePage();
  ProfilePage(this.uid);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? uid;
  late UserClass user;
  final double coverHeight = 240;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    uid = widget.uid;
    uid ??= FirebaseAuth.instance.currentUser?.uid;
    user = UserClass(uid);

    return StreamBuilder<UserClass>(
      stream: user.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userData = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              buildTop(userData),
              buildContent(context, userData),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildContent(BuildContext context, UserClass userData) {
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
                  openDialog(context, userData);
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
              userData.about ?? " ",
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

  Future openDialog(context, UserClass userData) {
    var ctr = TextEditingController(text: userData.about);
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
            onPressed: () async {
              user.about = ctr.text;
              await user.pushToFirebase();
              Navigator.of(context).pop();
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

  Widget buildTop(UserClass userData) {
    final double top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: top,
          child: buildProfileImage(userData),
        ),
        Positioned(
          top: top,
          left: MediaQuery.of(context).size.width - 150,
          child: buildEdit(userData),
        ),
      ],
    );
  }

  Widget buildEdit(UserClass userData) {
    Storage storage = Storage();
    return IconButton(
      onPressed: () async {
        final results = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.image,
        );
        if (results == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No image picked"),
            ),
          );
        }

        final path = results?.files.single.path;
        final filename = userData.uid;
        String? url = await storage.uploadFile(path, filename);
        user.photoUrl = url;
        await user.pushToFirebase();
      },
      icon: Icon(Icons.edit),
    );
  }

  Widget buildProfileImage(userData) {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(userData.photoUrl),
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
