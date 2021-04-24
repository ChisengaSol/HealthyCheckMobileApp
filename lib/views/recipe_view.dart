import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Recipe extends StatefulWidget {
  final String postUrl;

  Recipe({this.postUrl});

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  String finalUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (widget.postUrl.contains("http://")) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
    } else {
      finalUrl = widget.postUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 30.0,
                    right: Platform.isIOS ? 60 : 30,
                    left: 24,
                    bottom: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff213a50),
                    const Color(0xff071930),
                  ]),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment:
                      kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Healthy",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Check",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
                child: WebView(
                  initialUrl: finalUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      _controller.complete(webViewController);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
