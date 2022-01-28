import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> chats = [
    {
      "name": "Jano Slovak",
      "nativeLanguage": "SK",
      "lastChat": "co porabas?",
    },
    {
      "name": "Fero Mrkva",
      "nativeLanguage": "ENG",
      "lastChat": "co robis?",
    },
    {
      "name": "Martin Dekany",
      "nativeLanguage": "SK",
      "lastChat": "pod bench!!",
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          width: _size.width * 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: _size.width * 0.1),
                              trailing: Text(chats[index]["nativeLanguage"]),
                              title: Text(chats[index]["name"]),
                              subtitle: Text(chats[index]["lastChat"]),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).backgroundColor),
                          ),
                        ),
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Theme.of(context).backgroundColor),
                        // ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}


/*Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: _size.height * .06,
                          width: _size.width * 0.3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32)),
                          width: _size.width * .6,
                          height: _size.height * .12,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              child: Icon(Icons.settings),
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(CircleBorder()),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.purple[100]),
                              ),
                              onPressed: () {
                                // Navigator.of(context).pushNamed('/profile/edit-profile');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // Container(
                        //             width: 100,
                        //             height: 100,
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               image: DecorationImage(
                        //                   fit: BoxFit.cover,
                        //                   image: Image.file(file).image),
                        //             ),
                        //           )
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).backgroundColor),
                        ),

                        Container(
                          width: _size.width * .8,
                          child: Container(
                            child: Text(
                              chats[index]["name"],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );*/