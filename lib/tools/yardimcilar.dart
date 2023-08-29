import 'package:flutter/material.dart';

//test
String akvaryumReklam = 'ca-app-pub-3940256099942544/6300978111';
String beygirReklam = 'ca-app-pub-3940256099942544/6300978111';
String binekAracReklam = 'ca-app-pub-3940256099942544/6300978111';
String kdvReklam = 'ca-app-pub-3940256099942544/6300978111';
String komisyonReklam = 'ca-app-pub-3940256099942544/6300978111';
String mainReklam = 'ca-app-pub-3940256099942544/6300978111';
String vucutKitleReklam = 'ca-app-pub-3940256099942544/6300978111';
String zraporuReklam = 'ca-app-pub-3940256099942544/6300978111';
String yakitReklam = 'ca-app-pub-3940256099942544/6300978111';

//orjinal
//String akvaryumReklam = 'ca-app-pub-2770541050741728/3957376202';
// String beygirReklam = 'ca-app-pub-2770541050741728/5078886183';
// String binekAracReklam = 'ca-app-pub-2770541050741728/8870204809';
// String kdvReklam = 'ca-app-pub-2770541050741728/7896621210';
// String komisyonReklam = 'ca-app-pub-2770541050741728/2021478003';
// String mainReklam = 'ca-app-pub-2770541050741728/5462029565';
// String vucutKitleReklam = 'ca-app-pub-2770541050741728/1785921702';
// String zraporuReklam = 'ca-app-pub-2770541050741728/1183286472';
// String yakitReklam = 'ca-app-pub-2770541050741728/6419301289';

// ignore: camel_case_types

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
              width: 250,
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "${widget.altisim}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
