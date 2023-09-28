// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_framework/responsive_scaled_box.dart';

import 'tools/yardimcilar.dart';

class KdvHesaplayicisi extends StatefulWidget {
  @override
  KdvHesaplayicisiState createState() => KdvHesaplayicisiState();
}

class KdvHesaplayicisiState extends State<KdvHesaplayicisi> {
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: kdvReklam,
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

  int counter = 0;
  double hesapTutar = 0.00;
  double hesapOran = 0.00;

  double haricTutar = 0.00;
  double HarickenKdvTutari = 0.00;
  double toplamHaricTutar = 0.00;

  double dahilTutar = 0.00;
  double dahilkenKdvTutari = 0.00;
  double toplamDahilTutar = 0.00;

//tevkifat
  double matrahTevkifat = 0.00;
  double TevkifatSonrasiKDV = 0.00;
  double kdvDahilTevkifatliToplamTutar = 0.00;
  double tevkifatOncesiKDV = 0.00;
  double Tevkifat = 0.00;
  double oranTevkifat = 0.00;
  double TevkifatliToplamTutar = 0.00;

  //kdv dahil tevk
  double dahilMatrahTevkifat = 0.00;
  double dahilTevkifatOncesiKdv = 0.00;
  double dahilTevkifatToplamTutar = 0.00;
  double dahilKdvDahilTevkifatliToplamTutar = 0.00;
  double dahilTevkifat = 0.00;
  double dahilTevkifatSonrasiKdv = 0.00;
  bool kdv = false;
  bool tefkkdv = false;
  /* Burda , t1 ve t2 adında 2 TextEditingController tipinde nesne ürettik.
  bunları üretmemizin amacı , textformfield'de yazılacak olan yazıyı kontrol etmek,işleme sokabilmek
  */
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  TextEditingController t4 = TextEditingController(text: '');
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [
              Text(
                "KDV\nHesaplama ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Tevkifatlı\nKDV Hesaplama",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          title: Text(
            "KDV Hesaplayıcısı",
          ),
        ),
        body: TabBarView(
          children: [
            //normal
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 10, right: 10, bottom: 2.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                focusNode: _focusNode1,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
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
                                  hintText: "Tutar",
                                  hintStyle: hintstil,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
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
                                    if (t1.text.isNotEmpty &&
                                        t2.text.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      //Burda yatığımız , hesapla butonuna bastığımızda  t1 ve t2 nesnelerine yazılan verilerin,
                                      //hesaptutar ve hesapOran nesnelerine aktarılmasını sağladık.
                                      //Bu sayede hesap tutar ve hesap oran nesnelerini kullanarak matematiksel işlemleri yapabildik.
                                      hesapTutar = double.parse(t1.text);
                                      hesapOran = double.parse(t2.text);

                                      //kdv haric
                                      HarickenKdvTutari =
                                          (hesapTutar * (hesapOran / 100))
                                              .toPrecision(2);
                                      haricTutar = hesapTutar.toPrecision(2);
                                      toplamHaricTutar =
                                          (HarickenKdvTutari + haricTutar)
                                              .toPrecision(2);
                                      //kdvdahil
                                      dahilTutar =
                                          (hesapTutar / ((hesapOran / 100) + 1))
                                              .toPrecision(2);
                                      dahilkenKdvTutari =
                                          (hesapTutar - dahilTutar)
                                              .toPrecision(2);
                                      toplamDahilTutar =
                                          hesapTutar.toPrecision(2);

                                      snack(
                                          "KDV'niz %${hesapOran.toStringAsFixed(0)} oranıyla hesaplanmıştır");

                                      kdv = true;
                                      counter++;

                                      if (counter == 1) {
                                        showCupertinoDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder:
                                                (context) =>
                                                    ResponsiveScaledBox(
                                                      width: 450,
                                                      child: AlertDialog(
                                                          elevation: 1,
                                                          title: Text("Öneri"),
                                                          content: Text.rich(
                                                            TextSpan(
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                                TextSpan(
                                                                    text:
                                                                        'İNDİRİM-KOMİSYON HESAPLA',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text:
                                                                        ' sayfamızdan yararlanabilirsiniz.',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                              tooltip: "Kapat",
                                                              icon: Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ]),
                                                    ));
                                      }
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
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
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
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                //Burda yatığımız , hesapla butonuna bastığımızda  t1 ve t2 nesnelerine yazılan verilerin,
                                //hesaptutar ve hesapOran nesnelerine aktarılmasını sağladık.
                                //Bu sayede hesap tutar ve hesap oran nesnelerini kullanarak matematiksel işlemleri yapabildik.
                                hesapTutar = double.parse(t1.text);
                                hesapOran = double.parse(t2.text);

                                //kdv haric
                                HarickenKdvTutari =
                                    (hesapTutar * (hesapOran / 100))
                                        .toPrecision(2);
                                haricTutar = hesapTutar.toPrecision(2);
                                toplamHaricTutar =
                                    (HarickenKdvTutari + haricTutar)
                                        .toPrecision(2);
                                //kdvdahil
                                dahilTutar =
                                    (hesapTutar / ((hesapOran / 100) + 1))
                                        .toPrecision(2);
                                dahilkenKdvTutari =
                                    (hesapTutar - dahilTutar).toPrecision(2);
                                toplamDahilTutar = hesapTutar.toPrecision(2);

                                snack(
                                    "KDV'niz %${hesapOran.toStringAsFixed(0)} oranıyla hesaplanmıştır");
                                kdv = true;
                                counter++;

                                if (counter == 1) {
                                  showCupertinoDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) => ResponsiveScaledBox(
                                            width: 450,
                                            child: AlertDialog(
                                                elevation: 1,
                                                title: Text("Öneri"),
                                                content: Text.rich(
                                                  TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      TextSpan(
                                                          text:
                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  IconButton(
                                                    tooltip: "Kapat",
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ]),
                                          ));
                                }
                              } else {
                                snack("Lütfen bir değer girin");
                              }
                            });
                          },
                          child: hesapla),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: anaRenk,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "KDV Hariç Hesaplama",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Matrah",
                                      style: stil2,
                                    ),
                                    Text(
                                      haricTutar.toStringAsFixed(2),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "KDV Tutarı",
                                      style: stil2,
                                    ),
                                    Text(
                                      HarickenKdvTutari.toStringAsFixed(2),
                                      style: stil,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Toplam Tutar",
                                      style: stil2,
                                    ),
                                    Text(
                                      toplamHaricTutar.toStringAsFixed(2),
                                      style: stil,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: anaRenk,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "KDV Dahil Hesaplama",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Matrah",
                                      style: stil2,
                                    ),
                                    Text(
                                      dahilTutar.toStringAsFixed(2),
                                      style: stil,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "KDV Tutarı",
                                      style: stil2,
                                    ),
                                    Text(
                                      dahilkenKdvTutari.toStringAsFixed(2),
                                      style: stil,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Toplam Tutar",
                                      style: stil2,
                                    ),
                                    Text(
                                      toplamDahilTutar.toStringAsFixed(2),
                                      style: stil,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              if (kdv == true)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(eccentricity: 0.0)),
                                  child: Icon(Icons.replay),
                                  onPressed: () {
                                    setState(() {
                                      haricTutar = 0.00;
                                      HarickenKdvTutari = 0.00;
                                      toplamHaricTutar = 0.00;
                                      _focusNode1.requestFocus();
                                      dahilTutar = 0.00;
                                      dahilkenKdvTutari = 0.00;
                                      toplamDahilTutar = 0.00;
                                      t1.clear();
                                      t2.clear();
                                      kdv = false;
                                    });
                                  },
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                )
              ],
            ),

            //Tevkifat

            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 10, right: 10, bottom: 2.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                focusNode: _focusNode2,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                controller: t3,
                                style: formstil,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Tutar",
                                  hintStyle: hintstil,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: t4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.5),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.20)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.20)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 2/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("2/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.40)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.40)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 4/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("4/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.70)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.70)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 7/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("7/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                              ),
                              if (tefkkdv == true)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(eccentricity: 0.0)),
                                  child: Icon(Icons.replay),
                                  onPressed: () {
                                    setState(() {
                                      _focusNode2.requestFocus();
                                      matrahTevkifat = 0.00;
                                      TevkifatSonrasiKDV = 0.00;
                                      kdvDahilTevkifatliToplamTutar = 0.00;
                                      tevkifatOncesiKDV = 0.00;
                                      Tevkifat = 0.00;
                                      oranTevkifat = 0.00;
                                      TevkifatliToplamTutar = 0.00;

                                      //kdv dahil tevk
                                      dahilMatrahTevkifat = 0.00;
                                      dahilTevkifatOncesiKdv = 0.00;
                                      dahilTevkifatToplamTutar = 0.00;
                                      dahilKdvDahilTevkifatliToplamTutar = 0.00;
                                      dahilTevkifat = 0.00;
                                      dahilTevkifatSonrasiKdv = 0.00;
                                      t3.clear();
                                      t4.clear();
                                      tefkkdv = false;
                                    });
                                  },
                                ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.30)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.30)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 3/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("3/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.50)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.50)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 5/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("5/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            kdvDahilTevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        tevkifatOncesiKDV)
                                                    .toPrecision(2);

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.90)
                                                    .toPrecision(2);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat)
                                                    .toPrecision(2);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                        TevkifatSonrasiKDV)
                                                    .toPrecision(2);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                (matrahTevkifat /
                                                        ((oranTevkifat / 100) +
                                                            1))
                                                    .toPrecision(2);
                                            dahilTevkifatOncesiKdv =
                                                (dahilMatrahTevkifat *
                                                        (oranTevkifat / 100))
                                                    .toPrecision(2);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat.toPrecision(2);

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.90)
                                                    .toPrecision(2);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                        dahilTevkifat)
                                                    .toPrecision(2);
                                            dahilTevkifatToplamTutar =
                                                (dahilMatrahTevkifat +
                                                        dahilTevkifatSonrasiKdv)
                                                    .toPrecision(2);

                                            tefkkdv = true;
                                            counter++;

                                            if (counter == 1) {
                                              showCupertinoDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          ResponsiveScaledBox(
                                                            width: 450,
                                                            child: AlertDialog(
                                                                elevation: 1,
                                                                title: Text(
                                                                    "Öneri"),
                                                                content:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                      TextSpan(
                                                                          text:
                                                                              'İNDİRİM-KOMİSYON HESAPLA',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' sayfamızdan yararlanabilirsiniz.',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.normal)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  IconButton(
                                                                    tooltip:
                                                                        "Kapat",
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ]),
                                                          ));
                                            }
                                            snack(
                                                "KDV tutarınız 9/10 oranına göre tevkif edilecektir.");
                                          } else {
                                            snack("Lütfen bir değer girin");
                                          }
                                        });
                                      },
                                      child: Text("9/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (t3.text.isNotEmpty &&
                                          t4.text.isNotEmpty) {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        //haricTevk
                                        matrahTevkifat = double.parse(t3.text);
                                        oranTevkifat = double.parse(t4.text);
                                        tevkifatOncesiKDV = (matrahTevkifat *
                                                (oranTevkifat / 100))
                                            .toPrecision(2);
                                        kdvDahilTevkifatliToplamTutar =
                                            (matrahTevkifat + tevkifatOncesiKDV)
                                                .toPrecision(2);

                                        Tevkifat = (tevkifatOncesiKDV * 1)
                                            .toPrecision(2);
                                        TevkifatSonrasiKDV =
                                            (tevkifatOncesiKDV - Tevkifat)
                                                .toPrecision(2);
                                        TevkifatliToplamTutar =
                                            (matrahTevkifat +
                                                    TevkifatSonrasiKDV)
                                                .toPrecision(2);
                                        //dahiltevk
                                        dahilMatrahTevkifat = (matrahTevkifat /
                                                ((oranTevkifat / 100) + 1))
                                            .toPrecision(2);
                                        dahilTevkifatOncesiKdv =
                                            (dahilMatrahTevkifat *
                                                    (oranTevkifat / 100))
                                                .toPrecision(2);
                                        dahilKdvDahilTevkifatliToplamTutar =
                                            matrahTevkifat.toPrecision(2);

                                        dahilTevkifat =
                                            (dahilTevkifatOncesiKdv * 1)
                                                .toPrecision(2);
                                        dahilTevkifatSonrasiKdv =
                                            (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat)
                                                .toPrecision(2);
                                        dahilTevkifatToplamTutar =
                                            (dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv)
                                                .toPrecision(2);

                                        tefkkdv = true;
                                        counter++;

                                        if (counter == 1) {
                                          showCupertinoDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (context) =>
                                                  ResponsiveScaledBox(
                                                    width: 450,
                                                    child: AlertDialog(
                                                        elevation: 1,
                                                        title: Text("Öneri"),
                                                        content: Text.rich(
                                                          TextSpan(
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'Toplam tutarınıza indirim uygulamak isterseniz ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                              TextSpan(
                                                                  text:
                                                                      'İNDİRİM-KOMİSYON HESAPLA',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              TextSpan(
                                                                  text:
                                                                      ' sayfamızdan yararlanabilirsiniz.',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          IconButton(
                                                            tooltip: "Kapat",
                                                            icon: Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ]),
                                                  ));
                                        }
                                        snack(
                                            "KDV tutarınız tam tevkifat (10/10) oranına göre tevkif edilecektir.");
                                      } else {
                                        snack("Lütfen bir değer girin");
                                      }
                                    });
                                  },
                                  child: Text("Tam Tevkifat (10/10)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: anaRenk,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "KDV Hariç Tutardan Tevkifat Hesaplama",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5),
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
                                  matrahTevkifat.toStringAsFixed(2),
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
                                  tevkifatOncesiKDV.toStringAsFixed(2),
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
                                  "KDV Dahil Tutar",
                                  style: stil2,
                                ),
                                Text(
                                  kdvDahilTevkifatliToplamTutar
                                      .toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tevkifat Tutarı",
                                  style: stil2,
                                ),
                                Text(
                                  Tevkifat.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tevkifat Sonrası KDV Tutarı",
                                  style: stil2,
                                ),
                                Text(
                                  TevkifatSonrasiKDV.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Toplam Tutar",
                                  style: stil2,
                                ),
                                Text(
                                  TevkifatliToplamTutar.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: anaRenk,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "KDV Dahil Tutardan Tevkifat Hesaplama",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5),
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
                                  dahilMatrahTevkifat.toStringAsFixed(2),
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
                                  dahilTevkifatOncesiKdv.toStringAsFixed(2),
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
                                  "KDV Dahil Tutar",
                                  style: stil2,
                                ),
                                Text(
                                  dahilKdvDahilTevkifatliToplamTutar
                                      .toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tevkifat Tutarı",
                                  style: stil2,
                                ),
                                Text(
                                  dahilTevkifat.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tevkifat Sonrası KDV Tutarı",
                                  style: stil2,
                                ),
                                Text(
                                  dahilTevkifatSonrasiKdv.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Toplam Tutar",
                                  style: stil2,
                                ),
                                Text(
                                  dahilTevkifatToplamTutar.toStringAsFixed(2),
                                  style: stil,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                    ),
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
      ),
    );
  }
}

TextStyle stil = TextStyle(color: Colors.black, fontSize: 18);
TextStyle stil2 =
    TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
