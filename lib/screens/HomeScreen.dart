import 'dart:html';

import 'package:flutter/material.dart';
import 'package:translator_app/screens/ChatScreen.dart';
import 'package:translator_app/screens/ScannerScreen.dart';

import 'package:translator_app/widgets/Languages/LaguageSelector.dart';
import 'package:translator_app/widgets/Translator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Giulio'),
          ),
          drawer: Drawer(),
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
                    setState(() {
                      _currentindex = index;
                    });
                    break;
                  case 1:
                    setState(() {
                      _currentindex = index;
                    });
                    break;
                  case 2:
                    setState(() {
                      _currentindex = index;
                    });
                    break;
                }
              }),
          body: SingleChildScrollView(
              child:
              (){switch (_currentindex) {
                case 0:
                  
                  break;
                default:
              }}()
              
              
                

          )

                    )
                   
    );
  }
}

// Widget getWidget(index){
//   if (index == 0) return ChatScreen();
//   if (index == 1) return Column()
// }