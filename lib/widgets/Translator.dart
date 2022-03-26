import 'package:flutter/services.dart';
import 'package:translator_app/TranslationsModel.dart';
import 'package:translator_app/providers/translate_text_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_app/widgets/Languages/LaguageSelector.dart';

import 'package:tts_azure/tts_azure.dart';
import 'package:provider/provider.dart';
import '../providers/language_selector_provider.dart';
import 'package:flutter/material.dart';

class Translator extends StatefulWidget {
  Translator({Key key}) : super(key: key);
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  final ttsazure = TTSAzure("b004778940754c529110b116892e81af", "northeurope");

  TextEditingController translatedController;
  TextEditingController toTranslateController;

  @override
  void initState() {
    super.initState();
    translatedController = TextEditingController();
    toTranslateController = TextEditingController();
    toTranslateController.text = Provider.of<TranslateTextProvider>(
      context,
      listen: false, // Be sure to listen
    ).toTranslate;
  }

  @override
  void didChangeDependencies() {
    translatedController.text = Provider.of<TranslateTextProvider>(
      context,
      listen: true, // Be sure to listen
    ).translated;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    translatedController.dispose();
    toTranslateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      ttsazure.speak(
          Provider.of<TranslateTextProvider>(context, listen: false)
              .toTranslate,
          "en-US",
          Provider.of<LanguageSelectProvider>(context, listen: false)
              .voiceCodeOne);
    }

    Future _speakTwo() async {
      ttsazure.speak(
          translatedController.text,
          "en-US",
          Provider.of<LanguageSelectProvider>(context, listen: false)
              .voiceCodeTwo);
    }

    saveTranslation() async {
      final prefs = await SharedPreferences.getInstance();
      final String trans = prefs.getString('items');
      List<Translations> ls = [];
      if (trans != null) {
        ls = Translations.decode(trans);
      }
      ls.add(Translations(
        toTranslate: Provider.of<TranslateTextProvider>(context, listen: false)
            .toTranslate,
        translated: Provider.of<TranslateTextProvider>(
          context,
          listen: false, // Be sure to listen
        ).translated,
        from: (Provider.of<LanguageSelectProvider>(context, listen: false)
                        .getLanOne ==
                    "Automatically" &&
                Provider.of<LanguageSelectProvider>(context, listen: false)
                        .getLanOne ==
                    "Choose your language")
            ? Provider.of<TranslateTextProvider>(context, listen: false)
                .detectedLan
            : Provider.of<LanguageSelectProvider>(context, listen: false)
                .getLanOne,
        to: Provider.of<LanguageSelectProvider>(context, listen: false)
            .getLanTwo,
      ));
      final String encodedData = Translations.encode(ls);

      await prefs.setString('items', encodedData);
      print(encodedData);
    }

    return Column(
      children: [
        LanguageSelector(
          toTranslate: toTranslateController,
        ),
        // input TextField
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  (Provider.of<LanguageSelectProvider>(context, listen: true)
                              .voiceCodeOne ==
                          "")
                      ? IconBtn(
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                content: const Text(
                                    'This language does not support Text-to-Speech'),
                              ),
                            );
                            FocusScope.of(context).unfocus();
                          })
                      : IconBtn(
                          icon: Icon(Icons.volume_up),
                          onTap: () {
                            _speak();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                  Text(
                    context.watch<LanguageSelectProvider>().languageOne,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconBtn(
                    icon: Icon(Icons.close),
                    onTap: () {
                      toTranslateController.clear();
                      translatedController.clear();
                      Provider.of<TranslateTextProvider>(context, listen: false)
                          .setToTranslate("");
                      Provider.of<TranslateTextProvider>(context, listen: false)
                          .setTranslated("");
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: toTranslateController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (val) {
                    Provider.of<TranslateTextProvider>(context, listen: false)
                        .setToTranslate(val);
                    Provider.of<TranslateTextProvider>(context, listen: false)
                        .start(
                            Provider.of<LanguageSelectProvider>(context,
                                    listen: false)
                                .languageParOne,
                            Provider.of<LanguageSelectProvider>(context,
                                    listen: false)
                                .languageParTwo);
                  },
                  decoration: InputDecoration(
                      hintText: "Type your text here",
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
        // output TextField
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.deepPurple[400],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  (Provider.of<LanguageSelectProvider>(context, listen: false)
                              .voiceCodeTwo ==
                          "")
                      ? IconBtn(
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                content: const Text(
                                    'This language does not support Text-to-Speech'),
                              ),
                            );
                            FocusScope.of(context).unfocus();
                          })
                      : IconBtn(
                          icon: Icon(Icons.volume_up),
                          onTap: () {
                            _speakTwo();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                  Text(
                    context.watch<LanguageSelectProvider>().languageTwo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconBtn(
                    icon: Icon(Icons.copy),
                    onTap: () {
                      if (toTranslateController.text.isNotEmpty &&
                          translatedController.text.isNotEmpty) {
                        Clipboard.setData(
                            ClipboardData(text: translatedController.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            content: const Text('Text Copied'),
                          ),
                        );
                      }
                    },
                  ),
                  (toTranslateController.text.isNotEmpty &&
                          translatedController.text.isNotEmpty)
                      ? IconBtn(
                          icon: Icon(Icons.star_border),
                          onTap: () {
                            saveTranslation();
                          },
                        )
                      : IconBtn(
                          icon: Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                          onTap: () {},
                        )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Translated text'),
                  controller: translatedController,
                  readOnly: true,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconBtn extends StatelessWidget {
  const IconBtn({
    @required this.icon,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: ClipOval(
        child: Material(
          color: Colors.transparent, // button color
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                child: icon),
          ),
        ),
      ),
    );
  }
}
