import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:toplu_hesaplayici/GorevButonlari.dart';

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

class Akaryakit extends StatefulWidget {
  @override
  _AkaryakitState createState() => _AkaryakitState();
}

class _AkaryakitState extends State<Akaryakit> {
  double tutar = 0.00;
  double matrah = 0.00;
  double kdv = 0.00;
  double giderKabulEdilmeyenMatrah = 0.00;
  double giderKabulEdilmeyenKdv = 0.00;
  double giderKabulEdilmeyenToplam = 0.00;

  TextEditingController t1 = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) { SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Akaryakıt Fişi"),
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: IconButton(
              tooltip: "Geri",
              icon: Icon(Icons.arrow_drop_down_circle_rounded),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
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
                        "Bu hesaplayıcı, akaryakıt giderlerinin sadece %70'ini gider gösterebilen vergi mükellefleri içindir."),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(controller: t1,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true,),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(",")
                          ],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Tutar",
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
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {setState(() {FocusScope.of(context).requestFocus(new FocusNode());
              tutar = double.parse(t1.text);

              giderKabulEdilmeyenToplam=tutar*0.30;
              matrah=(tutar*0.70)/1.18;
              kdv=matrah*0.18;
              giderKabulEdilmeyenMatrah = giderKabulEdilmeyenToplam/1.18;
              giderKabulEdilmeyenKdv = giderKabulEdilmeyenMatrah*0.18;

            });},
            color: Colors.white,
            child: Text(
              "Hesapla",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.black,
            ),
          ),Column(
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
                            matrah.toStringAsFixed(2),
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
                            kdv.toStringAsFixed(2),
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
                      color: Colors.blue[900],
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Gider Kabul Edilmeyen Tutar : ${giderKabulEdilmeyenToplam.toStringAsFixed(2)}",
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