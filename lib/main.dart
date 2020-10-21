import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:toplu_hesaplayici/kdvHesaplayicisi.dart';
import 'package:toplu_hesaplayici/zraporu.dart';
import 'package:toplu_hesaplayici/vucutKitleEndeksi.dart';
import 'GorevButonlari.dart';
import 'akvaryum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: "HesapMatik",

          debugShowCheckedModeBanner: false,
          home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Renkler.arkaPlanRenk,
      appBar: AppBar(
        backgroundColor: Renkler.appBarRenk
        ,
        title: Text("HesapMatik"),
        centerTitle: true,
        leading: IconButton(
          tooltip: "Bilgi",
          icon: Icon(Icons.info),
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text("HesapMatik v1.0"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Destek: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("batuhansavasyilmaztr@gmail.com",
                                style: TextStyle(fontSize: 12.20)),
                          ],
                        ),
                        actions: [
                          IconButton(
                            tooltip: "Kapat",
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ]));
          },
        ),
      ),
      body: GridView.count(primary: false,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        children: [
          GorevButonlari(
            image: Image(
              image: AssetImage("assets/percentage.png"),
              height: 70,
            ),
            text: Text(
              "Kdv Hesaplayıcı",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => KdvHesaplayicisi()));
            },
          ),
          GorevButonlari(
            image: Image.asset(
              "assets/zraporu.png",
              width: 85,
              height: 85,
            ),
            text: Text(
              "Eksik Z Raporu Bulma",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>ZRaporu()));
              });
            },
          ),
          GorevButonlari(
            image: Image.asset(
              "assets/aquarium.png",
              width: 75,
              height: 75,
            ),
            text: Text(
              "Akvaryum Litre Hesaplayıcı",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>Aquarium()));
              });
            },
          ),
          GorevButonlari(
            navigator: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => KitleEndeksi()));
            },
            text: Text(
              "Vücut Kitle Endeksi",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/love.png"),
              height: 70,
            ),
          ),
        ],
      ),
    );
  }
}

class Renkler {
  static Color appBarRenk = Colors.blue[900];
  static Color arkaPlanRenk = Colors.blue.shade50;
}
