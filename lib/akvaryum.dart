import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'tools/yardimcilar.dart';

class Aquarium extends StatefulWidget {
  @override
  _AquariumState createState() => _AquariumState();
}

class _AquariumState extends State<Aquarium> {
  TextEditingController en_ = TextEditingController(text: "");
  TextEditingController derinlik_ = TextEditingController(text: "");
  TextEditingController uzunluk_ = TextEditingController(text: "");
  TextEditingController kumCm = TextEditingController(text: "5");
  double en = 0.00;
  double derinlik = 0.00;
  double uzunluk = 0.00;
  double sonuc = 0.00;
  double bitkisiz = 0.00, bitkili = 0.00;
  double filtrasyonMin = 0.00, filtrasyonMax = 0.00;
  double isitici = 0.00;
  double kum = 0.00;
  double kumCm_ = 5.00;
  double kumKg = 0.00;
  final _focusNode = FocusNode();
  bool replay = false;

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

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: akvaryumReklam,
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
          "Akvaryum",
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Text("Akvaryumunuzun bilgilerini\ncm cinsinden giriniz.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode,
                      controller: derinlik_,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      style: formstil,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Derinlik",
                        hintStyle: hintstil,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextFormField(
                      controller: en_,
                      style: formstil,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        hintText: "En",
                        hintStyle: hintstil,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        setState(() {
                          if (uzunluk_.text.isNotEmpty &&
                              en_.text.isNotEmpty &&
                              derinlik_.text.isNotEmpty &&
                              kumCm.text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(
                                new FocusNode()); // klavye kapatıcı
                            uzunluk = double.parse(uzunluk_.text);
                            en = double.parse(en_.text);
                            derinlik = double.parse(derinlik_.text);
                            kumCm_ = double.parse(kumCm.text);
                            sonuc = ((uzunluk * en * derinlik) / 1000)
                                .toPrecision(2);
                            bitkisiz = (sonuc * 0.25).toPrecision(2);
                            bitkili = (sonuc * 0.50).toPrecision(2);
                            filtrasyonMin = (sonuc * 2.50).toPrecision(2);
                            filtrasyonMax = (sonuc * 4.75).toPrecision(2);
                            isitici = (sonuc * 0.6667).toPrecision(2);
                            kum = (sonuc * 0.025).toPrecision(2);
                            kumKg = (kum * kumCm_).toPrecision(2);
                            replay = true;
                          } else {
                            snack("Lütfen bir değer girin");
                          }
                        });
                      },
                      controller: uzunluk_,
                      style: formstil,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        hintText: "Uzunluk",
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 64,
                    ),
                    ElevatedButton(
                      child: hesapla,
                      onPressed: () {
                        setState(() {
                          if (uzunluk_.text.isNotEmpty &&
                              en_.text.isNotEmpty &&
                              derinlik_.text.isNotEmpty &&
                              kumCm.text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(
                                new FocusNode()); // klavye kapatıcı
                            uzunluk = double.parse(uzunluk_.text);
                            en = double.parse(en_.text);
                            derinlik = double.parse(derinlik_.text);
                            kumCm_ = double.parse(kumCm.text);
                            sonuc = ((uzunluk * en * derinlik) / 1000)
                                .toPrecision(2);
                            bitkisiz = (sonuc * 0.25).toPrecision(2);
                            bitkili = (sonuc * 0.50).toPrecision(2);
                            filtrasyonMin = (sonuc * 2.50).toPrecision(2);
                            filtrasyonMax = (sonuc * 4.75).toPrecision(2);
                            isitici = (sonuc * 0.6667).toPrecision(2);
                            kum = (sonuc * 0.025).toPrecision(2);
                            kumKg = (kum * kumCm_).toPrecision(2);
                            replay = true;
                          } else {
                            snack("Lütfen bir değer girin");
                          }
                        });
                      },
                    ),
                    replay == true
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(eccentricity: 0.0)),
                            child: Icon(Icons.replay),
                            onPressed: () {
                              setState(() {
                                _focusNode.requestFocus();
                                uzunluk_.clear();
                                derinlik_.clear();
                                en_.clear();
                                replay = false;
                              });
                            },
                          )
                        : SizedBox(
                            width: 64,
                          ),
                  ],
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: ListTile(
                      title: Text(
                        "Akvaryumunuzun Kapasitesi",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: replay == true
                          ? Text(
                              "${sonuc.toStringAsFixed(2)} Litre ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : Text("")),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                      title: Text(
                        "Tavsiye Edilen Işık Gücü",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: replay == true
                          ? Column(
                              children: [
                                Text(
                                  "Bitkili Akvaryum : " +
                                      bitkili.toStringAsFixed(2) +
                                      " Watt",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Bitkisiz Akvaryum : " +
                                      bitkisiz.toStringAsFixed(2) +
                                      " Watt",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          : Text("")),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                      title: Text(
                        "Filtrasyon",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: replay == true
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Minimum : ${filtrasyonMin.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      " litre/saat",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Maximum : ${filtrasyonMax.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      " litre/saat",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Text("")),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                      title: Text(
                        "Tavsiye Edilen Isıtıcı Gücü",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: replay == true
                          ? Text(
                              "${isitici.toStringAsFixed(2)} Watt",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : Text("")),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "İstenilen Kum Kalınlığı",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("cm", style: TextStyle(fontSize: 20)),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    if (uzunluk_.text.isNotEmpty &&
                                        en_.text.isNotEmpty &&
                                        derinlik_.text.isNotEmpty &&
                                        kumCm.text.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(
                                          new FocusNode()); // klavye kapatıcı
                                      uzunluk = double.parse(uzunluk_.text);
                                      en = double.parse(en_.text);
                                      derinlik = double.parse(derinlik_.text);
                                      kumCm_ = double.parse(kumCm.text);
                                      sonuc = ((uzunluk * en * derinlik) / 1000)
                                          .toPrecision(2);
                                      bitkisiz = (sonuc * 0.25).toPrecision(2);
                                      bitkili = (sonuc * 0.50).toPrecision(2);
                                      filtrasyonMin =
                                          (sonuc * 2.50).toPrecision(2);
                                      filtrasyonMax =
                                          (sonuc * 4.75).toPrecision(2);
                                      isitici = (sonuc * 0.6667).toPrecision(2);
                                      kum = (sonuc * 0.025).toPrecision(2);
                                      kumKg = (kum * kumCm_).toPrecision(2);
                                      replay = true;
                                    } else {
                                      snack("Lütfen bir değer girin");
                                    }
                                  });
                                },
                                style: formstil,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                controller: kumCm,
                                decoration: InputDecoration(
                                  hintText: "Kum",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: replay == true
                              ? Text(
                                  "İstediğiniz Kalınlık İçin Gerekli Kum : ${kumKg.toStringAsFixed(2)} Kg",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : SizedBox(
                                  width: 262.7,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                ),
              ],
            ),
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
