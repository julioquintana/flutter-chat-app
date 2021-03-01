import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/providers/socket_provider.dart';
import 'package:chat_app/services/usuarios_service.dart';
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
  final usersService = UsersService();
  List<User> users = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _loadUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
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
              provider.authenticating = false;
              socketProvider.disconnect();
              Navigator.pushReplacementNamed(context, LoginPage.ROUTE);
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Visibility(
                visible: socketProvider.serverStatus == ServerStatus.Online,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue[400],
                ),
                replacement: Icon(
                  Icons.offline_bolt,
                  color: Colors.red,
                ),
              ),
            ),
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
    users = await usersService.getUsers();

    setState(() {});
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
