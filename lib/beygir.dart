import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

import 'GorevButonlari.dart';

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
    SizeConfig().init(context);
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
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Kilowatt (kW)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 3.4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 45),
                child: Row(
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
                            controller: t1,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(",")
                            ],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    kW = double.parse(t1.text);
                    kWsonuc = kW * 1.341022;
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${kW} kW : ",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 3.4,),
                  ),
                  Text(
                    "${kWsonuc.toStringAsFixed(3)} hp",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 3.4,
                        fontWeight: FontWeight.bold),
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
                  fontSize:  SizeConfig.blockSizeVertical * 3.4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 45),
                child: Row(
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
                            controller: t2,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(",")
                            ],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    hP = double.parse(t2.text);
                    hPsonuc = hP * 0.745699872;
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.4,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${hP} hp : ",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 3.4,),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${hPsonuc.toStringAsFixed(3)} kW",
                    style: TextStyle(
                        fontSize:SizeConfig.blockSizeVertical * 3.4,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Text("DİKKAT \nHesaplamalar için mekanik değerler kullanılmaktadır!",style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.4,
                  fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}

