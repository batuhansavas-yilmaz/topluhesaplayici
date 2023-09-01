// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

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

  late String mesaj;
  toast() {
    showToast("$mesaj",
        context: context,
        animation: StyledToastAnimation.fade,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
        duration: Duration(seconds: 4),
        position: StyledToastPosition.center);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text("1.SAYI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(",")
                              ],
                              controller: t1,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "...",
                                hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text("2.SAYI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                setState(() {
                                  if (t1.text.isNotEmpty &&
                                      t2.text.isNotEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    x = double.parse(t1.text);
                                    y = double.parse(t2.text);
                                    yxinyuzdekacisonuc = (y / x) * 100;
                                    yninyuzdexisonuc = (x * (y / 100));
                                    artim = (x + yninyuzdexisonuc);
                                    azalim = (x - yninyuzdexisonuc);
                                    sonuc = true;
                                  } else {
                                    mesaj = "Lütfen bir değer girin";
                                    toast();
                                  }
                                });
                              },
                              controller: t2,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(",")
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "...",
                                hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      x = double.parse(t1.text);
                      y = double.parse(t2.text);
                      yxinyuzdekacisonuc = (y / x) * 100;
                      yninyuzdexisonuc = (x * (y / 100));
                      artim = (x + yninyuzdexisonuc);
                      azalim = (x - yninyuzdexisonuc);
                      sonuc = true;
                    } else {
                      mesaj = "Lütfen bir değer girin";
                      toast();
                    }
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: Colors.blue,
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
              if (sonuc == true)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                "${t2.text} sayısı ${t1.text} sayısının % kaçıdır : ",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Flexible(
                            child: Text(
                              "% ${yxinyuzdekacisonuc.toStringAsPrecision(3)}",
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
                            child: Text(
                                "${t1.text} sayısının %${t2.text} değeri : ",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Flexible(
                            child: Text(
                              " ${yninyuzdexisonuc.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 22,
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
                            child: Text(
                                "${t1.text} sayısı %${t2.text} artınca : ",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Flexible(
                            child: Text(
                              " ${artim.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 22,
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
                            child: Text(
                                "${t1.text} sayısı %${t2.text} azalınca : ",
                                style: TextStyle(fontSize: 20)),
                          ),
                          Flexible(
                            child: Text(
                              " ${azalim.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 22,
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
                  ],
                ),
            ],
          ),
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
                  BoxShadow(offset: Offset(-0.00, -0.10), blurRadius: 0.3),
                ]),
                height: 1,
              ),
            ],
          ),
        ));
  }
}
