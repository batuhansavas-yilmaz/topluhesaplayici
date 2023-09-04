import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'tools/yardimcilar.dart';

class Beygir extends StatefulWidget {
  @override
  _BeygirState createState() => _BeygirState();
}

class _BeygirState extends State<Beygir> {
  double kW = 0.00;
  double hP = 0.00;
  double kwtohp = 0.00;
  double kwtomhp = 0.00;
  double kwtoehp = 0.00;
  double kwtobhp = 0.00;
  double hptokw = 0.00;
  double ehptokw = 0.00;
  double bhptokw = 0.00;
  double mhptokw = 0.00;
  bool kwSonucc = false;
  bool hpSonucc = false;
  final focuskw = FocusNode();
  final focushp = FocusNode();
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: beygirReklam,
      size: AdSize.banner,
      request: requesT,
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
          title: Text(
            "Kilowatt (kW) ⇄ Beygir Gücü (hp)",
          ),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kilowatt (kW)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    focusNode: focuskw,
                    onFieldSubmitted: (value) {
                      setState(() {
                        if (t1.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          kW = double.parse(t1.text);
                          kwtohp = kW * 1.3410220896; //normal
                          kwtomhp = kW * 1.3596216173; //metric
                          kwtoehp = kW * 1.3404825737; //elect
                          kwtobhp = kW * 0.101941995; //boiler
                          kwSonucc = true;
                          t1.clear();
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
                    controller: t1,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,10}')),
                    ],
                    style: formstil,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "kW",
                      hintStyle: hintstil,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t1.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        kW = double.parse(t1.text);
                        kwtohp = kW * 1.3410220896; //normal
                        kwtomhp = kW * 1.3596216173; //metric
                        kwtoehp = kW * 1.3404825737; //elect
                        kwtobhp = kW * 0.101941995; //boiler
                        kwSonucc = true;
                        t1.clear();
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
                  child: hesapla,
                ),
                SizedBox(
                  height: 10,
                ),
                if (kwSonucc == true)
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Color.fromARGB(255, 0, 135, 245),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$kW kW",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${kwtohp.toStringAsFixed(10)} hp",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "$kW kW",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${kwtobhp.toStringAsFixed(10)} bhp",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "$kW kW",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${kwtoehp.toStringAsFixed(10)} ehp",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "$kW kW : ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${kwtomhp.toStringAsFixed(10)} mhp",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (kwSonucc == true)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(eccentricity: 0)),
                      onPressed: () {
                        setState(() {
                          focuskw.requestFocus();
                          kwSonucc = false;
                        });
                      },
                      child: Icon(Icons.replay)),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  "Beygir Gücü (hp)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    focusNode: focushp,
                    onFieldSubmitted: (value) {
                      setState(() {
                        if (t2.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          hP = double.parse(t2.text);
                          hptokw = hP * 0.7456998716;
                          mhptokw = hP * 0.73549875;
                          ehptokw = hP * 0.746;
                          bhptokw = hP * 9.8095;
                          hpSonucc = true;
                          t2.clear();
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
                    controller: t2,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,10}')),
                    ],
                    style: formstil,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "hp",
                        hintStyle: hintstil),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (t2.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        hP = double.parse(t2.text);
                        hptokw = hP * 0.7456998716;
                        mhptokw = hP * 0.73549875;
                        ehptokw = hP * 0.746;
                        bhptokw = hP * 9.8095;
                        hpSonucc = true;
                        t2.clear();
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
                  child: hesapla,
                ),
                SizedBox(
                  height: 10,
                ),
                if (hpSonucc == true)
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Color.fromARGB(255, 0, 135, 245),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$hP hp",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                "${hptokw.toStringAsFixed(10)} kW",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$hP bhp",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                "${bhptokw.toStringAsFixed(10)} kW",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$hP ehp",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                "${ehptokw.toStringAsFixed(10)} kW",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$hP mhp",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            Flexible(
                              child: Text(
                                "${mhptokw.toStringAsFixed(10)} kW",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (hpSonucc == true)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(eccentricity: 0)),
                      onPressed: () {
                        setState(() {
                          focushp.requestFocus();
                          hpSonucc = false;
                        });
                      },
                      child: Icon(Icons.replay)),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              spreadRadius: 20,
              blurRadius: 13,
              offset: const Offset(0, 20),
            )
          ]),
          child: Column(
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
              altblur
            ],
          ),
        ));
  }
}
