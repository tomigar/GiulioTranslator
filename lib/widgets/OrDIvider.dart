import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String label;
  final double height;

  OrDivider({
    this.label,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              thickness: .6,
              color: Colors.grey,
              height: height,
            ),
          ),
        ),
        Text(
          "or",
          style: TextStyle(color: Colors.grey),
        ),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                thickness: .6,
                color: Colors.grey,
                height: height,
              )),
        ),
      ],
    );
  }
}
