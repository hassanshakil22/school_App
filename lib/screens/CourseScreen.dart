import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/route_extensions.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/screens/lessonScreen.dart';
import 'package:school_app/widgets/CustomDrawer.dart';

class Coursescreen extends StatelessWidget {
  const Coursescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyCustomDrawer(),
      appBar: AppBar(title: Text(Appconsts.schoolName)),
      body: Column(
        children: [
          Center(
            child: Text(
              "6eme Annee",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Width / Height ratio
                ),
                itemBuilder: (context, index) {
                  return CourseContainers(onTap: () {context.push(LessonScreen());});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseContainers extends StatelessWidget {
  final VoidCallback onTap;
  const CourseContainers({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.w * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.h*0.12,
              child: ClipRRect(
              
                borderRadius: BorderRadius.circular(
                  8,
                ),
                child: Image.asset(
                  
                  "assets/blacboardpng.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text("Mathematiques",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
            ),
            Divider(thickness: 0.5,)
          ],
        ),
      ),
    );
  }
}
