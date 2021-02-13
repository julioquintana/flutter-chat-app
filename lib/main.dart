import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: ChatPage.ROUTE,
      routes: appRoutes,
    );
  }
}
