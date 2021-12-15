import 'package:chat_app_encyrpt/screens/auth_screen.dart';
import 'package:chat_app_encyrpt/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    //primarySwatch: Colors.pink,
    backgroundColor: Colors.blueAccent,
    //accentColorBrightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App Encyrpt',
      theme: theme.copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0.8),
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.deepPurple),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
