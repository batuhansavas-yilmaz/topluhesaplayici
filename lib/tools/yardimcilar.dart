import 'dart:math';

import 'package:flutter/material.dart';


//test
// String beygirReklam = 'ca-app-pub-3940256099942544/6300978111';
// String binekAracReklam = 'ca-app-pub-3940256099942544/6300978111';
// String kdvReklam = 'ca-app-pub-3940256099942544/6300978111';
// String komisyonReklam = 'ca-app-pub-3940256099942544/6300978111';
// String mainReklam = 'ca-app-pub-3940256099942544/6300978111';
// String vucutKitleReklam = 'ca-app-pub-3940256099942544/6300978111';
// String zraporuReklam = 'ca-app-pub-3940256099942544/6300978111';
// String yakitReklam = 'ca-app-pub-3940256099942544/6300978111';
// String akvaryumReklam = 'ca-app-pub-3940256099942544/6300978111';
// String yuzdeReklam = 'ca-app-pub-3940256099942544/6300978111';




var anaRenk = Color.fromARGB(255, 0, 135, 245);
var anaRenkDark = Color(0xff383e42);

// ignore: camel_case_types
var hesapla = Text("HESAPLA",
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
var formstil = TextStyle(fontSize: 23, fontWeight: FontWeight.bold);
var hintstil = TextStyle(
    fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal);
var hintstilDark = TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal,
    color: Colors.white);

//virgülden sonra doğru yuvarlama için
extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

// ignore: must_be_immutable
class GorevButton extends StatefulWidget {
  String? sayfaismi;
  String? altisim;
  String? logo;
  GorevButton(
      {required this.logo,
      required this.altisim,
      required this.sayfaismi,
      super.key});

  @override
  State<GorevButton> createState() => _GorevButtonState();
}

class _GorevButtonState extends State<GorevButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, widget.sayfaismi!);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              widget.logo.toString(),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "${widget.altisim}",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize:
                  MediaQuery.of(context).size.shortestSide < 600 ? 20 : 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}




