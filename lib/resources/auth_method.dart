import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/storage_method.dart';

class AuthMethod {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //required String profilePicUrl,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
   try{
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty
          || file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
            print(cred.user!.uid);
           String photoUrl = await StorageMethods().uploadImageToStorage("profilePic", file, false);
        // Add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          //'profilePicUrl': profilePicUrl,
          'profilePicUrl': photoUrl,
          'followers': [],
          'following': [],
        });
        // await FirestoreMethods().uploadUserData(

        //     username, bio, cred.user!.uid, profilePicUrl, file);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
   }
    return res;
  }
  // Sign in with email and password
}