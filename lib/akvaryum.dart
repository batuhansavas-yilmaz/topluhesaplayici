import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Aquarium()));
}

class Aquarium extends StatefulWidget {
  @override
  _AquariumState createState() => _AquariumState();
}

class _AquariumState extends State<Aquarium> {
  TextEditingController en_ = TextEditingController(text: "");
  TextEditingController derinlik_ = TextEditingController(text: "");
  TextEditingController uzunluk_ = TextEditingController(text: "");
  TextEditingController kumCm = TextEditingController(text: "5");
  double en = 0.00;
  double derinlik = 0.00;
  double uzunluk = 0.00;
  double sonuc = 0.00;
  double bitkisiz = 0.00, bitkili = 0.00;
  double filtrasyonMin = 0.00, filtrasyonMax = 0.00;
  double isitici = 0.00;
  double kum = 0.00;
  double kumCm_ = 5.00;
  double kumKg = 0.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akvaryum"),
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
      ),
      body: ListView(
        primary: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 5,
                    ),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context)
                          .requestFocus(new FocusNode()); // klavye kapatıcı
                      uzunluk = double.parse(uzunluk_.text);
                      en = double.parse(en_.text);
                      derinlik = double.parse(derinlik_.text);
                      kumCm_ = double.parse(kumCm.text);
                      sonuc = (uzunluk * en * derinlik) / 1000;
                      bitkisiz = sonuc * 0.25;
                      bitkili = sonuc * 0.50;
                      filtrasyonMin = sonuc * 2.50;
                      filtrasyonMax = sonuc * 4.75;
                      isitici = sonuc * 0.6667;
                      kum = sonuc * 0.025;
                      kumKg = kum * kumCm_;
                    });
                  },
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                      "Akvaryumunuzun Kapasitesi",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      "${sonuc.toStringAsFixed(0)} Litre ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Tavsiye Edilen Işık Gücü",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          "Bitkili Akvaryum : " +
                              bitkili.toStringAsFixed(0) +
                              " Watt",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Bitkisiz Akvaryum : " +
                              bitkisiz.toStringAsFixed(0) +
                              " Watt",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Filtrasyon",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Minimum : ${filtrasyonMin.toStringAsFixed(1)}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              " litre/saat",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Maximum : ${filtrasyonMax.toStringAsFixed(1)}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              " litre/saat",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Tavsiye Edilen Isıtıcı Gücü",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      "${isitici.toStringAsFixed(0)} Watt",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Kum Kalınlığı",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("cm",style:TextStyle(fontSize:20)),

                              TextField(
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                controller: kumCm,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "İstediğiniz Kalınlık İçin Gerekli Kum : ${kumKg.toStringAsFixed(0)} Kg",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
