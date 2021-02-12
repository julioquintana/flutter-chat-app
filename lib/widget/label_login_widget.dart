import 'package:flutter/material.dart';

class LabelLoginWidget extends StatelessWidget {
  final String route;
  final String question;
  final String textAction;

  const LabelLoginWidget({
    Key key,
    @required this.route,
    @required this.question,
    @required this.textAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            question,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },
            child: Text(
              textAction,
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
