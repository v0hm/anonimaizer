import 'package:flutter/material.dart';

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

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int currentImage = 1;
  AssetImage _displayedImage = const AssetImage("assets/placeholder.jpeg");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          // Top padding
          const Expanded(
            child: SizedBox(),
            flex: 1,
          ),

          // Image
          Expanded(
            child: TextButton(
              child: Image(
                image: _displayedImage,
              ),
              onPressed: () {

              },
            ),
            flex: 15,
          ),

          // Middle Padding
          const Expanded(
            child: SizedBox(),
            flex: 2,
          ),

          // Button
          Expanded(
            child: ElevatedButton(
              child: const Text(
                "Anonymize Me",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              onPressed: () {
                setState(() {
                  if (currentImage == 1) {
                    currentImage = 2;
                    _displayedImage = const AssetImage("assets/placeholder2.jpeg");

                  } else if (currentImage == 2) {
                    currentImage = 1;
                    _displayedImage = const AssetImage("assets/placeholder.jpeg");
                  }

                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 60))
              ),
            ),
            flex: 2,
          ),

         // Bottom Padding
         const Expanded(
           child: SizedBox(),
           flex: 1,
         )
        ],
      ),
    );
  }
}

