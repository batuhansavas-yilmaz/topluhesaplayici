import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "package:toplu_hesaplayici/beygir.dart";
import 'package:toplu_hesaplayici/kdvHesaplayicisi.dart';
import 'package:toplu_hesaplayici/komisyon.dart';
import 'package:toplu_hesaplayici/zraporu.dart';
import 'package:toplu_hesaplayici/vucutKitleEndeksi.dart';
import 'package:toplu_hesaplayici/binekArac.dart';
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
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue.shade50),
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
      drawer: Container(
        width: SizeConfig.blockSizeHorizontal * 50,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 12,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xff2296F3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: SizeConfig.blockSizeVertical * 0.40,
                              offset: Offset(
                                  0, SizeConfig.blockSizeVertical * 0.25),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Wrap(
                            children: [
                              Container(
                                child: Text(
                                  "İletişim",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5.5,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius:
                                              SizeConfig.blockSizeVertical *
                                                  0.8,
                                          offset: Offset(
                                              SizeConfig.blockSizeVertical *
                                                  0.3,
                                              SizeConfig.blockSizeVertical *
                                                  0.4),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BaglantiButon(
                      link: "https://www.instagram.com/_batuhansy/",
                      image: "assets/instagram.png",
                      title: "Instagram",
                    ),
                    Divider(
                      height: SizeConfig.blockSizeVertical * 1.20,
                    ),
                    BaglantiButon(
                      link: "https://facebook.com/batuylmzz/",
                      image: "assets/facebook.png",
                      title: "Facebook",
                    ),
                    Divider(
                      height: SizeConfig.blockSizeVertical * 1.20,
                    ),
                    BaglantiButon(
                      link: "https://twitter.com/pesindeyizz",
                      image: "assets/twitter.png",
                      title: "Twitter",
                    ),
                    Divider(
                      height: SizeConfig.blockSizeVertical * 1.20,
                    ),
                    BaglantiButon(
                      link: "mailto:batuhansavasyilmaztr@gmail.com",
                      image: "assets/gmail.png",
                      title: "Mail",
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 7.45,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff2296F3),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: SizeConfig.blockSizeVertical * 0.40,
                              offset: Offset(
                                  0, SizeConfig.blockSizeVertical * -0.15)),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.mail),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          "HesapMatik",
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: GridView.extent(
        primary: false,
        crossAxisSpacing: 2,
        mainAxisSpacing: 3,
        maxCrossAxisExtent: 230,
        children: [
          GorevButonlari(
            image: Image(
                image: AssetImage("assets/percentage.png"),
                height: SizeConfig.blockSizeVertical * 12.5),
            text: Text(
              "Kdv",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 4.0,
                  fontWeight: FontWeight.bold),
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
              height: SizeConfig.blockSizeVertical * 11,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            text: Text(
              "Eksik Z Raporu",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.53,
                  fontWeight: FontWeight.bold),
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
              height: SizeConfig.blockSizeVertical * 11,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            text: Text(
              "Akvaryum",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.bold),
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
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/love.png"),
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
          ),
          GorevButonlari(
            navigator: () {
              setState(
                () {
                  myBanner.show();
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Komisyon()));
                },
              );
            },
            text: Text(
              "Komisyon",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/commission.png"),
              height: SizeConfig.blockSizeVertical * 11,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
          ),
          GorevButonlari(
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => BinekArac()));
              });
            },
            text: Text(
              "%70'lik Binek Araç Giderleri",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.2,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/car.png"),
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
          ),
          GorevButonlari(
            navigator: () {
              setState(() {
                myBanner.show();
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Beygir()));
              });
            },
            text: Text(
              "kW ⇄ hp",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 3,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/horse-power.png"),
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  myBanner.show();
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: Text(
                                "Siz Seçin",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Eklenmesini İstediğiniz Yeni Hesaplayıcılar İçin Bizimle İletişime Geçebilirsiniz.",
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
                                    ),
                                  ),
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
          ),
          SizedBox(
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

TextStyle appBarStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      color: Colors.black,
      blurRadius: SizeConfig.blockSizeVertical * 0.70,
      offset: Offset(SizeConfig.blockSizeVertical * 0.35,
          SizeConfig.blockSizeVertical * 0.25),
    ),
  ],
);

/*

 mobil ekran için
style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 4.5,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: Image(
              image: AssetImage("assets/car.png"),
              height: SizeConfig.blockSizeVertical * 12.2,
              width: SizeConfig.blockSizeHorizontal * 30,


 */
