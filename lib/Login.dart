import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:celebstar/providers/GoogleSignin.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Image.asset(
            "assets/images/banner.png",
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              "Hey There,\nWelcome Back",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: const Text(
              "Login to your account to continue",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(300, 50)),
            onPressed: () {
              final googleProvider =
                  Provider.of<GoogleSigninProvider>(context, listen: false);
              googleProvider.googleLogin();
            },
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Color.fromARGB(255, 192, 173, 0),
            ),
            label: const Text("SignUp using Google"),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Already hay a account? Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
