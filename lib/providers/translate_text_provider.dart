import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter_azure_tts/flutter_azure_tts.dart';

class TranslateTextProvider with ChangeNotifier {
  Future<String> translate(String text, String from, String to) async {
    final String data = jsonEncode([
      {'Text': text}
    ]);
    String params;
    (from.isNotEmpty) ? params = '&from=$from&to=$to' : params = '&to=$to';

    final response = await http.post(
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

    translated = translation[0]['translations'][0]['text'];
    setDetectedLan(translation[0]['detectedLanguage']['language']);
    setTranslated(translation[0]['translations'][0]['text']);
    return null;
  }

  String toTranslate = "";
  String translated = "";
  String swapTranslate = "";
  String detectedLan = "";

  String get getToTranslate => toTranslate;
  String get getTranslated => translated;
  String get getDetectedLan => detectedLan;

  void setToTranslate(text) {
    toTranslate = text;
    notifyListeners();
  }

  void setTranslated(text) {
    translated = text;
    if (text != translated) {
      translated = text;
      notifyListeners(); // Notify if the text changed
    }
    notifyListeners();
  }

  void setDetectedLan(text) {
    detectedLan = text;
    notifyListeners();
  }

  void swapTranslation() {
    swapTranslate = toTranslate;
    toTranslate = translated;
    translated = swapTranslate;
    notifyListeners();
  }

  void start(from, to) {
    translate(toTranslate, from, to);
  }
}
