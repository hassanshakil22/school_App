import 'package:flutter/material.dart';
import 'package:school_app/app/size_extensions.dart';

class Custombutton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  const Custombutton({super.key, required this.width, required this.height, required this.text});

  @override
  State<Custombutton> createState() => _CustombuttonState();
}

class _CustombuttonState extends State<Custombutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height:  widget.height,
        color: Colors.black,
        child: Center(
          child: Text(widget.text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
