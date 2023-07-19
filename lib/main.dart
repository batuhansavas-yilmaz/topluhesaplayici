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
import 'GorevButonlari.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue.shade50),
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
            return MaterialPageRoute(builder: (context) {
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
            return MaterialPageRoute(builder: (context) {
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

          default:
            return MaterialPageRoute(builder: (context) {
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 3,
        padding: EdgeInsets.all(10.0),
        maxCrossAxisExtent: 230,
        children: [
          GorevButton(
            logo: "assets/car.png",
            altisim: "53",
            sayfaismi: '/kdv',
          ),
          GorevButton(
            logo: "assets/aquarium.png",
            altisim: "53",
            sayfaismi: '/kdv',
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
      blurRadius: 0.70,
      offset: Offset(0.35, 0.25),
    ),
  ],
);
