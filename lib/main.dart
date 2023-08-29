import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import "beygir.dart";
import 'kdvHesaplayicisi.dart';
import 'komisyon.dart';
import 'zraporu.dart';
import 'vucutKitleEndeksi.dart';
import 'binekArac.dart';
import 'yardimcilar.dart';

import 'akvaryum.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 1,
              backgroundColor: Color.fromARGB(255, 236, 236, 236),
              foregroundColor: Colors.black),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue, elevation: 1),
      ),
      title: "HesapMatik",
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, HomePage(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/kdv':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(
                      context, KdvHesaplayicisi(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/zraporu':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, ZRaporu(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/binekarac':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, BinekArac(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/komisyon':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, Komisyon(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/akvaryum':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, Aquarium(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/vucut':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, KitleEndeksi(),
                      dragWithMouse: true),
                ),
              );
            });
          case '/beygir':
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, Beygir(),
                      dragWithMouse: true),
                ),
              );
            });

          default:
            return CupertinoPageRoute(builder: (context) {
              return MaxWidthBox(
                maxWidth: 1200,
                background: Container(color: const Color(0xFFF5F5F5)),
                child: ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(context, HomePage(),
                      dragWithMouse: true),
                ),
              );
            });
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HesapMatik",
        ),
        centerTitle: true,
      ),
      body: GridView.extent(
        primary: false,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        padding: EdgeInsets.all(30.0),
        maxCrossAxisExtent: 230,
        children: [
          GorevButton(
            logo: "assets/percentage.png",
            altisim: "53",
            sayfaismi: '/kdv',
          ),
          GorevButton(
            logo: "assets/zraporu.png",
            altisim: "53",
            sayfaismi: '/zraporu',
          ),
          GorevButton(
            logo: "assets/car.png",
            altisim: "53",
            sayfaismi: '/binekarac',
          ),
          GorevButton(
            logo: "assets/commission.png",
            altisim: "53",
            sayfaismi: '/komisyon',
          ),
          GorevButton(
            logo: "assets/aquarium.png",
            altisim: "53",
            sayfaismi: '/akvaryum',
          ),
          GorevButton(
            logo: "assets/love.png",
            altisim: "53",
            sayfaismi: '/vucut',
          ),
          GorevButton(
            logo: "assets/horse-power.png",
            altisim: "53",
            sayfaismi: '/beygir',
          ),
        ],
      ),
    );
  }
}
