import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: Colors.transparent,
              height: _size.height * .06,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(32)),
              width: _size.width * .6,
              height: _size.height * .12,
              child: Container(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Icon(Icons.settings),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    overlayColor: MaterialStateProperty.all(Colors.purple[100]),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/profile/edit-profile');
                  },
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Column(
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
                    "Tomáš Gardlík",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
