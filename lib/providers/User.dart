import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserClass extends ChangeNotifier {
  String? _uid;
  String? _displayName;
  String? _about;
  String? _photoUrl;
  String? _email;
  String? _phoneNumber;

  UserClass(this._uid) {
    loadFromFirebase();
  }

  get uid => _uid;
  get displayName => _displayName;
  get about => _about;
  get photoUrl => _photoUrl;
  get email => _email;
  get phoneNumber => _phoneNumber;

  set uid(dynamic value) {
    loadFromFirebase();
    _uid = value;
    notifyListeners();
  }

  set displayName(dynamic value) {
    loadFromFirebase();
    _displayName = value;
    notifyListeners();
  }

  set about(dynamic value) {
    loadFromFirebase();
    _about = value;
    notifyListeners();
  }

  set photoUrl(dynamic value) {
    loadFromFirebase();
    _photoUrl = value;
    notifyListeners();
  }

  set email(dynamic value) {
    loadFromFirebase();
    _email = value;
    notifyListeners();
  }

  set phoneNumber(dynamic value) {
    loadFromFirebase();
    _phoneNumber = value;
    notifyListeners();
  }

  createOnFirebase() async {
    var x = FirebaseFirestore.instance.collection("users").doc(_uid);
    if (x != null) {
      return;
    }

    _displayName = FirebaseAuth.instance.currentUser?.displayName;
    _photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    _email = FirebaseAuth.instance.currentUser?.email;
    _phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    await pushToFirebase();
  }

  pushToFirebase() async {
    var userDoc = FirebaseFirestore.instance.collection("users").doc(_uid);
    var json = toJson();
    await userDoc.set(json, SetOptions(merge: true));
    notifyListeners();
  }

  loadFromFirebase() async {
    var userDoc = FirebaseFirestore.instance.collection("users").doc(_uid);
    var json = await userDoc.get();
    fromJson(json.data());
    notifyListeners();
  }

  fromJson(Map<String, dynamic>? json) {
    _displayName = json?["displayName"];
    _about = json?["about"];
    _photoUrl = json?["photoUrl"];
    _email = json?["email"];
    _phoneNumber = json?["phoneNumber"];
  }

  Map<String, dynamic> toJson() => {
        "uid": _uid,
        "displayName": _displayName,
        "about": _about,
        "photoUrl": _photoUrl,
        "email": _email,
        "phoneNumber": _phoneNumber,
      };

  Stream<UserClass> getUserStream() {
    var userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
    return userDoc.snapshots().map((snapshot) {
      var user = UserClass(snapshot.data()?["uid"]);
      user.fromJson(snapshot.data());
      return user;
    });
  }
}
