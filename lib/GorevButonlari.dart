import 'package:flutter/material.dart';

class GeriButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: "Geri",
        icon: Icon(Icons.arrow_drop_down_circle_rounded),
        onPressed: () {
          Navigator.pop(
            context,
          );
        });
  }
}

// ignore: must_be_immutable
class GorevButton extends StatefulWidget {
  String? sayfaismi;
  String? altisim;
  String? logo;
  GorevButton(
      {required this.logo,
      required this.altisim,
      required this.sayfaismi,
      super.key});

  @override
  State<GorevButton> createState() => _GorevButtonState();
}

class _GorevButtonState extends State<GorevButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lime,
          ),
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, widget.sayfaismi!);
            });
          },
          child: Image.asset(
            widget.logo.toString(),
          ),
        ),
        Text("${widget.altisim}"),
      ],
    );
  }
}

// ignore: must_be_immutable

