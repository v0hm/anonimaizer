import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:frontend/request_page_states.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;


class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  /*
  * This is the URL used to access the server
  * Changes of this value affect the website ONLY after running ./build.sh
  *
  * Debug value: http://localhost:8080
  * Production value: http://small.knyaz.tech:80
   */
  final String _server = "http://small.knyaz.tech:80";

  RequestPageStates _pageState = RequestPageStates.initial;

  late Uint8List _imageBytes;
  late String _imageBytesExtension;
  ImageProvider _image = const AssetImage("assets/placeholder1.jpeg");

  String _buttonText = "Anonymize Me";

  _RequestPageState() {
    rootBundle.load("assets/placeholder1.jpeg").then((data) =>
        _imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    _imageBytesExtension = "jpeg";
  }

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
    _imageBytes = pickResult.files.single.bytes!;
    _imageBytesExtension = pickResult.files.single.extension!;

    setState(() {
      _image = Image.memory(_imageBytes).image;
    });
  }

  Future<void> downloadImage() async {
    var base64 = base64Encode(_imageBytes);

    final downloadAnchor = html.AnchorElement(href: 'data:image/jpeg;base64,$base64');
    downloadAnchor.download = 'AnonymizerResult.jpeg';
    downloadAnchor.click();
    downloadAnchor.remove();
  }

  Future<void> processImage() async {
    var processRequest = http.MultipartRequest("POST", Uri.parse(_server + "/api/process"));
    processRequest.files.add(http.MultipartFile.fromBytes(
      "file", _imageBytes, filename: "file." + _imageBytesExtension
    ));

    var processResponse = await processRequest.send();
    if (processResponse.statusCode == 200) {
      var responseBodyText = await processResponse.stream.bytesToString();
      var responseBody = jsonDecode(responseBodyText);

      var resultFile = responseBody["result"]["fileName"];
      var resultPath = _server + "/content" + resultFile;
      var resultUri = Uri.parse(resultPath);

      http.Response imageResponse = await http.get(resultUri);
      _imageBytes = imageResponse.bodyBytes;
    }

    setState(() {
      _image = Image.memory(_imageBytes).image;
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
