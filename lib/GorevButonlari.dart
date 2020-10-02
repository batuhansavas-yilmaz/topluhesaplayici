import 'package:flutter/material.dart';

class GorevButonlari extends StatelessWidget {
  Function navigator;
  Widget image;
  Widget text;

  GorevButonlari({this.navigator, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        color: Colors.white,
        onPressed: navigator,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            text,
          ],
        ),
      ),
    );
  }
}