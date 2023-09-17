import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//test
// String beygirReklam = 'ca-app-pub-3940256099942544/6300978111';
// String binekAracReklam = 'ca-app-pub-3940256099942544/6300978111';
// String kdvReklam = 'ca-app-pub-3940256099942544/6300978111';
// String komisyonReklam = 'ca-app-pub-3940256099942544/6300978111';
// // String mainReklam = 'ca-app-pub-3940256099942544/6300978111';
// String vucutKitleReklam = 'ca-app-pub-3940256099942544/6300978111';
// String zraporuReklam = 'ca-app-pub-3940256099942544/6300978111';
// String yakitReklam = 'ca-app-pub-3940256099942544/6300978111';
// String akvaryumReklam = 'ca-app-pub-3940256099942544/6300978111';
// String yuzdeReklam = 'ca-app-pub-3940256099942544/6300978111';
// String gecis = 'ca-app-pub-3940256099942544/1033173712';

//orjinal
String akvaryumReklam = 'ca-app-pub-2770541050741728/3957376202';
String beygirReklam = 'ca-app-pub-2770541050741728/5078886183';
String binekAracReklam = 'ca-app-pub-2770541050741728/8870204809';
String kdvReklam = 'ca-app-pub-2770541050741728/7896621210';
String komisyonReklam = 'ca-app-pub-2770541050741728/2021478003';
// String mainReklam = 'ca-app-pub-2770541050741728/5462029565';
String vucutKitleReklam = 'ca-app-pub-2770541050741728/1785921702';
String zraporuReklam = 'ca-app-pub-2770541050741728/1183286472';
String yakitReklam = 'ca-app-pub-2770541050741728/6419301289';
String yuzdeReklam = 'ca-app-pub-2770541050741728/5078508883';

var anaRenk = Color.fromARGB(255, 0, 135, 245);

var requesT = AdRequest(
  // nonPersonalizedAds: true,
  keywords: [
    'flutter',
    'invoice',
    'tax',
    'tools',
    'solver',
    'aquarium',
    'fish',
    "car",
    "horse",
    "power",
    "hp",
    "liquid fuel",
    "gasoline",
    "diesel",
    "percentage",
  ],
);
// ignore: camel_case_types
var hesapla = Text("HESAPLA",
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
var formstil = TextStyle(fontSize: 23, fontWeight: FontWeight.bold);
var hintstil = TextStyle(
    fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal);
var altblur = Container(
  decoration: const BoxDecoration(
      color: Color.fromARGB(255, 0, 135, 245),
      boxShadow: [BoxShadow(offset: Offset(-0.00, -0.10), blurRadius: 0.3)]),
  height: 0.5,
);

//virgülden sonra doğru yuvarlama için
extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

// ignore: must_be_immutable
class GorevButton extends StatefulWidget {
  String? sayfaismi;
  String? altisim;
  String? logo;
  GorevButton(
      {required this.logo,
      required this.altisim,
      required this.sayfaismi,
      super.key});

  @override
  State<GorevButton> createState() => _GorevButtonState();
}

class _GorevButtonState extends State<GorevButton> {
  // InterstitialAd? _interstitialAd;
  // void _loadInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: gecis,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (InterstitialAd ad) {
  //           ad.fullScreenContentCallback = FullScreenContentCallback(
  //               // Called when the ad showed the full screen content.
  //               onAdShowedFullScreenContent: (ad) {},
  //               // Called when an impression occurs on the ad.
  //               onAdImpression: (ad) {},
  //               // Called when the ad failed to show full screen content.
  //               onAdFailedToShowFullScreenContent: (ad, err) {
  //                 ad.dispose();
  //                 _interstitialAd = null;
  //                 _loadInterstitialAd();
  //               },
  //               // Called when the ad dismissed full screen content.
  //               onAdDismissedFullScreenContent: (ad) {
  //                 ad.dispose();
  //                 _interstitialAd = null;
  //                 _loadInterstitialAd();
  //               },
  //               // Called when a click is recorded for an ad.
  //               onAdClicked: (ad) {});

  //           // Keep a reference to the ad so you can show it later.
  //           _interstitialAd = ad;
  //         },
  //         // Called when an ad request failed.
  //         onAdFailedToLoad: (LoadAdError error) {
  //           // ignore: avoid_print
  //           print('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  // void initState() {
  //   _loadInterstitialAd();
  //   super.initState();
  // }

  // int deneme = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            setState(() {
              // deneme++;

              // if (deneme == 2) {
              //   _interstitialAd?.show();
              // }

              Navigator.pushNamed(context, widget.sayfaismi!);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              widget.logo.toString(),
              width: 132,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${widget.altisim}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
