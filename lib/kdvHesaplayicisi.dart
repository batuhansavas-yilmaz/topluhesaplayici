import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:toplu_hesaplayici/main.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class KdvHesaplayicisi extends StatefulWidget {
  @override
  KdvHesaplayicisiState createState() => KdvHesaplayicisiState();
}

class KdvHesaplayicisiState extends State<KdvHesaplayicisi> {
  @override
  String tevk = ".../10";
  String mesaj;
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

  /* Burda , t1 ve t2 adında 2 TextEditingController tipinde nesne ürettik.
  bunları üretmemizin amacı , textfield'de yazılacak olan yazıyı kontrol etmek,işleme sokabilmek
  */
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  TextEditingController t4 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorWeight: 3,
              tabs: [
                FlatButton(
                  child: Text(
                    "Tevkifatlı KDV Hesaplama",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: SizeConfig.blockSizeVertical * 0.70,
                          offset: Offset(SizeConfig.blockSizeVertical * 0.35,
                              SizeConfig.blockSizeVertical * 0.25),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                    "KDV Hesaplama",textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: SizeConfig.blockSizeVertical * 0.70,
                          offset: Offset(SizeConfig.blockSizeVertical * 0.35,
                              SizeConfig.blockSizeVertical * 0.25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            leading: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.rotationZ(-80.10),
              child: Container(
                child: IconButton(
                    tooltip: "Geri",
                    icon: Icon(Icons.arrow_drop_down_circle_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            title: Text(
              "KDV Hesaplayıcısı",
              style: appBarStyle,
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0.50, 1.85),
                                          blurRadius: 2)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(",")
                                  ],
                                  controller: t3,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "Tutar",
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
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0.50, 1.85),
                                        blurRadius: 2)
                                  ]),
                              child: TextField(
                                controller: t4,
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
                                  hintText: "KDV Oranı",
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
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 2/10 oranına göre tevkif edilecektir.";
                                          tevk = "2/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.20);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                              (dahilTevkifatOncesiKdv * 0.20);
                                          dahilTevkifatSonrasiKdv =
                                              (dahilTevkifatOncesiKdv -
                                                  dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;


                                          toast();
                                        });
                                      },
                                      child: Text("2/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 3/10 oranına göre tevkif edilecektir.";
                                          tevk = "3/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.30);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 0.30);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;
                                          toast();
                                        });
                                      },
                                      child: Text("3/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Row(
                                children: [
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 4/10 oranına göre tevkif edilecektir.";
                                          tevk = "4/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.40);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 0.40);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;

                                          toast();
                                        });
                                      },
                                      child: Text("4/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(tevk,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 5/10 oranına göre tevkif edilecektir.";
                                          tevk = "5/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.50);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 0.50);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;

                                          toast();
                                        });
                                      },
                                      child: Text("5/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Row(
                                children: [
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 7/10 oranına göre tevkif edilecektir.";
                                          tevk = "7/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.70);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 0.70);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;

                                          toast();
                                        });
                                      },
                                      child: Text("7/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                  RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız 9/10 oranına göre tevkif edilecektir.";
                                          tevk = "9/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

                                          Tevkifat = (tevkifatOncesiKDV * 0.90);
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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 0.90);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;

                                          toast();
                                        });
                                      },
                                      child: Text("9/10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          mesaj =
                                              "KDV tutarınız tam tevkifat oranına göre tevkif edilecektir.";
                                          tevk = "10/10";
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          //haricTevk
                                          matrahTevkifat =
                                              double.parse(t3.text);
                                          oranTevkifat = double.parse(t4.text);
                                          tevkifatOncesiKDV = (matrahTevkifat *
                                              (oranTevkifat / 100));
                                          kdvDahilTevkifatliToplamTutar =matrahTevkifat+tevkifatOncesiKDV;

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
                                          dahilKdvDahilTevkifatliToplamTutar =matrahTevkifat;

                                          dahilTevkifat =
                                          (dahilTevkifatOncesiKdv * 1);
                                          dahilTevkifatSonrasiKdv =
                                          (dahilTevkifatOncesiKdv -
                                              dahilTevkifat);
                                          dahilTevkifatToplamTutar =
                                              dahilMatrahTevkifat +
                                                  dahilTevkifatSonrasiKdv;

                                          toast();
                                        });
                                      },
                                      color: Colors.white,
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
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Color(0xff2296F3),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "KDV Hariç Tutardan Tevkifat Hesaplama",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
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
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "KDV Tutarı",
                                              style: stil2,
                                            ),
                                            Text(
                                              tevkifatOncesiKDV
                                                  .toStringAsFixed(2),
                                              style: stil,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tevkifat Sonrası KDV Tutarı",
                                              style: stil2,
                                            ),
                                            Text(
                                              TevkifatSonrasiKDV
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Toplam Tutar",
                                              style: stil2,
                                            ),
                                            Text(
                                              TevkifatliToplamTutar
                                                  .toStringAsFixed(2),
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
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Color(0xff2296F3),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "KDV Dahil Tutardan Tevkifat Hesaplama",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
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
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Matrah",
                                              style: stil2,
                                            ),
                                            Text(
                                              dahilMatrahTevkifat
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
                                              dahilTevkifatOncesiKdv
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
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tevkifat Sonrası KDV Tutarı",
                                              style: stil2,
                                            ),
                                            Text(
                                              dahilTevkifatSonrasiKdv
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Toplam Tutar",
                                              style: stil2,
                                            ),
                                            Text(
                                              dahilTevkifatToplamTutar
                                                  .toStringAsFixed(2),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
              ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 2.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0.50, 1.85),
                                            blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    onFieldSubmitted: (value){},
                                  textInputAction: TextInputAction.go,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(",")
                                    ],
                                    controller: t1,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Tutar",
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
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0.50, 1.85),
                                          blurRadius: 2)
                                    ]),
                                child: TextFormField(
                                  onFieldSubmitted: (value){},
                                  textInputAction: TextInputAction.go,
                                  controller: t2,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(",")
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "KDV Oranı",
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
                        RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
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
                              toplamHaricTutar = HarickenKdvTutari + haricTutar;
                              //kdvdahil
                              dahilTutar = hesapTutar / ((hesapOran / 100) + 1);
                              dahilkenKdvTutari = hesapTutar - dahilTutar;
                              toplamDahilTutar = hesapTutar;


                              toast();
                            });
                          },
                          child: Text(
                            "Hesapla",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
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
                                  color: Color(0xff2296F3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "KDV Hariç Hesaplama",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 2),
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
                                      ),
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
                                  color: Color(0xff2296F3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "KDV Dahil Hesaplama",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 2),
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
            ],
          ),
        ));
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
