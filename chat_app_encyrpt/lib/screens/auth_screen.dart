import 'package:chat_app_encyrpt/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) {
    setState(() {
      isLoading = true;
    });
    if (isLogin) {
      //TODO: Hesap varsa giriş yap
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        print(user);
      }).catchError((error) {
        print(error);
        setState(() {
          isLoading = false;
        });
        Get.snackbar("Hata", "Giriş Yaparken Bir Sorunla Karşılaşıldı $error",
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.error),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
      });
    } else {
      //TODO: Hesap yoksa kayıt ol
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print(user);
        //TODO: Firestore'e kayıt
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set({'username': username, 'email': email});
      }).catchError((error) {
        print(error);
        setState(() {
          isLoading = false;
        });
        Get.snackbar("Hata", "Kayıt Yapılırken Bir Sorunla Karşılaşıldı $error",
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.error),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: AuthForm(_submitAuthForm, isLoading));
  }
}