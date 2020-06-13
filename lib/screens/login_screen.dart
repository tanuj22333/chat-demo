import 'package:chatapp/screens/all_chat_list_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Email: yourEmail@gmail.com"),
            const SizedBox(height: 20),
            Text("Password: *******************"),
            const SizedBox(height: 20),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(12),
              onPressed: () => _loginPressed(context),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  void _loginPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AllChatListScreen()),
    );
  }
}
