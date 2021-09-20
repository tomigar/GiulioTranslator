import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tts_azure/tts_azure.dart';

class TranslateTextProvider with ChangeNotifier {
  Future<String> translate(String text, String to) async {
    final String data = jsonEncode([
      {'Text': text}
    ]);
    final String params = '&to=$to';

    final response = await http.post(
        'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0$params',
        headers: {
          'Ocp-Apim-Subscription-Key': 'a2d202b0fb324d93b71cf08572f43f1e',
          'Ocp-Apim-Subscription-Region': 'global',
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
        },
        body: data);

    var translation = json.decode(response.body);

    translated = translation[0]['translations'][0]['text'];

    return translation[0]['translations'][0]['text'];
  }

  final ttsazure = TTSAzure("b004778940754c529110b116892e81af", "northeurope");

  String toTranslate = "";
  String translated = "";

  String get getToTranslate => toTranslate;
  String get getTranslated => translated;

  void setToTranslate(text) {
    toTranslate = text;
    notifyListeners();
  }

  void setTranslated(text) {
    translated = text;
    notifyListeners();
  }

  void start(to) {
    translate(toTranslate, to);
  }
}
