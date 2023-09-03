// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

  String tevk = ".../10";
  late String mesaj;
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
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
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
                                      mesaj =
                                          "KDV'niz %${hesapOran.toStringAsFixed(0)} oranıyla hesaplanmıştır";
                                      //kdv haric
                                      HarickenKdvTutari =
                                          (hesapTutar * (hesapOran / 100));
                                      haricTutar = hesapTutar;
                                      toplamHaricTutar =
                                          HarickenKdvTutari + haricTutar;
                                      //kdvdahil
                                      dahilTutar =
                                          hesapTutar / ((hesapOran / 100) + 1);
                                      dahilkenKdvTutari =
                                          hesapTutar - dahilTutar;
                                      toplamDahilTutar = hesapTutar;

                                      toast();
                                      t1.clear();
                                      t2.clear();
                                      kdv = true;
                                    } else {
                                      mesaj = "Lütfen bir değer girin";
                                      toast();
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
                      if (kdv == true)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Girilen Tutar",
                                  style: stil,
                                ),
                                Text(
                                  "Girilen KDV Oranı",
                                  style: stil,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" : ${hesapTutar.toStringAsFixed(2)}₺",
                                    style: stil2),
                                Text(" : %${hesapOran.toStringAsFixed(0)}",
                                    style: stil2),
                              ],
                            )
                          ],
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
                                mesaj =
                                    "KDV'niz %${hesapOran.toStringAsFixed(0)} oranıyla hesaplanmıştır";
                                //kdv haric
                                HarickenKdvTutari =
                                    (hesapTutar * (hesapOran / 100));
                                haricTutar = hesapTutar;
                                toplamHaricTutar =
                                    HarickenKdvTutari + haricTutar;
                                //kdvdahil
                                dahilTutar =
                                    hesapTutar / ((hesapOran / 100) + 1);
                                dahilkenKdvTutari = hesapTutar - dahilTutar;
                                toplamDahilTutar = hesapTutar;
                                t1.clear();
                                t2.clear();
                                toast();
                                kdv = true;
                              } else {
                                mesaj = "Lütfen bir değer girin";
                                toast();
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
                                color: Color.fromARGB(255, 0, 135, 245),
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
                                color: Color.fromARGB(255, 0, 135, 245),
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            mesaj =
                                                "KDV tutarınız 2/10 oranına göre tevkif edilecektir.";
                                            tevk = "2/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.20);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.20);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;
                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                            mesaj =
                                                "KDV tutarınız 4/10 oranına göre tevkif edilecektir.";
                                            tevk = "4/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.40);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.40);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;
                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                            mesaj =
                                                "KDV tutarınız 7/10 oranına göre tevkif edilecektir.";
                                            tevk = "7/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.70);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.70);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;
                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Girilen Tutar ",
                                      style: stil,
                                    ),
                                    Text(
                                      "Girilen KDV Oranı",
                                      style: stil,
                                    ),
                                    Text(
                                      "KDV Tevkifat Oranı",
                                      style: stil,
                                    ),
                                  ],
                                ),
                              if (tefkkdv == true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        " : ${matrahTevkifat.toStringAsFixed(2)}₺",
                                        style: stil2),
                                    Text(
                                        " : %${oranTevkifat.toStringAsFixed(0)}",
                                        style: stil2),
                                    Text(" : $tevk", style: stil2),
                                  ],
                                ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (t3.text.isNotEmpty &&
                                              t4.text.isNotEmpty) {
                                            mesaj =
                                                "KDV tutarınız 3/10 oranına göre tevkif edilecektir.";
                                            tevk = "3/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.30);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.30);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;

                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                            mesaj =
                                                "KDV tutarınız 5/10 oranına göre tevkif edilecektir.";
                                            tevk = "5/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.50);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.50);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;
                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                            mesaj =
                                                "KDV tutarınız 9/10 oranına göre tevkif edilecektir.";
                                            tevk = "9/10";
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            //haricTevk
                                            matrahTevkifat =
                                                double.parse(t3.text);
                                            oranTevkifat =
                                                double.parse(t4.text);
                                            tevkifatOncesiKDV =
                                                (matrahTevkifat *
                                                    (oranTevkifat / 100));
                                            kdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat +
                                                    tevkifatOncesiKDV;

                                            Tevkifat =
                                                (tevkifatOncesiKDV * 0.90);
                                            TevkifatSonrasiKDV =
                                                (tevkifatOncesiKDV - Tevkifat);
                                            TevkifatliToplamTutar =
                                                (matrahTevkifat +
                                                    TevkifatSonrasiKDV);
                                            //dahiltevk
                                            dahilMatrahTevkifat =
                                                matrahTevkifat /
                                                    ((oranTevkifat / 100) + 1);
                                            dahilTevkifatOncesiKdv =
                                                dahilMatrahTevkifat *
                                                    (oranTevkifat / 100);
                                            dahilKdvDahilTevkifatliToplamTutar =
                                                matrahTevkifat;

                                            dahilTevkifat =
                                                (dahilTevkifatOncesiKdv * 0.90);
                                            dahilTevkifatSonrasiKdv =
                                                (dahilTevkifatOncesiKdv -
                                                    dahilTevkifat);
                                            dahilTevkifatToplamTutar =
                                                dahilMatrahTevkifat +
                                                    dahilTevkifatSonrasiKdv;
                                            t3.clear();
                                            t4.clear();
                                            tefkkdv = true;
                                            toast();
                                          } else {
                                            mesaj = "Lütfen bir değer girin";
                                            toast();
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
                                        mesaj =
                                            "KDV tutarınız tam tevkifat oranına göre tevkif edilecektir.";
                                        tevk = "10/10";
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        //haricTevk
                                        matrahTevkifat = double.parse(t3.text);
                                        oranTevkifat = double.parse(t4.text);
                                        tevkifatOncesiKDV = (matrahTevkifat *
                                            (oranTevkifat / 100));
                                        kdvDahilTevkifatliToplamTutar =
                                            matrahTevkifat + tevkifatOncesiKDV;

                                        Tevkifat = (tevkifatOncesiKDV * 1);
                                        TevkifatSonrasiKDV =
                                            (tevkifatOncesiKDV - Tevkifat);
                                        TevkifatliToplamTutar =
                                            (matrahTevkifat +
                                                TevkifatSonrasiKDV);
                                        //dahiltevk
                                        dahilMatrahTevkifat = matrahTevkifat /
                                            ((oranTevkifat / 100) + 1);
                                        dahilTevkifatOncesiKdv =
                                            dahilMatrahTevkifat *
                                                (oranTevkifat / 100);
                                        dahilKdvDahilTevkifatliToplamTutar =
                                            matrahTevkifat;

                                        dahilTevkifat =
                                            (dahilTevkifatOncesiKdv * 1);
                                        dahilTevkifatSonrasiKdv =
                                            (dahilTevkifatOncesiKdv -
                                                dahilTevkifat);
                                        dahilTevkifatToplamTutar =
                                            dahilMatrahTevkifat +
                                                dahilTevkifatSonrasiKdv;
                                        t3.clear();
                                        t4.clear();
                                        tefkkdv = true;
                                        toast();
                                      } else {
                                        mesaj = "Lütfen bir değer girin";
                                        toast();
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
                            color: Color.fromARGB(255, 0, 135, 245),
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
                            color: Color.fromARGB(255, 0, 135, 245),
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
        ),
      ),
    );
  }

  toast() {
    showToast("$mesaj",
        context: context,
        animation: StyledToastAnimation.fade,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
        duration: Duration(seconds: 4),
        position: StyledToastPosition.center);
  }
}

TextStyle stil = TextStyle(color: Colors.black, fontSize: 18);
TextStyle stil2 =
    TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
