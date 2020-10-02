import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'endeksYorum.dart';

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

  @override
  Widget build(BuildContext context) {
    Yorum.yorum();
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        leading: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(-80.10),
          child: Container(
            child: IconButton(tooltip: "Geri",
                icon: Icon(Icons.arrow_drop_down_circle_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        title: Text("Vücut Kitle Endeksi "),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "18 Yaşına Kadar Olan Bireylerin \nVücut Kitle Endekslerini Öğrenmeleri İçin \nDiyetisyenlerden Yardım Almaları Önerilir.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                          controller: kg,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Kilo",
                            hintStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                          controller: boy,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Boy(cm)",
                            hintStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.normal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(decoration: BoxDecoration(boxShadow: [
                  BoxShadow(offset: Offset(0.50, 1.85), blurRadius: 2)
                ],),
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
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text("Uyarı"),
                                    content: Text(
                                        "Edindiğiniz Sonuçlar Formulize Olarak Doğru Olsa Bile Sağlığınız Açısından En Güvenilir Sonuçlar İçin Diyetisyenlerden Yardım Almanızı Öneririz."),
                                    actions: [
                                      IconButton(tooltip: "Kapat",icon: Icon(Icons.close),onPressed: (){Navigator.pop(context);},)
                                    ]));
                        kG = double.parse(kg.text);
                        boY = double.parse(boy.text);
                        sonuc = kG / ((boY / 100) * (boY / 100));
                        print(sonuc);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right:20,top:10),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Sonuç :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Text(
                  sonuc.toStringAsFixed(2),
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
         ListTile(
            title: Text(
              "Yorumsal Sonuç",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [Divider(color: Colors.black,),
                Text(
                  sonucMetin,
                  style: TextStyle(fontSize: 15.58, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
