import 'package:flutter/material.dart';

class KdvHesaplayicisi extends StatefulWidget {
  @override
  KdvHesaplayicisiState createState() => KdvHesaplayicisiState();
}

class KdvHesaplayicisiState extends State<KdvHesaplayicisi> {
  @override
  double hesapTutar = 0.00;
  double hesapOran = 0.00;

  double haricTutar = 0.00;
  double HarcikenKdvTutari = 0.00;
  double toplamHaricTutar = 0.00;

  double dahilTutar = 0.00;
  double dahilkenKdvTutari = 0.00;
  double toplamDahilTutar = 0.00;

  /* Burda , t1 ve t2 adında 2 TextEditingController tipinde nesne ürettik.
  bunları üretmemizin amacı , textfield'de yazılacak olan yazıyı kontrol etmek,işleme sokabilmek
  */
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Kdv Hesaplayicisi"),
      ),
      backgroundColor: Colors.blue[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.50, 1.85), blurRadius: 2)
                          ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: t1,
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.50, 1.85), blurRadius: 2)
                            ]),
                        child: TextField(
                          controller: t2,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "KDV Oranı",
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
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            //Burda yatığımız , hesapla butonuna bastığımızda  t1 ve t2 nesnelerine yazılan verilerin,
                            //hesaptutar ve hesapOran nesnelerine aktarılmasını sağladık.
                            //Bu sayede hesap tutar ve hesap oran nesnelerini kullanarak matematiksel işlemleri yapabildik.
                            hesapTutar = double.parse(t1.text);
                            hesapOran = double.parse(t2.text);
                            //kdv haric
                            HarcikenKdvTutari =
                                (hesapTutar * (hesapOran / 100));
                            haricTutar = hesapTutar;
                            toplamHaricTutar = HarcikenKdvTutari + haricTutar;
                            //kdvdahil
                            dahilTutar = hesapTutar / ((hesapOran / 100) + 1);
                            dahilkenKdvTutari = hesapTutar - dahilTutar;
                            toplamDahilTutar = hesapTutar;
                          });
                        },
                        child: Text(
                          "Hesapla",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "KDV Hariç Hesaplama",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Ara Toplam",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              haricTutar.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "KDV Tutarı",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              HarcikenKdvTutari.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Toplam Tutar",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              toplamHaricTutar.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "KDV Dahil Hesaplama",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Ara Toplam",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              dahilTutar.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "KDV Tutarı",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              dahilkenKdvTutari.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Toplam Tutar",
                                  style: stil,
                                ),
                              )),
                          Expanded(
                            child: Text(
                              toplamDahilTutar.toStringAsFixed(2),
                              style: stil,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle stil = TextStyle(color: Colors.black, fontSize: 20);
