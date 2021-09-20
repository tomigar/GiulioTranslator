import 'package:flutter/material.dart';

class LanguageSelectProvider with ChangeNotifier {
  String languageOne = 'Choose your language';
  String languageTwo = 'Choose your language';
  String languageX;

  String languageParOne = "";
  String languageParTwo = "";
  String languageParX;

  String voiceCodeOne = "";
  String voiceCodeTwo = "";
  String voiceCodeX = "";

  String get getLanOne => languageOne;
  String get getLanTwo => languageTwo;

  String get getLanParOne => languageParOne;
  String get getLanParTwo => languageParTwo;

  String get getVoiceCodeOne => voiceCodeOne;
  String get getVoiceCodeTwo => voiceCodeTwo;

  void setLanOne(name) {
    languageOne = name;
    notifyListeners();
  }

  void setLanTwo(name) {
    languageTwo = name;
    notifyListeners();
  }

  void languageswap() {
    languageX = languageOne;
    languageOne = languageTwo;
    languageTwo = languageX;

    languageParX = languageParOne;
    languageParOne = languageParTwo;
    languageParTwo = languageParX;

    voiceCodeX = voiceCodeOne;
    voiceCodeOne = voiceCodeTwo;
    voiceCodeX = voiceCodeTwo;
    notifyListeners();
  }

  void setLanParOne(par) {
    languageParOne = par;
    notifyListeners();
  }

  void setLanParTwo(par) {
    languageParTwo = par;
    notifyListeners();
  }

  void setVoiceCodeOne(code) {
    voiceCodeOne = code;
  }

  void setVoiceCodeTwo(code) {
    voiceCodeTwo = code;
  }
}
