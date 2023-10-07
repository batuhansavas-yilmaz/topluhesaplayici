// ignore_for_file: non_constant_identifier_names, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'main.dart';
import 'tools/yardimcilar.dart';

class IndirimKomisyon extends StatefulWidget {
  @override
  _IndirimKomisyonState createState() => _IndirimKomisyonState();
}

class _IndirimKomisyonState extends State<IndirimKomisyon> {
  double AnaPara = 0.00;
  double IndirimKomisyonTutari = 0.00;
  double IndirimKomisyonTutariSonuc = 0.00;
  double IndirimKomisyonOrani = 0.00;
  double IndirimKomisyonOraniSonuc = 0.00;
  double OranIndirimSonuc = 0.00;
  double TutarIndirimSonuc = 0.00;

  bool oran = false;
  bool tutar = false;
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  TextEditingController t4 = TextEditingController(text: '');
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "İndirim-Komisyon Hesaplama",
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Oran Hesaplaması",
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
                        child: TextFormField(
                          focusNode: _focusNode1,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          controller: t1,
                          style: formstil,
                          decoration: InputDecoration(
                            hintText: "Ana Para",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              AnaPara = double.parse(t1.text);
                              IndirimKomisyonTutari = double.parse(t2.text);
                              IndirimKomisyonOraniSonuc =
                                  ((IndirimKomisyonTutari / AnaPara) * 100)
                                      .toPrecision(2);

                              OranIndirimSonuc = (AnaPara *
                                      ((100 - IndirimKomisyonOraniSonuc) / 100))
                                  .toPrecision(2);

                              oran = true;
                            } else {
                              HomePageState.simpleNativeToastPlugin.showToast(
                                "Lütfen bir değer girin",
                              );
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
                        style: formstil,
                        decoration: InputDecoration(
                          hintText: "İndirim Tutarı (₺)",
                        ),
                        textAlign: TextAlign.center,
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
                      IndirimKomisyonTutari = double.parse(t2.text);
                      IndirimKomisyonOraniSonuc =
                          ((IndirimKomisyonTutari / AnaPara) * 100)
                              .toPrecision(2);

                      OranIndirimSonuc =
                          (AnaPara * ((100 - IndirimKomisyonOraniSonuc) / 100))
                              .toPrecision(2);
                      print(OranIndirimSonuc);

                      oran = true;
                    } else {
                      HomePageState.simpleNativeToastPlugin.showToast(
                        "Lütfen bir değer girin",
                      );
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? anaRenk
                      : anaRenkDark,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "İndirim-Komisyon Oranı",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Text(
                            " : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              "% ${IndirimKomisyonOraniSonuc.toStringAsFixed(2)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "İndirim Sonucu",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Text(
                            " : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              "${OranIndirimSonuc.toStringAsFixed(2)} ₺",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (oran == true)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(eccentricity: 0)),
                    onPressed: () {
                      setState(() {
                        t1.clear();
                        t2.clear();
                        AnaPara = 0.00;
                        IndirimKomisyonTutari = 0.00;
                        IndirimKomisyonOraniSonuc = 0.00;
                        OranIndirimSonuc = 0.00;

                        _focusNode1.requestFocus();
                        oran = false;
                      });
                    },
                    child: Icon(Icons.replay),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Divider(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : anaRenkDark),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tutar Hesaplaması",
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
                        child: TextFormField(
                          focusNode: _focusNode2,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: t3,
                          style: formstil,
                          decoration: InputDecoration(
                            hintText: "Ana Para",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t3.text.isNotEmpty && t4.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              AnaPara = double.parse(t3.text);
                              IndirimKomisyonOrani = double.parse(t4.text);
                              IndirimKomisyonTutariSonuc =
                                  (AnaPara * (IndirimKomisyonOrani / 100))
                                      .toPrecision(2);
                              TutarIndirimSonuc =
                                  (AnaPara - IndirimKomisyonTutariSonuc)
                                      .toPrecision(2);
                              tutar = true;
                            } else {
                              HomePageState.simpleNativeToastPlugin.showToast(
                                "Lütfen bir değer girin",
                              );
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
                        style: formstil,
                        decoration: InputDecoration(
                          hintText: "İndirim Oranı (%)",
                        ),
                        textAlign: TextAlign.center,
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
                      IndirimKomisyonOrani = double.parse(t4.text);
                      IndirimKomisyonTutariSonuc =
                          (AnaPara * (IndirimKomisyonOrani / 100))
                              .toPrecision(2);
                      TutarIndirimSonuc =
                          (AnaPara - IndirimKomisyonTutariSonuc).toPrecision(2);
                      tutar = true;
                    } else {
                      HomePageState.simpleNativeToastPlugin.showToast(
                        "Lütfen bir değer girin",
                      );
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? anaRenk
                      : anaRenkDark,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "İndirim-Komisyon Tutarı",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Text(
                            " : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              "${IndirimKomisyonTutariSonuc.toStringAsFixed(2)} ₺",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "İndirim Sonucu",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Text(
                            " : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              "${TutarIndirimSonuc.toStringAsFixed(2)} ₺",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (tutar == true)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(eccentricity: 0)),
                    onPressed: () {
                      setState(() {
                        t3.clear();
                        t4.clear();
                        AnaPara = 0.00;
                        IndirimKomisyonOrani = 0.00;
                        IndirimKomisyonTutariSonuc = 0.00;
                        TutarIndirimSonuc = 0.00;

                        _focusNode2.requestFocus();
                        tutar = false;
                      });
                    },
                    child: Icon(Icons.replay),
                  ),
                ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ],
      ),
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
