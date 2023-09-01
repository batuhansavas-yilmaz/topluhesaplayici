import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'tools/yardimcilar.dart';
import 'tools/endeksYorum.dart';

class KitleEndeksi extends StatefulWidget {
  @override
  KitleEndeksiState createState() => KitleEndeksiState();
}

class KitleEndeksiState extends State<KitleEndeksi> {
  TextEditingController kg = TextEditingController(text: "");
  TextEditingController boy = TextEditingController(text: "");
  double kG = 0;
  double boY = 0;
  static double sonuc = 0.00;
  static String sonucMetin = "";
  bool sonucc = false;
  @override
  Widget build(BuildContext context) {
    Yorum.yorum();

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "Vücut Kitle Endeksi",
          ),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "18 yaşına kadar olan bireylerin \nVücut Kitle Endekslerini öğrenmeleri için \ndiyetisyenlerden yardım almaları önerilir.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextFormField(
                            controller: kg,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(",")
                            ],
                            decoration: InputDecoration(
                              hintText: "Kilo",
                              hintStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.normal),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              setState(() {
                                if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                                  FocusScope.of(context).requestFocus(
                                      new FocusNode()); // klavye kapatıcı
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: Text("Uyarı"),
                                              content: Text(
                                                  'Edindiğiniz sonuçlar formulize olarak doğru olsa bile '
                                                  'sağlığınız açısından en güvenilir sonuçlar için diyetisyenlerden '
                                                  'yardım almanızı öneririz.'),
                                              actions: [
                                                IconButton(
                                                  tooltip: "Kapat",
                                                  icon: Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ]));
                                  kG = double.parse(kg.text);
                                  boY = double.parse(boy.text);
                                  sonuc = kG / ((boY / 100) * (boY / 100));

                                  sonucc = true;
                                } else {
                                  showToast("Lütfen bir değer girin",
                                      context: context,
                                      animation: StyledToastAnimation.fade,
                                      curve: Curves.linear,
                                      reverseCurve: Curves.linear,
                                      duration: Duration(seconds: 4),
                                      position: StyledToastPosition.center);
                                }
                              });
                            },
                            controller: boy,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(",")
                            ],
                            decoration: InputDecoration(
                              hintText: "Boy(cm)",
                              hintStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.normal),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    child: Text(
                      "Hesapla",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                          FocusScope.of(context)
                              .requestFocus(new FocusNode()); // klavye kapatıcı
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text("Uyarı"),
                                      content: Text(
                                          'Edindiğiniz sonuçlar formulize olarak doğru olsa bile '
                                          'sağlığınız açısından en güvenilir sonuçlar için diyetisyenlerden '
                                          'yardım almanızı öneririz.'),
                                      actions: [
                                        IconButton(
                                          tooltip: "Kapat",
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ]));
                          kG = double.parse(kg.text);
                          boY = double.parse(boy.text);
                          sonuc = kG / ((boY / 100) * (boY / 100));

                          sonucc = true;
                        } else {
                          showToast("Lütfen bir değer girin",
                              context: context,
                              animation: StyledToastAnimation.fade,
                              curve: Curves.linear,
                              reverseCurve: Curves.linear,
                              duration: Duration(seconds: 4),
                              position: StyledToastPosition.center);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (sonucc == true)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          color: Colors.blue,
                          child: Text(
                            "VÜCUT KİTLE ENDEKSİNİZ : ${sonuc.toStringAsFixed(2)} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Yorum",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      sonucMetin,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              spreadRadius: 20,
              blurRadius: 13,
              offset: const Offset(0, 20),
            )
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isBannerAdReady
                  ? SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!))
                  : SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                    ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.blue, boxShadow: [
                  BoxShadow(offset: Offset(-0.00, -0.10), blurRadius: 0.3)
                ]),
                height: 1,
              ),
            ],
          ),
        ));
  }

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: vucutKitleReklam,
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

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
  }
}
