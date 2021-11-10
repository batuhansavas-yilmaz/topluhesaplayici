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
        title: Text("Komisyon Hesaplama",style: appBarStyle,),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Komisyon Oranı",
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 3.4,
                ),
              ),
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
                          boxShadow: [
                            BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                          ]),
                      child: TextField(
                        controller: t2, inputFormatters: [
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
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    AnaPara = double.parse(t1.text);
                    AlinanPay = double.parse(t2.text);
                    AlinanOranSonuc = (AlinanPay / AnaPara) * 100;
                  });
                },
                child: Text(
                  "Hesapla",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Aldığınız Pay Oranı : "

                      ,style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 3)),Text(
                     "% ${AlinanOranSonuc.toStringAsFixed(2)}"

                      ,style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical *3,fontWeight: FontWeight.bold),),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                "Komisyon Tutarı",
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 3.4,
                ),
              ),
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
                        child: TextField( inputFormatters: [
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
                          boxShadow: [
                            BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                          ]),
                      child: TextField( inputFormatters: [
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
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    AnaPara = double.parse(t3.text);
                    AlinanOran = double.parse(t4.text);
                    AlinanPaySonuc = (AnaPara * (AlinanOran / 100));
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
                  Text(
                    "Verdiğiniz Orana Göre ",
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                    textAlign: TextAlign.center,
                  ),Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Aldığınız Pay : ",
                        style:
                            TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                        textAlign: TextAlign.center,
                      ), Text(
                        "${AlinanPaySonuc.toStringAsFixed(2)} Para Birimi",
                        style:
                            TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.4,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
