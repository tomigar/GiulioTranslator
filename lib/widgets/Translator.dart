import 'package:flutter/services.dart';
import 'package:translator_app/providers/translate_text_provider.dart';

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

  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    textController.text = Provider.of<TranslateTextProvider>(
      context,
      listen: true, // Be sure to listen
    ).translated;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final fieldText = TextEditingController();

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
          textController.text,
          "en-US",
          Provider.of<LanguageSelectProvider>(context, listen: false)
              .voiceCodeTwo);
    }

    return Column(
      children: [
        // input TextField
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  (Provider.of<LanguageSelectProvider>(context, listen: false)
                              .voiceCodeOne ==
                          "")
                      ? IconBtn(
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.grey,
                          ),
                          onTap: () {})
                      : IconBtn(
                          icon: Icon(Icons.volume_up),
                          onTap: () {
                            _speak();
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
                      fieldText.clear();
                      textController.clear();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  //keyboardType: TextInputType.multiline,
                  //maxLines: 5,
                  controller: fieldText,
                  onChanged: (val) {
                    Provider.of<TranslateTextProvider>(context, listen: false)
                        .toTranslate = val;
                    Provider.of<TranslateTextProvider>(context, listen: false)
                        .start(Provider.of<LanguageSelectProvider>(context,
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
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(58, 88, 244, 1)),
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
                          })
                      : IconBtn(
                          icon: Icon(Icons.volume_up),
                          onTap: () {
                            _speakTwo();
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
                      if (textController.text != "") {
                        Clipboard.setData(
                            ClipboardData(text: textController.text));
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
                  IconBtn(
                    icon: Icon(Icons.star_border),
                    onTap: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Translated text'),
                  controller: textController,
                  readOnly: true,
                  style: TextStyle(color: Colors.white),
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
