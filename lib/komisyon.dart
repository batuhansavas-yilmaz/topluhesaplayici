// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'tools/yardimcilar.dart';

class Komisyon extends StatefulWidget {
  @override
  _KomisyonState createState() => _KomisyonState();
}

class _KomisyonState extends State<Komisyon> {
  double AnaPara = 0.00;
  double AlinanPay = 0.00;
  double AlinanPaySonuc = 0.00;
  double AlinanOran = 0.00;
  double AlinanOranSonuc = 0.00;
  bool oran = false;
  bool tutar = false;
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  TextEditingController t4 = TextEditingController(text: '');

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: komisyonReklam,
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
            "Komisyon Hesaplama",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Komisyon oranı için :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            controller: t1,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Ana Para",
                              hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
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
                                AnaPara = double.parse(t1.text);
                                AlinanPay = double.parse(t2.text);
                                AlinanOranSonuc = (AlinanPay / AnaPara) * 100;
                                oran = true;
                              } else {
                                mesaj = "Lütfen bir değer girin";
                                toast();
                              }
                            });
                          },
                          controller: t2,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Alınan Pay",
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
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      AnaPara = double.parse(t1.text);
                      AlinanPay = double.parse(t2.text);
                      AlinanOranSonuc = (AlinanPay / AnaPara) * 100;
                      oran = true;
                    } else {
                      mesaj = "Lütfen bir değer girin";
                      toast();
                    }
                  });
                },
                child: hesapla,
              ),
              SizedBox(
                height: 10,
              ),
              if (oran == true)
                Container(
                  padding: EdgeInsets.all(2),
                  color: Colors.blue,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aldığınız Pay Oranı : % ${AlinanOranSonuc.toStringAsFixed(2)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                "Komisyon tutarı için :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: t3,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Ana Para",
                              hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (t3.text.isNotEmpty && t4.text.isNotEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                AnaPara = double.parse(t3.text);
                                AlinanOran = double.parse(t4.text);
                                AlinanPaySonuc = (AnaPara * (AlinanOran / 100));
                                tutar = true;
                              } else {
                                mesaj = "Lütfen bir değer girin";
                                toast();
                              }
                            });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          controller: t4,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Alınan Oran",
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
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (t3.text.isNotEmpty && t4.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      AnaPara = double.parse(t3.text);
                      AlinanOran = double.parse(t4.text);
                      AlinanPaySonuc = (AnaPara * (AlinanOran / 100));
                      tutar = true;
                    } else {
                      mesaj = "Lütfen bir değer girin";
                      toast();
                    }
                  });
                },
                child: hesapla,
              ),
              SizedBox(
                height: 10,
              ),
              if (tutar == true)
                Container(
                  padding: EdgeInsets.all(2),
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Aldığınız Pay Tutarı :  ${AlinanPaySonuc.toStringAsFixed(2)} ₺",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 100,
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
                  BoxShadow(offset: Offset(-0.00, -0.10), blurRadius: 0.3)
                ]),
                height: 1,
              ),
            ],
          ),
        ));
  }
}
