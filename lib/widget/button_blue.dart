import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final Function onTabFunction;
  final String texto;

  const ButtonBlue(
      {Key key, @required this.onTabFunction, @required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(
            this.texto,
            style: TextStyle(color: Colors.white, fontSize: 17),
          )),
        ),
        onPressed: onTabFunction);
  }
}
