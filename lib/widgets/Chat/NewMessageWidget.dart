import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'firebase_api.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);
  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  Future<String> translate(String text, String to) async {
    final String data = jsonEncode([
      {'Text': text}
    ]);
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
    // setTranslated(translation[0]['translations'][0]['text']);
    return null;
  }

  String translatedText;
  void sendMessage() async {
    _controller.clear();
    await translate(message, "en");
    await FirebaseApi.uploadMessage(widget.idUser, message, translatedText);
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
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
