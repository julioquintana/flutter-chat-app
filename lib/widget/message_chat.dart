import 'package:chat_app/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageChat extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationContainer;

  const MessageChat(
      {Key key,
      @required this.text,
      @required this.uid,
      @required this.animationContainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return FadeTransition(
      opacity: animationContainer,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationContainer, curve: Curves.easeInBack),
        child: Container(
          child: this.uid.trim() == authService.user.uid
              ? _myMessage()
              : _otherMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, left: 60, right: 8),
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 60),
        child: Text(
          this.text,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
