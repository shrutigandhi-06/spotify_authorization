import 'package:flutter/material.dart';
import 'accessToken.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Get Access Token'),
          textColor: Colors.white,
          color: Colors.teal,
          onPressed: () {
            getAccessToken();
          },
        ),
      ),
    );
  }
}
