import 'package:advanced_in_app_review/advanced_in_app_review.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gdpr_dialog/gdpr_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simple_native_toast/simple_native_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'yakit.dart';
import 'yuzde.dart';
import "beygir.dart";
import 'kdvHesaplayicisi.dart';
import 'indirim-komisyon.dart';
import 'zraporu.dart';
import 'vucutKitleEndeksi.dart';
import 'binekArac.dart';
import 'tools/yardimcilar.dart';
import 'akvaryum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
      darkTheme: ThemeData(
        useMaterial3: false,
        cardColor: anaRenkDark,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: anaRenkDark,
            filled: true,
            hintStyle: hintstilDark),
        scaffoldBackgroundColor: Color.fromARGB(255, 84, 93, 99),
        appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: anaRenkDark,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: anaRenkDark,
            statusBarColor: Colors.transparent,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 1,
              backgroundColor: Color(0xff383e42),
              foregroundColor: Color.fromARGB(255, 253, 253, 253)),
        ),
      ),
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: false,
          textSelectionTheme: TextSelectionThemeData(cursorColor: anaRenk),
          brightness: Brightness.light,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: anaRenk),
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: hintstil,
            fillColor: Colors.white,
            filled: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Color.fromARGB(255, 236, 236, 236),
                foregroundColor: Colors.black),
          ),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: anaRenk,
              statusBarColor: Colors.transparent,
            ),
            backgroundColor: anaRenk,
            elevation: 1,
          )),
      title: "HesapMatik",
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
        ],
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, HomePage(),
                    dragWithMouse: true),
              );
            });
          case '/kdv':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(
                    context, KdvHesaplayicisi(),
                    dragWithMouse: true),
              );
            });
          case '/zraporu':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, ZRaporu(),
                    dragWithMouse: true),
              );
            });
          case '/binekarac':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, BinekArac(),
                    dragWithMouse: true),
              );
            });
          case '/komisyon':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, IndirimKomisyon(),
                    dragWithMouse: true),
              );
            });
          case '/akvaryum':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, Aquarium(),
                    dragWithMouse: true),
              );
            });
          case '/vucut':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, KitleEndeksi(),
                    dragWithMouse: true),
              );
            });
          case '/beygir':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, Beygir(),
                    dragWithMouse: true),
              );
            });
          case '/yakit':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, YakitTuketimi(),
                    dragWithMouse: true),
              );
            });
          case '/yuzde':
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
                child: BouncingScrollWrapper.builder(context, Yuzde(),
                    dragWithMouse: true),
              );
            });

          default:
            return CupertinoPageRoute(builder: (context) {
              return ResponsiveScaledBox(
                width:
                    MediaQuery.of(context).size.shortestSide < 600 ? 451 : 600,
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
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 350));
    FlutterNativeSplash.remove();
  }

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: mainReklam,
      size: AdSize.banner,
      request: requesT,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _bannerAd!.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  static final simpleNativeToastPlugin = SimpleNativeToast();
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
    try {
      platformVersion = await simpleNativeToastPlugin.getPlatformVersion() ??
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

  @override
  void initState() {
    super.initState();
    initialization();
    initPlatformState();
    // GdprDialog.instance.showDialog(isForTest: false);
    // GdprDialog.instance.getConsentStatus();

    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(1)
        .setMinLaunchTimes(1)
        .setMinSecondsBeforeShowDialog(4)
        .monitor();
    _loadBannerAd();
  }

  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(CupertinoIcons.question_circle),
            color: Colors.white,
            onPressed: () {
              setState(() {
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => ResponsiveScaledBox(
                    width: 450,
                    child: AlertDialog(
                      elevation: 1,
                      title: Text(
                        "From B.S.Y.",
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        "Diğer uygulamalarımızı keşfetmeyi ve Instagram'dan bizi takip etmeyi unutmayın.",
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  final Uri _url = Uri.parse(
                                      "https://docs.google.com/document/d/e/2PACX-1vSUf7RNSt6Zfvp2LReEQuMQSaw4eECqxhsDETX5xQ6GneMScVUL0uxY35kCMWeG6MbNYx60cyzulpCc/pub");

                                  launchUrl(_url,
                                      mode: LaunchMode.externalApplication);
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.policy),
                                label: Text("Gizlilik Politikası")),
                            Row(
                              children: [
                                IconButton(
                                    icon: FaIcon(FontAwesomeIcons.googlePlay),
                                    onPressed: () {
                                      final Uri _url = Uri.parse(
                                          "https://play.google.com/store/apps/dev?id=5406504893764763263&pli=1");

                                      launchUrl(_url,
                                          mode: LaunchMode.externalApplication);
                                    }),
                                IconButton(
                                    icon: FaIcon(FontAwesomeIcons.instagram),
                                    onPressed: () {
                                      final Uri _url = Uri.parse(
                                          "https:instagram.com/from.b.s.y");

                                      launchUrl(_url,
                                          mode: LaunchMode.externalApplication);
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
            }),
        title: Text(
          "HesapMatik",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
          childAspectRatio: 0.88,
          primary: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(20.0),
          crossAxisCount:
              MediaQuery.of(context).size.shortestSide < 600 ? 2 : 3,
          children: MediaQuery.of(context).size.shortestSide < 600
              ? [
                  GorevButton(
                    logo: "assets/percentage.png",
                    altisim: "KDV\nHesaplama",
                    sayfaismi: '/kdv',
                  ),
                  GorevButton(
                    logo: "assets/car.png",
                    altisim: "%70'lik Binek Araç Giderleri",
                    sayfaismi: '/binekarac',
                  ),
                  GorevButton(
                    logo: "assets/yuzde.png",
                    altisim: "Yüzde\nHesaplama",
                    sayfaismi: '/yuzde',
                  ),
                  GorevButton(
                    logo: "assets/zraporu.png",
                    altisim: "Eksik Z Raporu\nKurtarıcı",
                    sayfaismi: '/zraporu',
                  ),
                  GorevButton(
                    logo: "assets/petrol.png",
                    altisim: "Yakıt\nTüketimi",
                    sayfaismi: '/yakit',
                  ),
                  GorevButton(
                    logo: "assets/aquarium.png",
                    altisim: "Akvaryum\nGereksinimleri",
                    sayfaismi: '/akvaryum',
                  ),
                  GorevButton(
                    logo: "assets/commission.png",
                    altisim: "İndirim\nKomisyon",
                    sayfaismi: '/komisyon',
                  ),
                  GorevButton(
                    logo: "assets/love.png",
                    altisim: "Vücut Kitle\nEndeksi",
                    sayfaismi: '/vucut',
                  ),
                  GorevButton(
                    logo: "assets/horse-power.png",
                    altisim: "kW ⇄ hp",
                    sayfaismi: '/beygir',
                  ),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                ]
              : [
                  GorevButton(
                    logo: "assets/percentage.png",
                    altisim: "KDV\nHesaplama",
                    sayfaismi: '/kdv',
                  ),
                  GorevButton(
                    logo: "assets/zraporu.png",
                    altisim: "Eksik Z Raporu\nKurtarıcı",
                    sayfaismi: '/zraporu',
                  ),
                  GorevButton(
                    logo: "assets/commission.png",
                    altisim: "İndirim\nKomisyon",
                    sayfaismi: '/komisyon',
                  ),
                  GorevButton(
                    logo: "assets/aquarium.png",
                    altisim: "Akvaryum\nGereksinimleri",
                    sayfaismi: '/akvaryum',
                  ),
                  GorevButton(
                    logo: "assets/love.png",
                    altisim: "Vücut Kitle\nEndeksi",
                    sayfaismi: '/vucut',
                  ),
                  GorevButton(
                    logo: "assets/yuzde.png",
                    altisim: "Yüzde\nHesaplama",
                    sayfaismi: '/yuzde',
                  ),
                  GorevButton(
                    logo: "assets/car.png",
                    altisim: "%70'lik Binek Araç Giderleri",
                    sayfaismi: '/binekarac',
                  ),
                  GorevButton(
                    logo: "assets/horse-power.png",
                    altisim: "kW ⇄ hp",
                    sayfaismi: '/beygir',
                  ),
                  GorevButton(
                    logo: "assets/petrol.png",
                    altisim: "Yakıt\nTüketimi",
                    sayfaismi: '/yakit',
                  ),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                ]),
      bottomNavigationBar: Reklam(
        ready: _isBannerAdReady,
        reklam: SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!)),
        bosluk: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
        ),
      ),
    );
  }
}
