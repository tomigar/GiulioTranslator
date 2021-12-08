import 'package:flutter/material.dart';
import 'package:translator_app/providers/translate_text_provider.dart';
import 'LanguagesList.dart';
import 'package:provider/provider.dart';
import '../../providers/language_selector_provider.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final _search = TextEditingController();

  void setSearch() {
    Provider.of<LanguageSelectProvider>(context, listen: false).setSearch();
  }

  void setSearchOff() {
    Provider.of<LanguageSelectProvider>(context, listen: false).setSearchOff();
  }

  void searchClear() {
    setState(() {
      _foundLanguages = languages;
    });
    _search.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  List<Map<String, dynamic>> _foundLanguages = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundLanguages = languages;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      Provider.of<LanguageSelectProvider>(context, listen: false)
          .setResults(languages);
      print('empty');
    } else {
      print('entered:' + enteredKeyword);
      Provider.of<LanguageSelectProvider>(context, listen: false).setResults(
          languages
              .where((user) => user["name"]
                  .toLowerCase()
                  .startsWith(enteredKeyword.toLowerCase()))
              .toList());
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI

    _foundLanguages =
        Provider.of<LanguageSelectProvider>(context, listen: false).results;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FittedBox(
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.45,
            child: TextButton(
              child: Text(context.watch<LanguageSelectProvider>().languageOne),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: (!Provider.of<LanguageSelectProvider>(context,
                                    listen: true)
                                .search)
                            ? Text('Set your language')
                            : TextField(
                                controller: _search,
                                onChanged: _runFilter,
                                decoration: InputDecoration(
                                  hintText: 'Search for your language ...',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        actions: [
                          (!Provider.of<LanguageSelectProvider>(context,
                                      listen: true)
                                  .search)
                              ? IconButton(
                                  onPressed: () {
                                    setSearch();
                                  },
                                  icon: Icon(Icons.search))
                              : IconButton(
                                  onPressed: () {
                                    searchClear();
                                    setSearch();
                                  },
                                  icon: Icon(Icons.close)),
                        ],
                      ),
                      body: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height,
                                child: (_foundLanguages.isNotEmpty)
                                    ? ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: _foundLanguages.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                                _foundLanguages[index]["name"]),
                                            trailing: (context
                                                        .watch<
                                                            LanguageSelectProvider>()
                                                        .languageOne ==
                                                    _foundLanguages[index]
                                                        ["name"])
                                                ? Icon(Icons.done)
                                                : Text(''),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setLanOne(
                                                      _foundLanguages[index]
                                                          ["name"]);
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setLanParOne(
                                                      _foundLanguages[index]
                                                          ["par"]);
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setVoiceCodeOne(
                                                      _foundLanguages[index]
                                                          ["speechCodeMale"]);

                                              searchClear();
                                              setSearchOff();
                                            },
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text("No results found"),
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Center(
          child: IconButton(
              icon: Icon(Icons.swap_horiz_sharp),
              onPressed: () {
                Provider.of<LanguageSelectProvider>(context, listen: false)
                    .languageswap();
                Provider.of<TranslateTextProvider>(context, listen: false)
                    .swapTranslation();
              }),
        ),
        FittedBox(
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.45,
            child: TextButton(
              child: Text(context.watch<LanguageSelectProvider>().languageTwo),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: (!Provider.of<LanguageSelectProvider>(context,
                                    listen: true)
                                .search)
                            ? Text('Set your language')
                            : TextField(
                                controller: _search,
                                onChanged: _runFilter,
                                decoration: InputDecoration(
                                  hintText: 'Search for your language ...',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        actions: [
                          (!Provider.of<LanguageSelectProvider>(context,
                                      listen: true)
                                  .search)
                              ? IconButton(
                                  onPressed: () {
                                    setSearch();
                                  },
                                  icon: Icon(Icons.search))
                              : IconButton(
                                  onPressed: () {
                                    searchClear();
                                    setSearch();
                                  },
                                  icon: Icon(Icons.close)),
                        ],
                      ),
                      body: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height,
                                child: (_foundLanguages.isNotEmpty)
                                    ? ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: _foundLanguages.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                                _foundLanguages[index]["name"]),
                                            trailing: (context
                                                        .watch<
                                                            LanguageSelectProvider>()
                                                        .languageOne ==
                                                    _foundLanguages[index]
                                                        ["name"])
                                                ? Icon(Icons.done)
                                                : Text(''),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setLanTwo(
                                                      _foundLanguages[index]
                                                          ["name"]);
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setLanParTwo(
                                                      _foundLanguages[index]
                                                          ["par"]);
                                              context
                                                  .read<
                                                      LanguageSelectProvider>()
                                                  .setVoiceCodeTwo(
                                                      _foundLanguages[index]
                                                          ["speechCodeMale"]);
                                              Provider.of<TranslateTextProvider>(
                                                      context,
                                                      listen: false)
                                                  .start(Provider.of<
                                                              LanguageSelectProvider>(
                                                          context,
                                                          listen: false)
                                                      .languageParTwo);
                                              searchClear();
                                              setSearchOff();
                                            },
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text("No results found"),
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
