import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateProfilePic extends StatefulWidget {
  @override
  _UpdateProfilePicState createState() => _UpdateProfilePicState();
}

class _UpdateProfilePicState extends State<UpdateProfilePic> {
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload image"),
        backgroundColor: const Color(0xff200bb7),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0,),
          (imgUrl != null)
              ? Image.network(imgUrl)
              : Placeholder(
                  fallbackHeight: 200.0,
                  fallbackWidth: double.infinity,
                ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text("Upload profile picture"),
            color: Colors.grey,
            onPressed: () => uploadImage(),
          ),
        ],
      ),
    );
  }

  uploadImage() async {
    final _picker = ImagePicker();
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    //check for permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to firebase
        var timeKey = DateTime.now();
        var snapshot =
            await _storage.ref().child(timeKey.toString() + ".jpg").putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imgUrl = downloadUrl;
        });
      } else {
        print("No Path Receieved");
      }
    } else {
      print("Grant Permissions and try again");
    }
  }
}
