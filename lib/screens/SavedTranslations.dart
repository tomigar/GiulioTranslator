import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../TranslationsModel.dart';

class SavedTranslations extends StatelessWidget {
  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String trans = prefs.getString('items');
    List<Translations> ls = Translations.decode(trans);
    return ls;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder(
          future: loadData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                "No saved translations",
                style: Theme.of(context).textTheme.headline4,
              ));
            } else {
              print("reloaduje");
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            color: Colors.deepPurple[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(
                                      flex: 3,
                                    ),
                                    Card(
                                        color:
                                            Color.fromRGBO(200, 200, 200, .5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              '${snapshot.data[index].from}'),
                                        )),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color:
                                            Color.fromRGBO(255, 255, 255, .6),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    '${snapshot.data[index].toTranslate}',
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Divider(),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Icon(Icons.arrow_downward),
                                // ),
                                Card(
                                    color: Color.fromRGBO(200, 200, 200, .5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text('${snapshot.data[index].to}'),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data[index].translated}',
                                            softWrap: true,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }));
            }
          }),
      // Align(
      //     alignment: Alignment.bottomCenter,
      //     child: IconButton(
      //         onPressed: () async {
      //           final prefs = await SharedPreferences.getInstance();

      //           prefs.remove("items");
      //         },
      //         icon: Icon(Icons.stop)))
    ]);
  }
}
