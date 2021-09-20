import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class MicrosoftTranslate extends StatelessWidget {
  Future<String> translate(String text, String to, String id) async {
    final String data = jsonEncode([
      {'Text': text}
    ]);
    final String params = '&to=$to';

    final response = await http.post(
        'https://api.cognitive.microsofttranslator.com/?api-version=3.0$params',
        headers: {
          'Ocp-Apim-Subscription-Key': 'b8a9843ba0374581ad6764c284d0d43d',
          'Ocp-Apim-Subscription-Region': 'westeurope',
          HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
        },
        body: data);

    var translation = json.decode(response.body);
    return translation[0]['translations'][0]['text'];
  }
}
