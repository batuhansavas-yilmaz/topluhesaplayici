import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'yardimcilar.dart';

class ZRaporu extends StatefulWidget {
  @override
  _ZRaporuState createState() => _ZRaporuState();
}

class _ZRaporuState extends State<ZRaporu> {
  TextEditingController k1 = TextEditingController(text: '');
  TextEditingController k2 = TextEditingController(text: '');
  TextEditingController tutar = TextEditingController(text: '');
  late String mesaj;
  double buyukKumul = 0.00;
  double kucukKumul = 0.00;
  double tuTar = 0.00;
  double sonuc = 0.00;
  toast() {
    showToast("$mesaj",
        context: context,
        animation: StyledToastAnimation.fade,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
        duration: Duration(seconds: 4),
        position: StyledToastPosition.center);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(child: GeriButton()),
        ),
        title: Text(
          "Eksik Z Raporu Bulma",
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
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
                          builder: (context) => AlertDialog(
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Örnek İçin Yazıya Dokunun",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Üst Satırdaki Raporun Toplam Tutarı",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
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
                              builder: (context) => AlertDialog(
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Örnek İçin Yazıya Dokunun",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            onSubmitted: (value) {
                              setState(() {
                                if (k1.text.isNotEmpty &&
                                    k2.text.isNotEmpty &&
                                    tutar.text.isNotEmpty) {
                                  buyukKumul = double.parse(k1.text);
                                  kucukKumul = double.parse(k2.text);
                                  tuTar = double.parse(tutar.text);

                                  sonuc = ((buyukKumul - kucukKumul) - tuTar);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                } else {
                                  mesaj = "Lütfen bir değer girin";
                                  toast();
                                }
                              });
                            },
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (k1.text.isNotEmpty &&
                              k2.text.isNotEmpty &&
                              tutar.text.isNotEmpty) {
                            buyukKumul = double.parse(k1.text);
                            kucukKumul = double.parse(k2.text);
                            tuTar = double.parse(tutar.text);

                            sonuc = ((buyukKumul - kucukKumul) - tuTar);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          } else {
                            mesaj = "Lütfen bir değer girin";
                            toast();
                          }
                        });
                      },
                      child: Text(
                        "Hesapla",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Eksik Rapor/Raporlardaki Toplam Tutar :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        sonuc.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20),
                      ),
                    ),
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
