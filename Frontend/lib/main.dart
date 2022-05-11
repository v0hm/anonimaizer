import 'package:flutter/material.dart';
import 'package:frontend/request_page.dart';
void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Anonymizer"),
            backgroundColor: Colors.deepPurple,
          ),
          body: const RequestPage(),
        ),
      ),
    );
  }
}