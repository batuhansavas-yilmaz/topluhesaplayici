import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'yardimcilar.dart';
import 'endeksYorum.dart';

class KitleEndeksi extends StatefulWidget {
  @override
  KitleEndeksiState createState() => KitleEndeksiState();
}

class KitleEndeksiState extends State<KitleEndeksi> {
  TextEditingController kg = TextEditingController(text: "");
  TextEditingController boy = TextEditingController(text: "");
  double kG = 0;
  double boY = 0;
  static double sonuc = 0.00;
  static String sonucMetin = "";

  @override
  Widget build(BuildContext context) {
    Yorum.yorum();

    return Scaffold(
      appBar: AppBar(
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(child: GeriButton()),
        ),
        title: Text(
          "Vücut Kitle Endeksi",
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "18 Yaşına Kadar Olan Bireylerin \nVücut Kitle Endekslerini Öğrenmeleri İçin \nDiyetisyenlerden Yardım Almaları Önerilir.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextFormField(
                          controller: kg,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(",")
                          ],
                          decoration: InputDecoration(
                            hintText: "Kilo",
                            hintStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode()); // klavye kapatıcı
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text("Uyarı"),
                                            content: Text(
                                                'Edindiğiniz sonuçlar formulize olarak doğru olsa bile '
                                                'sağlığınız açısından en güvenilir sonuçlar için diyetisyenlerden '
                                                'yardım almanızı öneririz.'),
                                            actions: [
                                              IconButton(
                                                tooltip: "Kapat",
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ]));
                                kG = double.parse(kg.text);
                                boY = double.parse(boy.text);
                                sonuc = kG / ((boY / 100) * (boY / 100));
                              } else {
                                showToast("Lütfen bir değer girin",
                                    context: context,
                                    animation: StyledToastAnimation.fade,
                                    curve: Curves.linear,
                                    reverseCurve: Curves.linear,
                                    duration: Duration(seconds: 4),
                                    position: StyledToastPosition.center);
                              }
                            });
                          },
                          controller: boy,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(",")
                          ],
                          decoration: InputDecoration(
                            hintText: "Boy(cm)",
                            hintStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  child: Text(
                    "Hesapla",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                        FocusScope.of(context)
                            .requestFocus(new FocusNode()); // klavye kapatıcı
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text("Uyarı"),
                                    content: Text(
                                        'Edindiğiniz sonuçlar formulize olarak doğru olsa bile '
                                        'sağlığınız açısından en güvenilir sonuçlar için diyetisyenlerden '
                                        'yardım almanızı öneririz.'),
                                    actions: [
                                      IconButton(
                                        tooltip: "Kapat",
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ]));
                        kG = double.parse(kg.text);
                        boY = double.parse(boy.text);
                        sonuc = kG / ((boY / 100) * (boY / 100));
                      } else {
                        showToast("Lütfen bir değer girin",
                            context: context,
                            animation: StyledToastAnimation.fade,
                            curve: Curves.linear,
                            reverseCurve: Curves.linear,
                            duration: Duration(seconds: 4),
                            position: StyledToastPosition.center);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Sonuç : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sonuc.toStringAsFixed(2),
                style: TextStyle(fontSize: 30),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              "Yorumsal Sonuç",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                Divider(
                  color: Colors.black,
                ),
                Text(
                  sonucMetin,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
