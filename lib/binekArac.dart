import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'GorevButonlari.dart';
import "main.dart";

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

class BinekArac extends StatefulWidget {
  @override
  _BinekAracState createState() => _BinekAracState();
}

class _BinekAracState extends State<BinekArac> {
  double tutar = 0.00;

  double kdvOran = 0.00;
  double giderKabulEdilenMatrah = 0.00;
  double giderKabulEdilenKdv = 0.00;
  double giderKabulEdilenTutar=0.00;
  double giderKabulEdilmeyenMatrah = 0.00;
  double giderKabulEdilmeyenKdv = 0.00;
  double giderKabulEdilmeyenTutar = 0.00;
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) { SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("%70'lik Binek Araç Giderleri",style: appBarStyle,),
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: GeriButton()
          ),
        ),
        actions: [
          IconButton(
              tooltip: "Bilgi",
              icon: Icon(Icons.info),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Bilgi"),
                    content: Text(
                        "Bu hesaplayıcı binek araç giderlerinin sadece %70'ini gider gösterebilen vergi mükellefleri içindir."),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0,left: 18,right:18),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.50, 1.85),
                                blurRadius: 2)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        keyboardType:
                        TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(",")
                        ],
                        controller: t1,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Toplam Tutar",
                          hintStyle: TextStyle(
                              fontSize: 23,
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
                          BoxShadow(
                              offset: Offset(0.50, 1.85),
                              blurRadius: 2)
                        ]),
                    child: TextField(
                      onSubmitted: (value){
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          tutar = double.parse(t1.text);
                          kdvOran = double.parse(t2.text);
                          giderKabulEdilenTutar = (tutar * 0.70);
                          giderKabulEdilenMatrah =
                          (giderKabulEdilenTutar / ((kdvOran / 100) + 1));
                          giderKabulEdilenKdv =
                              giderKabulEdilenTutar - giderKabulEdilenMatrah;
                          giderKabulEdilmeyenTutar = (tutar * 0.30);
                          giderKabulEdilmeyenMatrah =
                          (giderKabulEdilmeyenTutar / ((kdvOran / 100) + 1));
                          giderKabulEdilmeyenKdv =
                              giderKabulEdilmeyenTutar - giderKabulEdilmeyenMatrah;
                        });
                      },
                      controller: t2,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(",")
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true),
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "KDV Oranı",
                        hintStyle: TextStyle(
                            fontSize: 23,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),SizedBox(height: 2,),
          RaisedButton(
            onPressed: () {
              setState(() {
                FocusScope.of(context).requestFocus(new FocusNode());
                tutar = double.parse(t1.text);
                kdvOran = double.parse(t2.text);
                giderKabulEdilenTutar = (tutar * 0.70);
                giderKabulEdilenMatrah =
                    (giderKabulEdilenTutar / ((kdvOran / 100) + 1));
                giderKabulEdilenKdv =
                    giderKabulEdilenTutar - giderKabulEdilenMatrah;
                giderKabulEdilmeyenTutar = (tutar * 0.30);
                giderKabulEdilmeyenMatrah =
                    (giderKabulEdilmeyenTutar / ((kdvOran / 100) + 1));
                giderKabulEdilmeyenKdv =
                    giderKabulEdilmeyenTutar - giderKabulEdilmeyenMatrah;
              });
            },
            color: Colors.white,
            child: Text(
              "Hesapla",
              style: TextStyle(fontSize: 16),
            ),
          ),Row(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xff2296F3),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "Gider Kabul Edilen %70'lik Tutar : ${giderKabulEdilenTutar.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
         Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Matrah",
                            style: stil2,
                          ),
                          Text(
                            giderKabulEdilenMatrah.toStringAsFixed(2),
                            style: stil,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "KDV Tutarı",
                            style: stil2,
                          ),
                          Text(
                            giderKabulEdilenKdv.toStringAsFixed(2),
                            style: stil,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xff2296F3),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Gider Kabul Edilmeyen %30'luk Tutar : ${giderKabulEdilmeyenTutar.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gider Kabul Edilmeyen Matrah",
                            style: stil2,
                          ),
                          Text(
                            giderKabulEdilmeyenMatrah.toStringAsFixed(2),
                            style: stil,
                          ),
                        ],
                      ),
                    ),Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gider Kabul Edilmeyen KDV",
                            style: stil2,
                          ),
                          Text(
                            giderKabulEdilmeyenKdv.toStringAsFixed(2),
                            style: stil,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
TextStyle stil = TextStyle(color: Colors.black, fontSize:18);
TextStyle stil2 = TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold);