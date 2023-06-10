import 'package:accmanagerbook/model.dart';
import 'package:flutter/material.dart';

import 'first.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  wait() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const First(),
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
          bottom: true,
          child:ColoredBox(
            color: model.bluecolor,
            child: const Center(
                child: Icon(
              Icons.book,
              color: Colors.white,
                  size: 80,
            )),
          )),
    );
  }
}
