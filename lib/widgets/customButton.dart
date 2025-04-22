import 'package:flutter/material.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/theme/app_colours.dart';

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


class Custombutton2 extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback ontap;

  const Custombutton2({super.key, required this.width, required this.height, required this.text, required this.ontap});

  @override
  State<Custombutton2> createState() => _Custombutton2State();
}

class _Custombutton2State extends State<Custombutton2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.primaryColor2),
        width: widget.width,
        height:  widget.height,
        child: Center(
          child: Text(widget.text, style: TextStyle(color: AppColors.textBlackColor)),
        ),
      ),
    );
  }
}
