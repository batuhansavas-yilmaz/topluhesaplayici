import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class GorevButonlari extends StatelessWidget {
  Function navigator;
  Widget image;
  Widget text;

  GorevButonlari({this.navigator, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      // ignore: deprecated_member_use
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

class BaglantiButon extends StatelessWidget {
  @override
  String link;
  String image;
  String title;

  BaglantiButon({this.image, this.link,this.title});

  Widget build(BuildContext context) {
    return Container(height: SizeConfig.blockSizeVertical * 8,

      child: Center(
        child: ListTile(
          onTap: () {
            String url = link;
            launch(url);
          },
          leading:  Image(
            image: AssetImage(image),
            height: SizeConfig.blockSizeVertical * 8,
            width: SizeConfig.blockSizeHorizontal * 8,
          ),
          title: Text(title,style: TextStyle(
        fontSize: SizeConfig.blockSizeHorizontal * 4)),
        ),
      ),
    );
  }
}



