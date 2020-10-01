import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toplu_hesaplayici/kdvHesaplayicisi.dart';
import 'package:toplu_hesaplayici/vucutKitleEndeksi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Hesaplayici"),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.info),
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("53"),
                      ));
            },
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,

          crossAxisSpacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Colors.white,

                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => KdvHesaplayicisi()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/percentage.png"),height: 70,),
                    Text("Kdv Hesaplayıcı",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Colors.white,

                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => KitleEndeksi()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/love.png"),height: 70,),
                    Text("Vücut Kitle Endekssi",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),


          ],
        ));
  }
}
