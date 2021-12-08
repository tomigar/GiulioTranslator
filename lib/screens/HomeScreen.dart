import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:translator_app/main.dart';
import 'package:translator_app/screens/ScannerScreen.dart';

import 'package:translator_app/widgets/Languages/LaguageSelector.dart';
import 'package:translator_app/widgets/Translator.dart';

import '../authentication_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentindex = 1;
  void setIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Giulio',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          elevation: 20,
          child: ElevatedButton(
            onPressed: () {
              Provider.of<AuthenticationService>(context, listen: false)
                  .signOut();
              Navigator.pop(context);
            },
            child: Text("signout"),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex:
                _currentindex, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.chat),
                label: 'Chat',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.translate),
                label: 'Text',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.camera_rounded),
                label: 'Scanner',
                backgroundColor: Colors.green,
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  setIndex(index);
                  break;
                case 1:
                  setIndex(index);
                  break;
                case 2:
                  setIndex(index);
                  break;
              }
            }),
        body: SingleChildScrollView(
          child: getWidget(_currentindex),
        ),
      ),
    );
  }
}

Widget getWidget(index) {
  if (index == 0) return AuthenticationWrapper();
  if (index == 1)
    return Column(
      children: [LanguageSelector(), Translator()],
    );
  if (index == 2) return ScannerScreen();
  return SizedBox();
}
