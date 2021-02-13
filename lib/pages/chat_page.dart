import 'dart:io';

import 'package:chat_app/widget/message_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    for (MessageChat messageChat in messages) {
      messageChat.animationContainer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Ma',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 15,
            ),
            SizedBox(height: 3),
            Text(
              'Mayruma Crespo',
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
      print(text);
      final newMessage = MessageChat(
        uuid: '123',
        text: text,
        animationContainer: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)),
      );
      messages.insert(0, newMessage);
      newMessage.animationContainer.forward();

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
