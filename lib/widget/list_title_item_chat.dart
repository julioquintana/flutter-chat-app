import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTitleItemChat extends StatelessWidget {
  const ListTitleItemChat(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(user.uid),
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.userTarget = user;
        Navigator.pushNamed(context, ChatPage.ROUTE);
      },
    );
  }
}
