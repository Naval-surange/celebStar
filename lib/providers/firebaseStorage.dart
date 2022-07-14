import 'dart:io'; // for File

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
import 'package:celebstar/providers/User.dart';

class Storage {
  final firebaseStorage.FirebaseStorage storage =
      firebaseStorage.FirebaseStorage.instance;

  Future<String?> uploadFile(String? filePath, String? fileName) async {
    File file = File(filePath ?? '');
    try {
      await storage.ref("$fileName").putFile(file);
      String url = await storage.ref("$fileName").getDownloadURL();
      return url;
    } on firebaseCore.FirebaseException catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
