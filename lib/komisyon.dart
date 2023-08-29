// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'yardimcilar.dart';

class Komisyon extends StatefulWidget {
  @override
  _KomisyonState createState() => _KomisyonState();
}

class _KomisyonState extends State<Komisyon> {
  double AnaPara = 0.00;
  double AlinanPay = 0.00;
  double AlinanPaySonuc = 0.00;
  double AlinanOran = 0.00;
  double AlinanOranSonuc = 0.00;
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  TextEditingController t4 = TextEditingController(text: '');

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
          "Komisyon Hesaplama",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Komisyon Oranı",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
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
                              fontSize: 25, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Ana Para",
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
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              AnaPara = double.parse(t1.text);
                              AlinanPay = double.parse(t2.text);
                              AlinanOranSonuc = (AlinanPay / AnaPara) * 100;
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
                            fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Alınan Pay",
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      AnaPara = double.parse(t1.text);
                      AlinanPay = double.parse(t2.text);
                      AlinanOranSonuc = (AlinanPay / AnaPara) * 100;
                    } else {
                      mesaj = "Lütfen bir değer girin";
                      toast();
                    }
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text("Aldığınız Pay Oranı : ",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Flexible(
                    child: Text(
                      "% ${AlinanOranSonuc.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                "Komisyon Tutarı",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(",")
                          ],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: t3,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Ana Para",
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
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t3.text.isNotEmpty && t4.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              AnaPara = double.parse(t3.text);
                              AlinanOran = double.parse(t4.text);
                              AlinanPaySonuc = (AnaPara * (AlinanOran / 100));
                            } else {
                              mesaj = "Lütfen bir değer girin";
                              toast();
                            }
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(",")
                        ],
                        controller: t4,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Alınan Oran",
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (t3.text.isNotEmpty && t4.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      AnaPara = double.parse(t3.text);
                      AlinanOran = double.parse(t4.text);
                      AlinanPaySonuc = (AnaPara * (AlinanOran / 100));
                    } else {
                      mesaj = "Lütfen bir değer girin";
                      toast();
                    }
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Aldığınız Pay : ",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${AlinanPaySonuc.toStringAsFixed(2)} Para Birimi",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
