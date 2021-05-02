import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uemail = user.email;

class MyHealthCondition extends StatefulWidget {
  @override
  _MyHealthConditionState createState() => _MyHealthConditionState();
}

class _MyHealthConditionState extends State<MyHealthCondition> {
  @override
  @override
  Widget build(BuildContext context) {
    List<double> myweights = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff200bb7),
        title: Text("My health condition"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userweights')
            .where('userEmail', isEqualTo: uemail)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              myweights.add(double.parse(document.data()['weight']));
              var sum = myweights.reduce((value, element) => value + element);

              var weightDiffs = myweights.last - myweights[0];
              var lastWeight = myweights.last;
              var averageWeight = sum / myweights.length;
              String healthStatus = "";

              if (weightDiffs.abs() > 0.907185) {
                healthStatus =
                    "The difference between your previous weight and today's weight is 2 pounds. Please do something";
              } else {
                healthStatus = "Your health status is Ok";
              }
              return Container(
                margin: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Your Previous weight is ${lastWeight}Kg and your avarage is weight is ${averageWeight}Kg. ${healthStatus}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// Future<int> countDocuments() async {
//   QuerySnapshot _myDoc = await FirebaseFirestore.instance
//       .collection('userweights')
//       .where('userEmail', isEqualTo: uemail)
//       .get();
//   List<DocumentSnapshot> _myDocCount = _myDoc.docs;

//   // Count of Documents in Collection
//   return _myDocCount.length;
// }
