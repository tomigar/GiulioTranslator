import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/main.dart';
import 'package:translator_app/screens/SavedTranslations.dart';

import 'package:translator_app/widgets/Translator.dart';
import 'package:translator_app/widgets/CustomDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Giulio',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          height: 60,
          index: currentIndex,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(Icons.chat, size: 30, color: Colors.white),
            Icon(Icons.translate, size: 30, color: Colors.white),
            Icon(Icons.star, size: 30, color: Colors.white),
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
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     selectedItemColor: Colors.white,
        //     currentIndex:
        //         currentIndex, // this will be set when a new tab is tapped
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: new Icon(Icons.chat),
        //         label: 'Chat',
        //         backgroundColor: Theme.of(context).primaryColor,
        //       ),
        //       BottomNavigationBarItem(
        //         icon: new Icon(Icons.translate),
        //         label: 'Text',
        //         backgroundColor: Theme.of(context).primaryColor,
        //       ),
        //       BottomNavigationBarItem(
        //         icon: new Icon(Icons.camera_rounded),
        //         label: 'Scanner',
        //         backgroundColor: Colors.green,
        //       ),
        //     ],
        //     onTap: (index) {
        //       switch (index) {
        //         case 0:
        //           setIndex(index);
        //           break;
        //         case 1:
        //           setIndex(index);
        //           break;
        //         case 2:
        //           setIndex(index);
        //           break;
        //       }
        //     }),
        body: getWidget(currentIndex),
      ),
    );
  }
}

Widget getWidget(index) {
  if (index == 0) return AuthenticationWrapper();
  if (index == 1)
    return Column(
      children: [Translator()],
    );
  if (index == 2) return SavedTranslations();
  return SizedBox();
}
