import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/weights_model.dart';

class WeightsScreen extends StatefulWidget {
  @override
  _WeightsScreenState createState() => _WeightsScreenState();
}

class _WeightsScreenState extends State<WeightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(top: 25.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnterWeightData(),
                ),
              );
            },
            child: Text("Add data"),
          )
        ],
      ),
    );
  }
}

class EnterWeightData extends StatefulWidget {
  @override
  _EnterWeightDataState createState() => _EnterWeightDataState();
}

class _EnterWeightDataState extends State<EnterWeightData> {
  TextEditingController weight = new TextEditingController();
  List<Weights> weightsList = [];

  // void initState() {
  //   super.initState();
  //   //FirebaseReference
  // }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Date: ${now.day}/${now.month}/${now.year}"),
          Text("Time: ${now.hour}/${now.minute}"),
          FlatButton(
              padding: EdgeInsets.only(top: 30.0),
              onPressed: () {
                Map<String, dynamic> weightData = {
                  "weight": weight.text,
                };
                FirebaseFirestore.instance
                    .collection("userweights")
                    .add(weightData);
              },
              child: Text("Add")),
          // Padding(padding: EdgeInsets.only(top: 30.0,)
          TextFormField(
            controller: weight,
            decoration: InputDecoration(hintText: "Enter your weight"),
          ),
        ],
      ),
    );
  }
}
