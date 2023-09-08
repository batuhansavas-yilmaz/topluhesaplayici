// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'tools/yardimcilar.dart';

class Yuzde extends StatefulWidget {
  @override
  _YuzdeState createState() => _YuzdeState();
}

class _YuzdeState extends State<Yuzde> {
  double x = 0.00;
  double y = 0.00;
  double yninyuzdexisonuc = 0.00;
  double yninyuzdexi = 0.00;
  double yxinyuzdekacisonuc = 0.00;
  double azalim = 0.00;
  double artim = 0.00;
  final _focusNode = FocusNode();
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  snack(String mesaj) {
    final snackBar = SnackBar(
      content: Text(mesaj, textAlign: TextAlign.center),
      width: 200,
      duration: Duration(seconds: 3),
      elevation: 1,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool sonuc = false;
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: yuzdeReklam,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "Yüzde Hesaplama",
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Elinizdeki sayıların birbiriyle olan "
              "yüzdeleme hesaplamalarını kolayca "
              "elde edebilirsiniz.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            focusNode: _focusNode,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,10}')),
                            ],
                            controller: t1,
                            style: formstil,
                            decoration: InputDecoration(
                              hintText: "1.Sayı",
                              hintStyle: hintstil,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              setState(() {
                                if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  x = double.parse(t1.text);
                                  y = double.parse(t2.text);
                                  yxinyuzdekacisonuc =
                                      ((y / x) * 100).toPrecision(2);
                                  yninyuzdexisonuc =
                                      (x * (y / 100)).toPrecision(2);
                                  artim = (x + yninyuzdexisonuc).toPrecision(2);
                                  azalim =
                                      (x - yninyuzdexisonuc).toPrecision(2);

                                  sonuc = true;
                                } else {
                                  snack("Lütfen bir değer girin");
                                }
                              });
                            },
                            controller: t2,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,10}')),
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: formstil,
                            decoration: InputDecoration(
                              hintText: "2.Sayı",
                              hintStyle: hintstil,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        x = double.parse(t1.text);
                        y = double.parse(t2.text);
                        yxinyuzdekacisonuc = ((y / x) * 100).toPrecision(2);
                        yninyuzdexisonuc = (x * (y / 100)).toPrecision(2);
                        artim = (x + yninyuzdexisonuc).toPrecision(2);
                        azalim = (x - yninyuzdexisonuc).toPrecision(2);

                        sonuc = true;
                      } else {
                        snack("Lütfen bir değer girin");
                      }
                    });
                  },
                  child: hesapla,
                ),
              ],
            ),
            SizedBox(height: 10),
            if (sonuc == true)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          color: Color.fromARGB(255, 0, 135, 245),
                          child: Text(
                            "SONUÇ",
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
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                              "${t2.text} sayısı ${t1.text} sayısının % kaçıdır",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Flexible(
                          child: Text(
                            "% ${yxinyuzdekacisonuc.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("${t1.text} sayısının %${t2.text} değeri",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Flexible(
                          child: Text(
                            "${yninyuzdexisonuc.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("${t1.text} sayısı %${t2.text} artınca",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Flexible(
                          child: Text(
                            "${artim.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("${t1.text} sayısı %${t2.text} azalınca",
                              style: TextStyle(fontSize: 18)),
                        ),
                        Flexible(
                          child: Text(
                            " ${azalim.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(eccentricity: 0.0)),
                    child: Icon(Icons.replay),
                    onPressed: () {
                      setState(() {
                        _focusNode.requestFocus();
                        t1.clear();
                        t2.clear();

                        sonuc = false;
                      });
                    },
                  )
                ],
              ),
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
              altblur
            ],
          ),
        ));
  }
}
