import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as mc;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  mc.SpeechToText _mic;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  // double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _mic = mc.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: Text(_text),
          ),
        ),
        AvatarGlow(
          animate: _mic.isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_mic.isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
      ],
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _mic.initialize(
        onStatus: ((val) {
          print('onStatus: $val');
          if (_mic.isNotListening) {
            setState(() {
              _isListening = false;
              print(_isListening);
              _mic.stop();
            });
          }
        }),
        onError: (val) => print('onError: $val'),
      );
      _mic.isNotListening;
      if (available) {
        setState(() => _isListening = true);
        _mic.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _mic.stop();
    }
  }
}
