
import 'package:flutter/material.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/route_extensions.dart';
import 'package:school_app/screens/CourseScreen.dart';
import 'package:school_app/screens/homeScreen.dart';

class MyCustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
        
          Container(
            height: 120,
            color: Colors.black, // Customize color
            alignment: Alignment.center,
            child: Text(
              Appconsts.schoolName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Section 1
                _buildListTile('Accueil', Icons.home, () {context.pushReplacement(Homescreen());}),
                _buildListTile('Cours', Icons.book, () {context.push(Coursescreen());}),
                _buildListTile('Cours Téléchargés', Icons.download, () {}),
                _buildListTile('Bibliothèque', Icons.library_books, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon,color: Colors.white,),
      title: Text(title, style: TextStyle(fontSize: 16,color: Colors.white)),
      onTap: onTap,
    );
  }
}