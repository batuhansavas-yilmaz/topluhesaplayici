import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'GorevButonlari.dart';
import 'main.dart';

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

class ZRaporu extends StatefulWidget {
  @override
  _ZRaporuState createState() => _ZRaporuState();
}

class _ZRaporuState extends State<ZRaporu> {
  TextEditingController k1 = TextEditingController(text: '');
  TextEditingController k2 = TextEditingController(text: '');
  TextEditingController tutar = TextEditingController(text: '');

  double buyukKumul = 0.00;
  double kucukKumul = 0.00;
  double tuTar = 0.00;
  double sonuc = 0.00;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: GeriButton()
          ),
        ),
        title: Text(
          "Eksik Z Raporu Bulma",
          style: appBarStyle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Bu Hesaplama Sadece Tek Tip Kdv Oranı\nİçeren Z Raporları İçin Kullanılabilir.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeVertical* 2.5)),
                  ],
                ),
                Divider(color: Colors.black),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    content: Text(
                                        "Birden Fazla Raporu Bulmak İstiyorsak:\n - Eksik Raporlar'ın 10,11,12,13 no'lu raporlar olduğunu kabul edersek, buraya yazılacak olan kümülatif tutarı 14 no'lu rapordan alacağız. \n \nTek Bir Raporu Bulmak İstiyorsak:\n - Eksik Raporun 10 no'lu rapor olduğunu kabul edersek buraya yazılacak olan kümülatif tutarı 11 no'lu rapordan alacağız."),
                                    actions: [
                                      IconButton(
                                        tooltip: "Kapat",
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                "Büyük Kümülatif",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 3,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Örnek İçin Yazıya Dokunun",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical *
                                        1.5),
                              ),
                            ],
                          ),
                        )),
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

                            textInputAction: TextInputAction.next,
                            controller: k1,
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(",")
                            ],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Kümülatif",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Büyük Tutar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Üst Satırdaki Raporun Toplam Tutarı",textAlign:
                            TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),
                        ],
                      ),
                    ),
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
                            textInputAction: TextInputAction.next,
                            controller: tutar,
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(",")
                            ],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Tutar",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                      content: Text(
                                          "Birden Fazla Raporu Bulmak İstiyorsak:\n - Eksik Raporlar'ın 10,11,12,13 no'lu raporlar olduğunu kabul edersek, buraya yazılacak olan kümülatif tutarı 9 no'lu rapordan alacağız. \n \nTek Bir Raporu Bulmak İstiyorsak:\n - Eksik Raporun 20 no'lu rapor olduğunu kabul edersek buraya yazılacak olan kümülatif tutarı 19 no'lu rapordan alacağız."),
                                      actions: [
                                        IconButton(
                                          tooltip: "Kapat",
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ]));
                        },
                        child: Column(
                          children: [
                            Text(
                              "Küçük Kümülatif",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Örnek İçin Yazıya Dokunun",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5),
                            )
                          ],
                        ),
                      ),
                    ),
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
                            onSubmitted: (value){ setState(() {
                              buyukKumul = double.parse(k1.text);
                              kucukKumul = double.parse(k2.text);
                              tuTar = double.parse(tutar.text);

                              sonuc = ((buyukKumul - kucukKumul) - tuTar);
                              FocusScope.of(context).requestFocus(new FocusNode());
                            });},
                            controller: k2,
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(",")
                            ],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Kümülatif",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          buyukKumul = double.parse(k1.text);
                          kucukKumul = double.parse(k2.text);
                          tuTar = double.parse(tutar.text);

                          sonuc = ((buyukKumul - kucukKumul) - tuTar);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      color: Colors.white,
                      child: Text(
                        "Hesapla",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Eksik Rapor/Raporlardaki Toplam Tutar :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeVertical * 2.5),
                      ),
                    ),
                    Expanded(
                      child: Text(sonuc.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            SizeConfig.blockSizeVertical * 3.38),),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
