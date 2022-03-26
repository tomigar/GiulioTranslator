import 'dart:convert';

class Translations {
  String toTranslate;
  String translated;
  String from;
  String to;

  Translations({
    this.toTranslate,
    this.translated,
    this.from,
    this.to,
  });

  factory Translations.fromJson(Map<String, dynamic> json) {
    return Translations(
      toTranslate: json['toTranslate'],
      translated: json['translated'],
      from: json['from'],
      to: json['to'],
    );
  }

  static Map<String, dynamic> toMap(Translations translation) => {
        'toTranslate': translation.toTranslate,
        'translated': translation.translated,
        'from': translation.from,
        'to': translation.to,
      };

  static String encode(List<Translations> trans) => json.encode(
        trans
            .map<Map<String, dynamic>>(
                (tranlation) => Translations.toMap(tranlation))
            .toList(),
      );

  static List<Translations> decode(String trans) =>
      (json.decode(trans) as List<dynamic>)
          .map<Translations>((item) => Translations.fromJson(item))
          .toList();
}
