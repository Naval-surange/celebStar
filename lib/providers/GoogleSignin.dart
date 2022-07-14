import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:celebstar/providers/User.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  get user => _user;

  Future googleLogin() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) {
      return null;
    }
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credintial = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credintial);

    var user = UserClass(FirebaseAuth.instance.currentUser?.uid);
    await user.createOnFirebase();

    notifyListeners();
  }

  Future logout() async {
    await googleSignin.signOut();
    _user = null;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
