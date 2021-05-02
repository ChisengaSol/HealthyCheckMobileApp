import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/weights_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uemail = user.email;

class WeightsScreen extends StatefulWidget {
  @override
  _WeightsScreenState createState() => _WeightsScreenState();
}

class _WeightsScreenState extends State<WeightsScreen> {
  TextEditingController weight = new TextEditingController();
  List<Weights> weightsList = [];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add weight"),
        backgroundColor: const Color(0xff200bb7),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 20.0,
            //width: 12.0,
            margin: EdgeInsets.only(top: 25.0, left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Date: ${now.day}/${now.month}/${now.year}", style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ), ),
            ),
          ),
          Container(
            height: 20.0,
            //width: 12.0,
            margin: EdgeInsets.only(top: 25.0, left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Time: ${now.hour}/${now.minute}", style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ), ),
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            margin: EdgeInsets.only(right: 20.0, left: 20.0),
            child: TextFormField(

              //maxLength: 100,
              controller: weight,
              decoration: InputDecoration(
                hintText: "Enter your weight in Kg",
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          FlatButton(
            color: Colors.grey,
            //padding: EdgeInsets.only(top: 30.0),
            onPressed: () {
              Map<String, dynamic> weightData = {
                "weight": weight.text,
                "day": now.day,
                "userEmail": uemail,
              };
              FirebaseFirestore.instance
                  .collection("userweights")
                  .add(weightData);
              weight.text = "";
            },
            child: Text("ADD",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),),
          ),
        ],
      ),
    );
  }
}
