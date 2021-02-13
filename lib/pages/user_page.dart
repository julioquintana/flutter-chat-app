import 'package:chat_app/models/user.dart';
import 'package:chat_app/widget/list_title_item_chat.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  static const String ROUTE = 'user';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Mi Nombre',
            style: TextStyle(color: Colors.black54),
          ),
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
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
