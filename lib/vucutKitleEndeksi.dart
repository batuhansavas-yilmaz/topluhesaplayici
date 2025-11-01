import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:responsive_framework/responsive_scaled_box.dart';
import 'main.dart';
import 'tools/yardimcilar.dart';
import 'tools/endeksYorum.dart';

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
  bool sonucc = false;
  int counter = 0;
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Yorum.yorum();

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "Vücut Kitle Endeksi",
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "18 yaşına kadar olan bireylerin \nVücut Kitle Endekslerini öğrenmeleri için \ndiyetisyenlerden yardım almaları önerilir.",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Divider(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : anaRenkDark),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: kg,
                        focusNode: _focusNode,
                        style: formstil,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: InputDecoration(
                          hintText: "Kilo",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                              FocusScope.of(context).requestFocus(
                                  new FocusNode()); // klavye kapatıcı
                              counter++;
                              if (counter == 1) {
                                showCupertinoDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) => ResponsiveScaledBox(
                                          width: 450,
                                          child: AlertDialog(
                                              elevation: 1,
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
                                              ]),
                                        ));
                              }
                              kG = double.parse(kg.text);
                              boY = double.parse(boy.text);
                              sonuc = (kG / ((boY / 100) * (boY / 100)))
                                  .toPrecision(2);

                              sonucc = true;
                            } else {
                              HomePageState.simpleNativeToastPlugin.showToast(
                                "Lütfen bir değer girin",
                              );
                            }
                          });
                        },
                        controller: boy,
                        style: formstil,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3)
                        ],
                        decoration: InputDecoration(
                          hintText: "Boy(cm)",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: hesapla,
                onPressed: () {
                  setState(() {
                    if (kg.text.isNotEmpty && boy.text.isNotEmpty) {
                      FocusScope.of(context)
                          .requestFocus(new FocusNode()); // klavye kapatıcı
                      counter++;

                      if (counter == 1) {
                        showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => ResponsiveScaledBox(
                                  width: 450,
                                  child: AlertDialog(
                                      elevation: 1,
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
                                      ]),
                                ));
                      }
                      kG = double.parse(kg.text);
                      boY = double.parse(boy.text);
                      sonuc = (kG / ((boY / 100) * (boY / 100))).toPrecision(2);

                      sonucc = true;
                    } else {
                      HomePageState.simpleNativeToastPlugin.showToast(
                        "Lütfen bir değer girin",
                      );
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (sonucc == true)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Theme.of(context).brightness == Brightness.light
                            ? anaRenk
                            : anaRenkDark,
                        child: Text(
                          "VÜCUT KİTLE ENDEKSİNİZ : ${sonuc.toStringAsFixed(2)} ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Yorum",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Divider(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : anaRenkDark),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    sonucMetin,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(eccentricity: 0.0)),
                  child: Icon(Icons.replay),
                  onPressed: () {
                    setState(() {
                      _focusNode.requestFocus();
                      boy.clear();
                      kg.clear();

                      sonucc = false;
                    });
                  },
                )
              ],
            ),
        ],
      ),
  
    );
  }



  @override
  void initState() {
    super.initState();

  }

  void dispose() {
    super.dispose();

  }
}
