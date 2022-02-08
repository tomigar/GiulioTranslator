import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/widgets/Languages/LanguagesList.dart';
import 'firebase_api.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String nativeLanguage;

  const NewMessageWidget({
    @required this.idUser,
    @required this.nativeLanguage,
    Key key,
  }) : super(key: key);
  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  String to;

  Future<String> translate(String text, String name) async {
    final String data = jsonEncode([
      {'Text': text}
    ]);
    for (final el in languages) {
      if (el["name"] == name) to = el["par"];
    }
    final String params = '&to=$to';

    final response = await post(
        Uri.parse(
            'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0$params'),
        headers: {
          'Ocp-Apim-Subscription-Key': 'a2d202b0fb324d93b71cf08572f43f1e',
          'Ocp-Apim-Subscription-Region': 'global',
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
        },
        body: data);

    var translation = json.decode(response.body);

    translatedText = translation[0]['translations'][0]['text'];
    return null;
  }

  String translatedText;
  void sendMessage() async {
    _controller.clear();
    await translate(message, widget.nativeLanguage);
    await FirebaseApi.uploadMessage(widget.idUser, message, translatedText);
  }

  stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          AvatarGlow(
            animate: _speech.isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 20.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: _listen,
              child: Icon(_speech.isListening ? Icons.mic : Icons.mic_none),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(
                () {
                  message = value;
                },
              ),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: ((val) {
          print('onStatus: $val');
          if (_speech.isNotListening) {
            setState(() {
              _isListening = false;
              _speech.stop();
            });
          }
        }),
        onError: (val) => print('onError: $val'),
      );
      _speech.isNotListening;
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
