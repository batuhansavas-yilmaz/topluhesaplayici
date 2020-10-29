import 'package:flutter/material.dart';
import 'package:toplu_hesaplayici/main.dart';

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

        title: Text("KDV Hesaplayıcısı"),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom:2.0),
            child: Column(
              children: [
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
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {FocusScope.of(context).requestFocus(new FocusNode());
                    //Burda yatığımız , hesapla butonuna bastığımızda  t1 ve t2 nesnelerine yazılan verilerin,
                    //hesaptutar ve hesapOran nesnelerine aktarılmasını sağladık.
                    //Bu sayede hesap tutar ve hesap oran nesnelerini kullanarak matematiksel işlemleri yapabildik.
                    hesapTutar = double.parse(t1.text);
                    hesapOran = double.parse(t2.text);
                    //kdv haric
                    HarcikenKdvTutari = (hesapTutar * (hesapOran / 100));
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
color:Colors.blue[900],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "KDV Hariç Hesaplama",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:5.0,right:5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 2),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ara Toplam",
                                style: stil,
                              ),
                              Text(
                                haricTutar.toStringAsFixed(2),
                                style: stil,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:4,),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "KDV Tutarı",
                                style: stil,
                              ),
                              Text(
                                HarcikenKdvTutari.toStringAsFixed(2),
                                style: stil,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:4,bottom: 2),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toplam Tutar",
                                style: stil,
                              ),
                              Text(
                                toplamHaricTutar.toStringAsFixed(2),
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
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color:Colors.blue[900],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "KDV Dahil Hesaplama",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:5.0,right:5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 2),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ara Toplam",
                                style: stil,
                              ),
                              Text(
                                dahilTutar.toStringAsFixed(2),
                                style: stil,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "KDV Tutarı",
                                style: stil,
                              ),
                              Text(
                                dahilkenKdvTutari.toStringAsFixed(2),
                                style: stil,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Toplam Tutar",
                                style: stil,
                              ),
                              Text(
                                toplamDahilTutar.toStringAsFixed(2),
                                style: stil,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
                    ),
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
