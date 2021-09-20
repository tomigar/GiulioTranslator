import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;

  @override
  void initState() {
    super.initState();
  }

  // startScan() async {
  //   List<OcrText> list = [];
  //   try {
  //     list =
  //         await FlutterMobileVision.read(fps: 5, waitTap: true, multiple: true);
  //     setState(
  //       () {
  //         for (int i = 0; i > list.length; i++) {
  //           list[i] = OcrText('nejaky text');
  //         }
  //       },
  //     );
  //   } on Exception {
  //     list.add(new OcrText('Failed to recognize text.'));
  //   }
  // }

  List<String> getValue(List<String> values) {
    print(values);
    return values;
    //You can include logic to handle the values
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    List<String> values = [];
    try {
      texts = await FlutterMobileVision.read(
        multiple: true,
        camera: _cameraOcr,
        waitTap: true,
      );
      print(texts);
      print('bottom ${texts[3].bottom}');
      print('top ${texts[2].top}');
      print('left ${texts[4].left}');
      print('top ${texts[3].right}');
      print('top ${texts[1].language}');

      texts.forEach((val) => {
            values.add(val.value.toString()),
          });
      getValue(values);
      if (!mounted) return;
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 130),
          child: Card(
            elevation: 15,
            child: Container(
                height: 80,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera),
                    Text("Scan", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )),
          )),
      onTap: () => _read(),
    );
  }
}
