import 'package:flutter/material.dart';
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
  double hesapTutar = 0.00;
  double hesapOran = 0.00;

  double haricTutar = 0.00;
  double HarickenKdvTutari = 0.00;
  double toplamHaricTutar = 0.00;

  double dahilTutar = 0.00;
  double dahilkenKdvTutari = 0.00;
  double toplamDahilTutar = 0.00;
  double dahilTevkifat = 0.00;
  double haricTevkifat = 0.00;
  double haricTevkifatIKalan = 0.00;
  double dahilTevkifatKalan = 0.00;

  /* Burda , t1 ve t2 adında 2 TextEditingController tipinde nesne ürettik.
  bunları üretmemizin amacı , textfield'de yazılacak olan yazıyı kontrol etmek,işleme sokabilmek
  */
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
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
        title: Text("KDV Hesaplayıcısı"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2.0),
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
                                    offset: Offset(0.50, 1.85), blurRadius: 2)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: t1,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                                  offset: Offset(0.50, 1.85), blurRadius: 2)
                            ]),
                        child: TextField(
                          controller: t2,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      //Burda yatığımız , hesapla butonuna bastığımızda  t1 ve t2 nesnelerine yazılan verilerin,
                      //hesaptutar ve hesapOran nesnelerine aktarılmasını sağladık.
                      //Bu sayede hesap tutar ve hesap oran nesnelerini kullanarak matematiksel işlemleri yapabildik.
                      hesapTutar = double.parse(t1.text);
                      hesapOran = double.parse(t2.text);
                      //kdv haric
                      HarickenKdvTutari = (hesapTutar * (hesapOran / 100));
                      haricTutar = hesapTutar;
                      toplamHaricTutar = HarickenKdvTutari + haricTutar;
                      //kdvdahil
                      dahilTutar = hesapTutar / ((hesapOran / 100) + 1);
                      dahilkenKdvTutari = hesapTutar - dahilTutar;
                      toplamDahilTutar = hesapTutar;
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
                          color: Colors.blue[900],
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
                          padding: const EdgeInsets.only(left: 4, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ara Toplam",
                                style: stil,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "KDV Tutarı",
                                style: stil,
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
                          padding: const EdgeInsets.only(left: 4, bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toplam Tutar",
                                style: stil,
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
                          color: Colors.blue[900],
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
                          padding: const EdgeInsets.only(left: 4, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ara Toplam",
                                style: stil,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "KDV Tutarı",
                                style: stil,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toplam Tutar",
                                style: stil,
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
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue[900],
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Tevkifat Hesaplama",
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    RaisedButton(color: Colors.white,
                        onPressed: () {setState(() {
                          dahilTevkifat=toplamDahilTutar*0.30;

                          haricTevkifat=toplamHaricTutar*0.30;
                          dahilTevkifatKalan = toplamDahilTutar-dahilTevkifat;
                          haricTevkifatIKalan = toplamDahilTutar-haricTevkifat;
                        });},
                        child: Text("3/10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    RaisedButton(color: Colors.white,
                        onPressed: () {setState(() {
                          dahilTevkifat=toplamDahilTutar*0.50;
                          haricTevkifat=toplamHaricTutar*0.50;dahilTevkifatKalan = toplamDahilTutar-dahilTevkifat;
                          haricTevkifatIKalan = toplamDahilTutar-haricTevkifat;
                        });},
                        child: Text("5/10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: [
                    RaisedButton(color: Colors.white,
                        onPressed: () {setState(() {
                          dahilTevkifat=toplamDahilTutar*0.70;
                          haricTevkifat=toplamHaricTutar*0.70;dahilTevkifatKalan = toplamDahilTutar-dahilTevkifat;
                          haricTevkifatIKalan = toplamDahilTutar-haricTevkifat;
                        });},
                        child: Text("7/10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    RaisedButton(color: Colors.white,
                        onPressed: () {setState(() {
                          dahilTevkifat=toplamDahilTutar*0.90;
                          haricTevkifat=toplamHaricTutar*0.90;dahilTevkifatKalan = toplamDahilTutar-dahilTevkifat;
                          haricTevkifatIKalan = toplamDahilTutar-haricTevkifat;
                        });},
                        child: Text("9/10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Container(margin: EdgeInsets.symmetric(horizontal: 30),decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "KDV Hariç",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "KDV Dahil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container( width: SizeConfig.blockSizeHorizontal *50,
                            child: Column(
                              children: [
                                Text(
                                  "TEVKİFAT TUTARI",textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),Divider(color: Colors.black,)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${haricTevkifat.toStringAsFixed(2)}",
                                style: stil,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                  "${dahilTevkifat.toStringAsFixed(2)}",
                                style: stil,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(width: SizeConfig.blockSizeHorizontal *50,
                            child: Column(
                              children: [
                                Text(
                                  "ÖDENECEK TUTAR",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                                ),Divider(color:Colors.black)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${haricTevkifatIKalan.toStringAsFixed(2)}",
                                style: stil,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${dahilTevkifatKalan.toStringAsFixed(2)}",
                                style: stil,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 150,)],
      ),
    );
  }
}

TextStyle stil = TextStyle(color: Colors.black, fontSize: 20);
