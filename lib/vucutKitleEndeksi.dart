import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KitleEndeksi extends StatefulWidget {
  @override
  _KitleEndeksiState createState() => _KitleEndeksiState();
}

class _KitleEndeksiState extends State<KitleEndeksi> {
  TextEditingController kg = TextEditingController(text: "");
  TextEditingController boy = TextEditingController(text: "");
  double kG=0;
  double boY=0;
  double sonuc =0.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text("Vücut Kitle Endeksi "),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60,
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(color: Colors.white,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Hesapla",style: TextStyle(fontSize: 30),),
                      ),
                        onPressed: () {
                          setState(() {
                            kG = double.parse(kg.text);
                            boY = double.parse(boy.text);
                            sonuc = kG / ((boY/100) *(boY/100) );print(sonuc);
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: ListTile(title: Text(sonuc.toStringAsFixed(2),style: TextStyle(fontSize: 40),textAlign: TextAlign.center,),
                leading: Text(
                  "Sonuç :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
