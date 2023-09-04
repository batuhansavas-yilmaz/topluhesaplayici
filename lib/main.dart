import 'package:advanced_in_app_review/advanced_in_app_review.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toplu_hesaplayici/yakit.dart';
import 'package:toplu_hesaplayici/yuzde.dart';

import "beygir.dart";
import 'kdvHesaplayicisi.dart';
import 'komisyon.dart';
import 'zraporu.dart';
import 'vucutKitleEndeksi.dart';
import 'binekArac.dart';
import 'tools/yardimcilar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'akvaryum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color.fromARGB(255, 0, 135, 245),
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr', 'TR'), // Türkçe
      ],
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Color.fromARGB(255, 236, 236, 236),
                foregroundColor: Colors.black),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 0, 135, 245),
            elevation: 1,
          )),
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
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, HomePage(),
                    dragWithMouse: true),
              );
            });
          case '/kdv':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(
                    context, KdvHesaplayicisi(),
                    dragWithMouse: true),
              );
            });
          case '/zraporu':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, ZRaporu(),
                    dragWithMouse: true),
              );
            });
          case '/binekarac':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, BinekArac(),
                    dragWithMouse: true),
              );
            });
          case '/komisyon':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, Komisyon(),
                    dragWithMouse: true),
              );
            });
          case '/akvaryum':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, Aquarium(),
                    dragWithMouse: true),
              );
            });
          case '/vucut':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, KitleEndeksi(),
                    dragWithMouse: true),
              );
            });
          case '/beygir':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, Beygir(),
                    dragWithMouse: true),
              );
            });
          case '/yakit':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, YakitTuketimi(),
                    dragWithMouse: true),
              );
            });
          case '/yuzde':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, Yuzde(),
                    dragWithMouse: true),
              );
            });

          default:
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: [
                  Condition.equals(name: MOBILE, value: 450),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, HomePage(),
                    dragWithMouse: true),
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
  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 400));
    FlutterNativeSplash.remove();
  }

  // late BannerAd? _bannerAd;
  // bool _isBannerAdReady = false;
  // void _loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: mainReklam,
  //     size: AdSize.banner,
  //     request: requesT,
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         _bannerAd!.dispose();
  //       },
  //     ),
  //   );

  //   _bannerAd!.load();
  // }

  @override
  void initState() {
    super.initState();
    initialization();
    initPlatformState();
    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(1)
        .setMinLaunchTimes(1)
        .setMinSecondsBeforeShowDialog(4)
        .monitor();
    // _loadBannerAd();
  }

  void dispose() {
    super.dispose();
    // _bannerAd!.dispose();
  }

  // ignore: unused_field
  String _platformVersion = 'Unknown';
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await AdvancedInAppReview.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "HesapMatik",
          ),
          centerTitle: true,
        ),
        body: GridView.extent(
          childAspectRatio: 0.85,
          primary: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 1,
          padding: EdgeInsets.all(30.0),
          maxCrossAxisExtent: 200,
          children: [
            GorevButton(
              logo: "assets/percentage.png",
              altisim: "KDV \nHesaplayıcısı",
              sayfaismi: '/kdv',
            ),
            GorevButton(
              logo: "assets/car.png",
              altisim: "%70'lik Binek Araç Giderleri",
              sayfaismi: '/binekarac',
            ),
            GorevButton(
              logo: "assets/aquarium.png",
              altisim: "Akvaryum",
              sayfaismi: '/akvaryum',
            ),
            GorevButton(
              logo: "assets/zraporu.png",
              altisim: "Eksik Z Raporu Kurtarıcı",
              sayfaismi: '/zraporu',
            ),
            GorevButton(
              logo: "assets/love.png",
              altisim: "Vücut Kitle Endeksi",
              sayfaismi: '/vucut',
            ),
            GorevButton(
              logo: "assets/horse-power.png",
              altisim: "kW ⇄ hp",
              sayfaismi: '/beygir',
            ),
            GorevButton(
              logo: "assets/commission.png",
              altisim: "Komisyon",
              sayfaismi: '/komisyon',
            ),
            GorevButton(
              logo: "assets/yuzde.png",
              altisim: "Yüzde Hesaplama",
              sayfaismi: '/yuzde',
            ),
            GorevButton(
              logo: "assets/petrol.png",
              altisim: "Yakıt Tüketimi",
              sayfaismi: '/yakit',
            ),
            SizedBox(),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
        bottomNavigationBar: Container(
          // decoration: BoxDecoration(boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.9),
          //     spreadRadius: 20,
          //     blurRadius: 13,
          //     offset: const Offset(0, 20),
          //   )
          // ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // _isBannerAdReady
              //     ? SizedBox(
              //         width: _bannerAd!.size.width.toDouble(),
              //         height: _bannerAd!.size.height.toDouble(),
              //         child: AdWidget(ad: _bannerAd!))
              //     : SizedBox(
              //         width: _bannerAd!.size.width.toDouble(),
              //         height: _bannerAd!.size.height.toDouble(),
              //       ),
              const SizedBox(
                height: 20,
              ),
              altblur
            ],
          ),
        ));
  }
}
