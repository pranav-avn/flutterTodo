import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';

class mainDrawer extends StatelessWidget {
  const mainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: tDBlue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(width: 100, height: 100),
                  Text(
                    "ToDo",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "A test by Pranav AVN",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(leading: Icon(Icons.code), title: Text("A Flutter Test")),
          ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("contact@pranavavn.com")),
        ],
      ),
    );
  }
}
