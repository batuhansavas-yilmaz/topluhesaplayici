import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'yardimcilar.dart';

class Beygir extends StatefulWidget {
  @override
  _BeygirState createState() => _BeygirState();
}

class _BeygirState extends State<Beygir> {
  double kW = 0.00;
  double hP = 0.00;
  double kWsonuc = 0.00;
  double hPsonuc = 0.00;

  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: GeriButton(),
          ),
        ),
        title: Text(
          "Kilowatt (kW) ⇄ Beygir Gücü (hp)",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Kilowatt (kW)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      setState(() {
                        if (t1.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          kW = double.parse(t1.text);
                          kWsonuc = kW * 1.341022;
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
                    controller: t1,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(",")
                    ],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "kW",
                      hintStyle: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        kW = double.parse(t1.text);
                        kWsonuc = kW * 1.341022;
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
                  child: Text(
                    "Hesapla",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " $kW kW : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${kWsonuc.toStringAsFixed(3)} hp",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  "Beygir Gücü (hp)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      setState(() {
                        if (t2.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          hP = double.parse(t2.text);
                          hPsonuc = hP * 0.745699872;
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
                    controller: t2,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(",")
                    ],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "hp",
                      hintStyle: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t2.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        hP = double.parse(t2.text);
                        hPsonuc = hP * 0.745699872;
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
                  child: Text(
                    "Hesapla",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$hP hp : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${hPsonuc.toStringAsFixed(3)} kW",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "DİKKAT \nHesaplamalar için mekanik değerler kullanılmaktadır!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
