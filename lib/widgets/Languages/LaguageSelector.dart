import 'package:flutter/material.dart';
import 'package:translator_app/providers/translate_text_provider.dart';
import 'LanguagesList.dart';
import 'package:provider/provider.dart';
import '../../providers/language_selector_provider.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.42,
          child: TextButton(
            child: Text(context.watch<LanguageSelectProvider>().languageOne),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Set your language'),
                    ),
                    body: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: languages.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(languages[index]["name"]),
                              trailing: (context
                                          .watch<LanguageSelectProvider>()
                                          .languageOne ==
                                      languages[index]["name"])
                                  ? Icon(Icons.done)
                                  : Text(''),
                              onTap: () {
                                context
                                    .read<LanguageSelectProvider>()
                                    .setLanOne(languages[index]["name"]);
                                context
                                    .read<LanguageSelectProvider>()
                                    .setLanParOne(languages[index]["par"]);
                                context
                                    .read<LanguageSelectProvider>()
                                    .setVoiceCodeOne(
                                        languages[index]["speechCodeMale"]);

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: IconButton(
              icon: Icon(Icons.swap_horiz_sharp),
              onPressed: () {
                context.read<LanguageSelectProvider>().languageswap();
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.42,
          child: TextButton(
            child: Text(context.watch<LanguageSelectProvider>().languageTwo),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Set your language'),
                    ),
                    body: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: languages.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(languages[index]["name"]),
                          trailing: (context
                                      .watch<LanguageSelectProvider>()
                                      .languageTwo ==
                                  languages[index]["name"])
                              ? Icon(Icons.done)
                              : Text(''),
                          onTap: () {
                            context
                                .read<LanguageSelectProvider>()
                                .setLanTwo(languages[index]["name"]);
                            context
                                .read<LanguageSelectProvider>()
                                .setLanParTwo(languages[index]["par"]);
                            context
                                .read<LanguageSelectProvider>()
                                .setVoiceCodeTwo(
                                    languages[index]["speechCodeMale"]);
                            Provider.of<TranslateTextProvider>(context,
                                    listen: false)
                                .start(Provider.of<LanguageSelectProvider>(
                                        context,
                                        listen: false)
                                    .languageParTwo);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
