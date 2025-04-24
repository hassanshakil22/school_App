import 'package:flutter/material.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/app/theme/app_colours.dart';
import 'package:school_app/widgets/CustomDrawer.dart';
import 'package:school_app/widgets/customButton.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyCustomDrawer(),
      appBar: AppBar(title: Text(Appconsts.schoolName)),
      body: Column(
        children: [
          Text(
            'L\'ecole qui reste proche,\nmeme a distance',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,

              color: Colors.black,
            ),
          ),
          SizedBox(height: context.h * 0.05),
          Custombutton(
            width: context.w * 0.3,
            height: context.h * 0.05,
            text: "Commencer ici",
          ),
          SizedBox(height: context.h * 0.1),
          Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(90),
                  ),
                  child: Container(
                    height: 200,
                    width: 120,
                    color: AppColors.primaryColor2,
                    child: SizedBox(),
                  ),
                ),

                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      child: Container(
                        height: 90,
                        width: 120,
                        color: AppColors.primaryColor,
                        child: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 10),
     ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        topLeft: Radius.circular(60),
                      ),
                      child: Container(
                        height: 90,
                        width: 120,
                        color:  AppColors.primaryColor1,
                        child: SizedBox(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: context.h * 0.1),

          Container(
            width: context.w * 0.7,
            height: context.h * 0.2,
            child: TextField(
              expands: true,
              maxLines: null,
              minLines: null,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Editable text box",
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.blueAccent,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
          ),
          // Footer
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'POWERED BY BONECOLE INC.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



