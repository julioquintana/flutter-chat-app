import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/socket_provider.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: LoadingPage.ROUTE,
        routes: appRoutes,
      ),
    );
  }
}
