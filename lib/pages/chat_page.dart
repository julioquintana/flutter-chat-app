import 'dart:io';

import 'package:chat_app/models/Message.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/socket_provider.dart';
import 'package:chat_app/widget/message_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static const String ROUTE = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _textFocus = FocusNode();
  bool isEditingText = false;
  List<MessageChat> messages = [];
  ChatProvider chatProvider;
  SocketProvider socketProvider;
  AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    socketProvider = Provider.of<SocketProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    this.socketProvider.socket.on('message-personal', _getMessages);
    _loadLastMessages(this.chatProvider.userTarget.uid);
  }

  Future<void> _loadLastMessages(String uid) async {
    List<Message> chatHistory = await this.chatProvider.getMessages(uid);

    final messagesHistory = chatHistory.map((message) => MessageChat(
        text: message.message,
        uid: message.from,
        animationContainer: AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      messages.insertAll(0, messagesHistory);
    });
  }

  void _getMessages(dynamic data) {
    if (data['from'] == chatProvider.userTarget.uid) {
      MessageChat messageChat = MessageChat(
        text: data['message'],
        uid: data['from'],
        animationContainer: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)),
      );
      setState(() {
        messages.insert(0, messageChat);
      });
      messageChat.animationContainer.forward();
    }
  }

  @override
  void dispose() {
    for (MessageChat messageChat in messages) {
      messageChat.animationContainer.dispose();
    }
    this.socketProvider.socket.off('message-personal');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final userTarget = chatProvider.userTarget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                userTarget?.name.substring(0, 2),
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 15,
            ),
            SizedBox(height: 3),
            Text(
              userTarget?.name,
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (_, i) => messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: _disableButton,
                focusNode: _textFocus,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: () => _handleSubmit(_textController.text))
                  : Container(
                      child: Visibility(
                        visible: isEditingText,
                        replacement: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.attach_file_outlined,
                              color: Colors.blue[400],
                            ),
                            onPressed: () {}),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue[400],
                            ),
                            onPressed: () =>
                                _handleSubmit(_textController.text)),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.trim().isNotEmpty) {
      final newMessage = MessageChat(
        uid: authProvider.user.uid,
        text: text,
        animationContainer: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)),
      );
      messages.insert(0, newMessage);
      newMessage.animationContainer.forward();

      this.socketProvider.emit('message-personal', {
        'to': this.chatProvider.userTarget.uid,
        'from': this.authProvider.user.uid,
        'message': text
      });

      _textController.clear();
      _disableButton('');
      _textFocus.requestFocus();
    }
  }

  _disableButton(String text) {
    setState(() {
      isEditingText = text.trim().length > 0;
    });
  }
}
