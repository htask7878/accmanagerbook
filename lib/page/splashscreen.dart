import 'package:accmanagerbook/model.dart';
import 'package:flutter/material.dart';

import 'first.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  wait() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => first(),
        ));
  }


  @override
  void initState() {
    super.initState();
    wait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          child:ColoredBox(
            child: Center(
                child: Icon(
              Icons.book,
              color: Colors.white,
                  size: 80,
            )),
            color: model.bluecolor,
          )),
    );
  }
}
