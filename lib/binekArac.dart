import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'tools/yardimcilar.dart';

class BinekArac extends StatefulWidget {
  @override
  _BinekAracState createState() => _BinekAracState();
}

class _BinekAracState extends State<BinekArac> {
  double tutar = 0.00;
  double kdvOran = 0.00;

  bool sonuc = false;
  final _focusNode = FocusNode();
  double giderKabulEdilenMatrah = 0.00;
  double giderKabulEdilenKdv = 0.00;
  double giderKabulEdilenTutar = 0.00;
  double giderKabulEdilmeyenMatrah = 0.00;
  double giderKabulEdilmeyenKdv = 0.00;
  double giderKabulEdilmeyenTutar = 0.00;
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

  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: binekAracReklam,
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
        appBar: AppBar(
          title: Text(
            "%70'lik Binek Araç Giderleri",
          ),
          actions: [
            IconButton(
                tooltip: "Bilgi",
                icon: Icon(Icons.info),
                onPressed: () {
                  showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => ResponsiveScaledBox(
                      width: 450,
                      child: AlertDialog(
                        elevation: 1,
                        title: Text("Bilgi"),
                        content: Text(
                            "Bu hesaplayıcı binek araç giderlerinin sadece %70'ini gider gösterebilen vergi mükellefleri içindir."),
                        actions: [
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 18, right: 18),
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
                              focusNode: _focusNode,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
                              ],
                              controller: t1,
                              style: formstil,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Toplam Tutar",
                                hintStyle: hintstil,
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
                                  tutar = double.parse(t1.text);
                                  kdvOran = double.parse(t2.text);

                                  giderKabulEdilenTutar =
                                      (tutar * 0.70).toPrecision(2);
                                  giderKabulEdilenMatrah =
                                      (giderKabulEdilenTutar /
                                              ((kdvOran / 100) + 1))
                                          .toPrecision(2);
                                  giderKabulEdilenKdv = (giderKabulEdilenTutar -
                                          giderKabulEdilenMatrah)
                                      .toPrecision(2);
                                  giderKabulEdilmeyenTutar =
                                      (tutar * 0.30).toPrecision(2);
                                  giderKabulEdilmeyenMatrah =
                                      (giderKabulEdilmeyenTutar /
                                          ((kdvOran / 100) + 1));
                                  giderKabulEdilmeyenKdv =
                                      (giderKabulEdilmeyenTutar -
                                              giderKabulEdilmeyenMatrah)
                                          .toPrecision(2);

                                  sonuc = true;
                                } else {
                                  snack("Lütfen bir değer girin");
                                }
                              });
                            },
                            controller: t2,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2)
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: formstil,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "KDV Oranı",
                              hintStyle: hintstil,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        tutar = double.parse(t1.text);
                        kdvOran = double.parse(t2.text);

                        giderKabulEdilenTutar = (tutar * 0.70).toPrecision(2);
                        giderKabulEdilenMatrah =
                            (giderKabulEdilenTutar / ((kdvOran / 100) + 1))
                                .toPrecision(2);
                        giderKabulEdilenKdv =
                            (giderKabulEdilenTutar - giderKabulEdilenMatrah)
                                .toPrecision(2);
                        giderKabulEdilmeyenTutar =
                            (tutar * 0.30).toPrecision(2);
                        giderKabulEdilmeyenMatrah =
                            (giderKabulEdilmeyenTutar / ((kdvOran / 100) + 1));
                        giderKabulEdilmeyenKdv = (giderKabulEdilmeyenTutar -
                                giderKabulEdilmeyenMatrah)
                            .toPrecision(2);

                        sonuc = true;
                      } else {
                        snack("Lütfen bir değer girin");
                      }
                    });
                  },
                  child: hesapla,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Color.fromARGB(255, 0, 135, 245),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gider Kabul Edilen %70'lik Tutar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      if (sonuc == true)
                        Flexible(
                          child: Text(
                            " : ${giderKabulEdilenTutar.toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Matrah",
                                  style: stil2,
                                ),
                                Text(
                                  giderKabulEdilenMatrah.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "KDV Tutarı",
                                  style: stil2,
                                ),
                                Text(
                                  giderKabulEdilenKdv.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(255, 0, 135, 245),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Gider Kabul Edilmeyen %30'luk Tutar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          if (sonuc == true)
                            Flexible(
                              child: Text(
                                " : ${giderKabulEdilmeyenTutar.toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gider Kabul Edilmeyen Matrah",
                                  style: stil2,
                                ),
                                Text(
                                  giderKabulEdilmeyenMatrah.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gider Kabul Edilmeyen KDV",
                                  style: stil2,
                                ),
                                Text(
                                  giderKabulEdilmeyenKdv.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (sonuc == true)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(eccentricity: 0.0)),
                        child: Icon(Icons.replay),
                        onPressed: () {
                          setState(() {
                            _focusNode.requestFocus();
                            giderKabulEdilenMatrah = 0.00;
                            giderKabulEdilenKdv = 0.00;
                            giderKabulEdilenTutar = 0.00;
                            giderKabulEdilmeyenMatrah = 0.00;
                            giderKabulEdilmeyenKdv = 0.00;
                            giderKabulEdilmeyenTutar = 0.00;
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

TextStyle stil = TextStyle(color: Colors.black, fontSize: 18);
TextStyle stil2 =
    TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
