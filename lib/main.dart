
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toplu_hesaplayici/kdvHesaplayicisi.dart';
import 'package:toplu_hesaplayici/zraporu.dart';
import 'package:toplu_hesaplayici/vucutKitleEndeksi.dart';
import 'GorevButonlari.dart';
import 'admobIslemleri.dart';
import 'akvaryum.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue[900],
            scaffoldBackgroundColor: Colors.blue.shade50),
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
  BannerAd myBanner;

  void initState() {
    super.initState();
    AdmobIslemleri.admobInitialize();
    myBanner = AdmobIslemleri.buildBannerAd();
    myBanner.load();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("HesapMatik"),
        centerTitle: true,
        leading: IconButton(
          tooltip: "Bilgi",
          icon: Icon(Icons.info),
          onPressed: () {setState(() {
            myBanner.show();
          });
            showCupertinoModalPopup(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text("HesapMatik v2.0"),
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
      body: GridView.count(
        primary: false,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        children: [
          GorevButonlari(
            image: Image(
              image: AssetImage("assets/percentage.png"),
              height: 70,
            ),
            text: Text(
              "Kdv",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            navigator: () {setState(() {  myBanner.show();
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => KdvHesaplayicisi()));
            });

           },
          ),
          GorevButonlari(
            image: Image.asset(
              "assets/zraporu.png",
              width: 85,
              height: 85,
            ),
            text: Text(
              "Eksik Z Raporu",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {  myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ZRaporu()));
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
              "Akvaryum",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {  myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Aquarium()));
              });
            },
          ),
          GorevButonlari(
            navigator: () {
              setState(() {  myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => KitleEndeksi()));

              });},
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
          GorevButonlari(
            text: Text(""),
            image: Center(
              child: Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/loading.png"),
                  height: 80,
                ),
              ),
            ),
            navigator: () {
              setState(() {  myBanner.show();
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: Text("Siz Seçin"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Eklenmesini İstediğiniz Yeni Hesaplayıcılar İçin Bizimle İletişime Geçebilirsiniz",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
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
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ), SizedBox(
            height: 10,
          ), SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
