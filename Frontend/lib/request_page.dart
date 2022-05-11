import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/request_page_states.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;


class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  RequestPageStates _pageState = RequestPageStates.initial;
  
  ImageProvider _image = const AssetImage("assets/placeholder1.jpeg");
  String _buttonText = "Anonymize Me";

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
                image: _image,
              ),
              onPressed: () async {
                switch(_pageState) {
                  case RequestPageStates.initial:
                    await uploadImage();
                    break;

                  case RequestPageStates.imageProcessed:
                    await downloadImage();
                    break;
                }
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
              child: Text(
                _buttonText,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              onPressed: () {
                switch(_pageState) {
                  case RequestPageStates.initial:
                    processImage();
                    break;

                  case RequestPageStates.imageProcessed:
                    resetState();
                    break;
                }
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

  Future<void> uploadImage() async {
    FilePickerResult? pickResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );

    if (pickResult == null || pickResult.files.isEmpty) return;
    var bytes = pickResult.files.single.bytes;
    setState(() {
      _image = Image.memory(bytes!).image;
    });
  }

  Future<void> downloadImage() async {
    http.Response response = await http.get(
      Uri.parse("https://cdn.pixabay.com/photo/2020/09/23/14/38/woman-5596173_960_720.jpg")
    );

    var _base64 = base64Encode(response.bodyBytes);

    final _downloadAnchor = html.AnchorElement(href: 'data:image/jpeg;base64,$_base64');
    _downloadAnchor.download = 'AnonymizerImage.jpg';
    _downloadAnchor.click();
    _downloadAnchor.remove();
  }

  void processImage() {
    setState(() {
      _image = const AssetImage("assets/placeholder2.jpeg");
      _buttonText = "Back";
    });

    _pageState = RequestPageStates.imageProcessed;
  }

  void resetState() {
    setState(() {
      _image = const AssetImage("assets/placeholder1.jpeg");
      _buttonText = "Anonymize Me";
    });

    _pageState = RequestPageStates.initial;
  }
}
