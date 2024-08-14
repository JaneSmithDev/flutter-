import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.cyan,
      width: double.infinity,
      height: 180,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/sachin.png')
              )
            ),
          ),
          Text("Profile",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),

        ],
      ),
    );
  }
}