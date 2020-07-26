import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/auth/AuthForm.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (image != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('avatars')
              .child(authResult.user.uid + '.jpg');
          await ref.putFile(image).onComplete;
          final url = await ref.getDownloadURL();
          await Firestore.instance
              .collection('users')
              .document(authResult.user.uid)
              .setData({
            'username': username,
            'email': email,
            'image_url': url,
          });
        } else {
          await Firestore.instance
              .collection('users')
              .document(authResult.user.uid)
              .setData({
            'username': username,
            'email': email,
          });
        }
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials!';

      if (err.message != null) message = err.message;

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
