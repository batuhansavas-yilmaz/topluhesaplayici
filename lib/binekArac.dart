import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'tools/yardimcilar.dart';

class BinekArac extends StatefulWidget {
  @override
  _BinekAracState createState() => _BinekAracState();
}

class _BinekAracState extends State<BinekArac> {
  double tutar = 0.00;
  double kdvOran = 0.00;
  bool oran = false;
  bool sonuc1 = false;
  bool sonuc2 = false;
  double giderKabulEdilenMatrah = 0.00;
  double giderKabulEdilenKdv = 0.00;
  double giderKabulEdilenTutar = 0.00;
  double giderKabulEdilmeyenMatrah = 0.00;
  double giderKabulEdilmeyenKdv = 0.00;
  double giderKabulEdilmeyenTutar = 0.00;
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

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
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => AlertDialog(
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
                  );
                }),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 18, right: 18),
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
                            FilteringTextInputFormatter.deny(",")
                          ],
                          controller: t1,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Toplam Tutar",
                            hintStyle: TextStyle(
                                fontSize: 23,
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
                              tutar = double.parse(t1.text);
                              kdvOran = double.parse(t2.text);
                              giderKabulEdilenTutar = (tutar * 0.70);
                              giderKabulEdilenMatrah = (giderKabulEdilenTutar /
                                  ((kdvOran / 100) + 1));
                              giderKabulEdilenKdv = giderKabulEdilenTutar -
                                  giderKabulEdilenMatrah;
                              giderKabulEdilmeyenTutar = (tutar * 0.30);
                              giderKabulEdilmeyenMatrah =
                                  (giderKabulEdilmeyenTutar /
                                      ((kdvOran / 100) + 1));
                              giderKabulEdilmeyenKdv =
                                  giderKabulEdilmeyenTutar -
                                      giderKabulEdilmeyenMatrah;
                              sonuc1 = true;
                              sonuc2 = true;
                              oran = true;
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
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "KDV Oranı",
                          hintStyle: TextStyle(
                              fontSize: 23,
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
                    giderKabulEdilenTutar = (tutar * 0.70);
                    giderKabulEdilenMatrah =
                        (giderKabulEdilenTutar / ((kdvOran / 100) + 1));
                    giderKabulEdilenKdv =
                        giderKabulEdilenTutar - giderKabulEdilenMatrah;
                    giderKabulEdilmeyenTutar = (tutar * 0.30);
                    giderKabulEdilmeyenMatrah =
                        (giderKabulEdilmeyenTutar / ((kdvOran / 100) + 1));
                    giderKabulEdilmeyenKdv =
                        giderKabulEdilmeyenTutar - giderKabulEdilmeyenMatrah;
                    sonuc1 = true;
                    sonuc2 = true;
                    oran = true;
                  } else {
                    mesaj = "Lütfen bir değer girin";
                    toast();
                  }
                });
              },
              child: Text(
                "Hesapla",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gider Kabul Edilen %70'lik Tutar : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  if (sonuc1 == true)
                    Text(
                      "${giderKabulEdilenTutar.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
                            Row(
                              children: [
                                if (oran == true)
                                  Text(
                                    "(%${kdvOran.toStringAsFixed(0)})",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  giderKabulEdilenKdv.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Gider Kabul Edilmeyen %30'luk Tutar : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      if (sonuc2 == true)
                        Text(
                          " ${giderKabulEdilmeyenTutar.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
                            Row(
                              children: [
                                if (oran == true)
                                  Text(
                                    "(%${kdvOran.toStringAsFixed(0)})",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  giderKabulEdilmeyenKdv.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

TextStyle stil = TextStyle(color: Colors.black, fontSize: 18);
TextStyle stil2 =
    TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
