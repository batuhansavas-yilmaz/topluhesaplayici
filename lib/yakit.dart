import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toplu_hesaplayici/tools/yardimcilar.dart';

import 'main.dart';

class YakitTuketimi extends StatefulWidget {
  const YakitTuketimi({super.key});

  @override
  State<YakitTuketimi> createState() => _YakitTuketimiState();
}

class _YakitTuketimiState extends State<YakitTuketimi> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final _focusNode = FocusNode();
  double litreSonuc = 0.00;
  double kapasite = 0.00;
  double tamDepoKm = 0.00;
  double yakitFiyati = 0.00;
  double yakitFiyatiSonuc = 0.00;
  bool sonuc = false;

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: yakitReklam,
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
        title: Text("Yakıt Tüketimi"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Aracınızın bilgilerini girerek\nkm'de"
                " kaç LT tükettiğini\nve kaç ₺ yaktığını hesaplayabilirsiniz. ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : anaRenkDark),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Depo Kapasitesi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 150,
                      child: TextFormField(
                        focusNode: _focusNode,
                        controller: t1,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        style: formstil,
                        decoration: InputDecoration(
                          hintText: 'LT',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Tam Depo Gidilen KM ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 150,
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        controller: t2,
                        style: formstil,
                        decoration: InputDecoration(
                          hintText: 'KM',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Yakıt Litre Fiyatı ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 150,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t1.text.isNotEmpty &&
                                t2.text.isNotEmpty &&
                                t3.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              kapasite = double.parse(t1.text);
                              tamDepoKm = double.parse(t2.text);
                              yakitFiyati = double.parse(t3.text);
                              litreSonuc = (kapasite / tamDepoKm);
                              yakitFiyatiSonuc = (litreSonuc * yakitFiyati);

                              sonuc = true;
                            } else {
                              HomePageState.simpleNativeToastPlugin.showToast(
                                "Lütfen bir değer girin",
                              );
                            }
                          });
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        controller: t3,
                        style: formstil,
                        decoration: InputDecoration(
                          hintText: '₺',
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
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty &&
                          t2.text.isNotEmpty &&
                          t3.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        kapasite = double.parse(t1.text);
                        tamDepoKm = double.parse(t2.text);
                        yakitFiyati = double.parse(t3.text);
                        litreSonuc = (kapasite / tamDepoKm);
                        yakitFiyatiSonuc = (litreSonuc * yakitFiyati);

                        sonuc = true;
                      } else {
                        HomePageState.simpleNativeToastPlugin.showToast(
                          "Lütfen bir değer girin",
                        );
                      }
                    });
                  },
                  child: hesapla),
              SizedBox(
                height: 20,
              ),
              if (sonuc == true)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? anaRenk
                                    : anaRenkDark,
                            child: Text(
                              "ARACINIZ KM BAŞINA ORTALAMA YAKIT TÜKETİMİ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Litre", style: TextStyle(fontSize: 17)),
                            Text(
                              "${litreSonuc.toStringAsFixed(2)} LT",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Fiyat", style: TextStyle(fontSize: 17)),
                            Text(
                              "${yakitFiyatiSonuc.toStringAsFixed(2)} ₺",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
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
                          t3.clear();
                          sonuc = false;
                        });
                      },
                    )
                  ],
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
