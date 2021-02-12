import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/user_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  UserPage.ROUTE: (_) => UserPage(),
  ChatPage.ROUTE: (_) => ChatPage(),
  LoginPage.ROUTE: (_) => LoginPage(),
  RegisterPage.ROUTE: (_) => RegisterPage(),
  LoadingPage.ROUTE: (_) => LoadingPage(),
};
