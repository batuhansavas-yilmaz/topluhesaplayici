import 'package:flutter/material.dart';

import 'main.dart';

class Aquarium extends StatefulWidget {
  @override
  _AquariumState createState() => _AquariumState();
}

class _AquariumState extends State<Aquarium> {
  TextEditingController en_ = TextEditingController(text: "");
  TextEditingController derinlik_ = TextEditingController(text: "");
  TextEditingController uzunluk_ = TextEditingController(text: "");
  double en = 0.00;
  double derinlik = 0.00;
  double uzunluk = 0.00;
  double sonuc = 0.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Renkler.arkaPlanRenk,
      appBar: AppBar(
        title:Text("Akvaryum"),
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: IconButton(
                tooltip: "Geri",
                icon: Icon(Icons.arrow_drop_down_circle_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        backgroundColor: Renkler.appBarRenk,
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Akvaryumunuzun Bilgilerini cm Cinsinden Giriniz",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(margin:EdgeInsets.only(right:5,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: derinlik_,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Derinlik",
                        hintStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(margin:EdgeInsets.only(left:5,right:5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: en_,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "En",
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(margin:EdgeInsets.only(left:5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: uzunluk_,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Uzunluk",
                        hintStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hesapla",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context)
                          .requestFocus(new FocusNode()); // klavye kapatıcı
                      uzunluk = double.parse(uzunluk_.text);
                      en = double.parse(en_.text);
                      derinlik = double.parse(derinlik_.text);
                      sonuc = (uzunluk * en * derinlik) / 1000;
                    });
                  },
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Akvaryumunuzun kapasitesi : ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),Text(
                    "${sonuc.toStringAsFixed(2)} Litre ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
