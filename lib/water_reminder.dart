import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DrinkWaterReminder extends StatefulWidget {
  @override
  _DrinkWaterReminderState createState() => _DrinkWaterReminderState();
}

class _DrinkWaterReminderState extends State<DrinkWaterReminder> {
  FlutterLocalNotificationsPlugin fltrNotification;
  var val, task, _selectedParam;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var iOSinitialize = new IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSinitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var andoidDetails = new AndroidNotificationDetails(
        "Channel id", "Tony Chisenga", "This is my Channel description",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: andoidDetails, iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a task", generalNotificationDetails,
    //     payload: 'New Payload');
    var scheduleTime;
    if(_selectedParam == "Hour"){
     scheduleTime = DateTime.now().add(Duration(hours: val));
    }else if(_selectedParam == "Minute"){
      scheduleTime = DateTime.now().add(Duration(minutes: val));

    }else{
      scheduleTime = DateTime.now().add(Duration(seconds: val));
    }
     
    fltrNotification.schedule(1, "Its Time", task, scheduleTime,
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: RaisedButton(
        //   onPressed: _showNotification,
        //   child: Text("Flutter notification"),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton(
                  value: _selectedParam,
                  items: [
                    DropdownMenuItem(child: Text("Seconds"),
                    value: "Seconds",
                    ),
                    DropdownMenuItem(child: Text("Minutes"),
                    value: "Minutes",
                    ),
                    DropdownMenuItem(child: Text("Hour"),
                    value: "Hour",
                    )
                  ],
                  hint: Text("Select Your Field", style: TextStyle(
                    color: Colors.black
                  ),),
                  onChanged: (_val){
                    setState(() {
                      _selectedParam = _val;
                    });
                  },
                  ),
                  DropdownButton<int>(
                    value: val,
                    items: [
                      DropdownMenuItem<int>(
                        child: Text("1"),
                        value: 1,
                        ),
                        DropdownMenuItem<int>(
                        child: Text("2"),
                        value: 2,
                        ),
                        DropdownMenuItem<int>(
                        child: Text("3"),
                        value: 3,
                        ),
                        DropdownMenuItem<int>(
                        child: Text("4"),
                        value: 4,
                        ),
                    ],
                    hint: Text("Select value",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onChanged: (_val){
                      val = _val;
                    },
                    ),
              ],
            ),
            RaisedButton(onPressed: _showNotification,
            child: new Text("Set new task with Notification"),)
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }
}
