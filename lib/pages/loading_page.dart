import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const String ROUTE = 'loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}
