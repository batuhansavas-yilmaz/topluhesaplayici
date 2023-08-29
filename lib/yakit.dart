import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toplu_hesaplayici/tools/yardimcilar.dart';

class YakitTuketimi extends StatefulWidget {
  const YakitTuketimi({super.key});

  @override
  State<YakitTuketimi> createState() => _YakitTuketimiState();
}

class _YakitTuketimiState extends State<YakitTuketimi> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();

  double sonuc = 0.00;
  double kapasite = 0.00;
  double tamDepoKm = 0.00;
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: yakitReklam,
      size: AdSize.banner,
      request: AdRequest(keywords: [
        'flutter',
        'invoice',
        'tax',
        'tools',
        'solver',
        'aquarium',
        'fish',
        "car",
        "horse",
        "power",
        "hp"
      ]),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _bannerAd!.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Yakıt Tüketimi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Aracınızın bilgilerini girerek km'de"
                " kaç lt tükettiğini hesaplayabilirsiniz. ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Depo Kapasitesi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: t1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(",")
                        ],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'LT',
                          hintStyle: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal),
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Tam Depo Gidilen KM ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              kapasite = double.parse(t1.text);
                              tamDepoKm = double.parse(t2.text);
                              sonuc = (kapasite / tamDepoKm) * 100;
                            } else {
                              showToast("Lütfen bir değer girin",
                                  context: context,
                                  animation: StyledToastAnimation.fade,
                                  curve: Curves.linear,
                                  reverseCurve: Curves.linear,
                                  duration: Duration(seconds: 4),
                                  position: StyledToastPosition.center);
                            }
                          });
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(",")
                        ],
                        controller: t2,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'KM',
                          hintStyle: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal),
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty && t2.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        kapasite = double.parse(t1.text);
                        tamDepoKm = double.parse(t2.text);
                        sonuc = (kapasite / tamDepoKm) * 100;
                      } else {
                        showToast("Lütfen bir değer girin",
                            context: context,
                            animation: StyledToastAnimation.fade,
                            curve: Curves.linear,
                            reverseCurve: Curves.linear,
                            duration: Duration(seconds: 4),
                            position: StyledToastPosition.center);
                      }
                    });
                  },
                  child: Text(
                    "Hesapla",
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Aracınız KM\nbaşına ortalama :  ",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${sonuc.toStringAsFixed(2)} lt ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text("yakıt tüketiyor",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(
                height: 170,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isBannerAdReady
              ? SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!))
              : SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.blue, boxShadow: [
              BoxShadow(offset: Offset(-0.00, -0.10), blurRadius: 0.3)
            ]),
            height: 1,
          ),
        ],
      ),
    );
  }
}
