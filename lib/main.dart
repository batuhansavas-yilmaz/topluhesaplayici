import 'package:device_preview/device_preview.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toplu_hesaplayici/kdvHesaplayicisi.dart';
import 'package:toplu_hesaplayici/komisyon.dart';
import 'package:toplu_hesaplayici/zraporu.dart';
import 'package:toplu_hesaplayici/vucutKitleEndeksi.dart';
import 'GorevButonlari.dart';
import 'admobIslemleri.dart';
import 'akvaryum.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

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
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("HesapMatik"),
        centerTitle: true,
        leading: IconButton(
          tooltip: "Bilgi",
          icon: Icon(Icons.info),
          onPressed: () {
            setState(() {
             myBanner.show();
            });
            showCupertinoModalPopup(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text("HesapMatik v2.3.1",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,),),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Destek: ",
                              style: TextStyle(fontSize:SizeConfig.blockSizeHorizontal * 4),
                            ),
                            Text("batuhansavasyilmaztr@gmail.com",
                                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3,fontWeight: FontWeight.bold
                                )),
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
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            text: Text(
              "Kdv",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => KdvHesaplayicisi()));
              });
            },
          ),
          GorevButonlari(
            image: Image.asset(
              "assets/zraporu.png",
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            text: Text(
              "Eksik Z Raporu",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ZRaporu()));
              });
            },
          ),
          GorevButonlari(
            image: Image.asset(
              "assets/aquarium.png",
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            text: Text(
              "Akvaryum",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Aquarium()));
              });
            },
          ),
          GorevButonlari(
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => KitleEndeksi()));
              });
            },
            text: Text(
              "Vücut Kitle Endeksi",
              style: TextStyle(fontSize:
               SizeConfig.blockSizeHorizontal * 4,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/love.png"),
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
          ),
          GorevButonlari(navigator: () {
            setState(() {
              myBanner.show();
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Komisyon()));
            });
          },
            text: Text(
              "Komisyon",
              style: TextStyle(fontSize:
              SizeConfig.blockSizeHorizontal * 4,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/commission.png"),
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  myBanner.show();
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: Text("Siz Seçin",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Eklenmesini İstediğiniz Yeni Hesaplayıcılar İçin Bizimle İletişime Geçebilirsiniz",
                                    style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("batuhansavasyilmaztr@gmail.com",
                                      style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3,fontWeight: FontWeight.bold)),
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
              child: Image(
                image: AssetImage("assets/loading.png"),
                height: SizeConfig.blockSizeVertical * 13,
                width: SizeConfig.blockSizeHorizontal * 30,
              ),
            ),
          ),


          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
