import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
