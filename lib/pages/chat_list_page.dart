import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/widget/list_title_item_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatListPage extends StatefulWidget {
  static const String ROUTE = 'user';

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    User(
        name: 'Julio Quintana',
        email: 'julio@julio.com',
        online: true,
        uid: '11'),
    User(name: 'Jose Noguera', email: 'jose@jose.com', online: true, uid: '11'),
    User(
        name: 'Mary Quintana', email: 'mary@mary.com', online: true, uid: '11'),
    User(
        name: 'Mayruma Crespo', email: 'may@may.com', online: false, uid: '11'),
    User(name: 'Carlos', email: 'carlos@carlos.com', online: true, uid: '11'),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            provider.user.name,
            style: TextStyle(color: Colors.black54),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.indigoAccent,
            ),
            onPressed: () {
              AuthProvider.deleteToken();
              Navigator.pushReplacementNamed(context, LoginPage.ROUTE);
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
        body: SmartRefresher(
          onRefresh: _loadUser,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          enablePullDown: true,
          controller: _refreshController,
          child: _buildListViewUser(),
        ));
  }

  _loadUser() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  ListView _buildListViewUser() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, index) => Divider(),
      itemCount: users.length,
      itemBuilder: (_, index) => ListTitleItemChat(users[index]),
    );
  }
}
