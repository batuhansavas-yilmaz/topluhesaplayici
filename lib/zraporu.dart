import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ZRaporu extends StatefulWidget {
  @override
  _ZRaporuState createState() => _ZRaporuState();
}

class _ZRaporuState extends State<ZRaporu> {
  TextEditingController k1 = TextEditingController(text: '');
  TextEditingController k2 = TextEditingController(text: '');
  TextEditingController tutar = TextEditingController(text: '');

  double buyukKumul = 0.00;
  double kucukKumul = 0.00;
  double tuTar = 0.00;
  double sonuc = 0.00;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

        title: Text("Eksik Z Raporu"),
      ),

      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bu Hesaplama Sadece Tek Tip Kdv Oranı\nİçeren Z Raporları İçin Kullanılabilir.",
                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ],
              ),

              Divider(color:Colors.black),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector( onTap: (){
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => AlertDialog(

                              content:Text("Birden Fazla Raporu Bulmak İstiyorsak:\n - Eksik Raporlar'ın 10,11,12,13 no'lu raporlar olduğunu kabul edersek, buraya yazılacak olan kümülatif tutarı 14 no'lu rapordan alacağız. \n \nTek Bir Raporu Bulmak İstiyorsak:\n - Eksik Raporun 10 no'lu rapor olduğunu kabul edersek buraya yazılacak olan kümülatif tutarı 11 no'lu rapordan alacağız."),
                              actions: [
                                IconButton(
                                  tooltip: "Kapat",
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ]));},
                        child: Text(
                    "Eksik Rapor/Raporlardan Bir Sonraki Raporun Kümülatif Toplamı\nÖrnek İçin Yazıya Dokunun",
                    textAlign: TextAlign.center,style:TextStyle(fontSize:12)
                  ),
                      )),
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
                        child: TextField(controller: k1,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Kümülatif",
                            hintStyle: TextStyle(
                                fontSize: 20,
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
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "İlk Satırda Kümülatifini Yazdığımız Raporun Toplam Tutarı",
                    textAlign: TextAlign.center,style:TextStyle(fontSize:12)
                  )),
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
                        child: TextField(controller:tutar,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Tutar",
                            hintStyle: TextStyle(
                                fontSize: 20,
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
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(onTap: (){
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => AlertDialog(

                                content:Text("Birden Fazla Raporu Bulmak İstiyorsak:\n - Eksik Raporlar'ın 10,11,12,13 no'lu raporlar olduğunu kabul edersek, buraya yazılacak olan kümülatif tutarı 9 no'lu rapordan alacağız. \n \nTek Bir Raporu Bulmak İstiyorsak:\n - Eksik Raporun 20 no'lu rapor olduğunu kabul edersek buraya yazılacak olan kümülatif tutarı 19 no'lu rapordan alacağız."),
                                actions: [
                                  IconButton(
                                    tooltip: "Kapat",
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ]));},
                        child: Text(
                    "Eksik Rapor/Raporlardan Bir Önceki Raporun Kümülatif Toplamı\nÖrnek İçin Yazıya Dokunun",
                    textAlign: TextAlign.center,style:TextStyle(fontSize:12)
                  ),
                      )),
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
                        child: TextField(controller:k2,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Kümülatif",
                            hintStyle: TextStyle(
                                fontSize: 20,
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RaisedButton(
                  onPressed: () {setState(() {
                    buyukKumul = double.parse(k1.text);
                    kucukKumul = double.parse(k2.text);
                    tuTar = double.parse(tutar.text);

                    sonuc = ((buyukKumul-kucukKumul)-tuTar);
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });},
                  color: Colors.white,
                  child: Text(
                    "Hesapla",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(child: Text("Eksik Rapor/Raporlardaki Toplam Tutar :",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.50),)),
                Expanded(child: Text(sonuc.toStringAsFixed(2),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),

              ])
            ],
          ),
        ),
      ]),
    );
  }
}
