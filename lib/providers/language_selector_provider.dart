import 'package:flutter/material.dart';
import 'package:translator_app/widgets/Languages/LanguagesList.dart';

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

  bool search = false;

  List<Map<String, String>> results = [];

  String get getLanOne => languageOne;
  String get getLanTwo => languageTwo;

  String get getLanParOne => languageParOne;
  String get getLanParTwo => languageParTwo;

  String get getVoiceCodeOne => voiceCodeOne;
  String get getVoiceCodeTwo => voiceCodeTwo;

  bool get getSearch => search;

  List<Map<String, String>> get getResults => results;

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

  void setSearch() {
    if (search == false) {
      search = true;
    } else {
      search = false;
      setResults(languages);
    }

    notifyListeners();
  }

  void setSearchOff() {
    search = false;
    setResults(languages);
    notifyListeners();
  }

  void setResults(string) {
    results = string;
    notifyListeners();
  }
}
