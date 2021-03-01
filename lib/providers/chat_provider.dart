import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/models/Message.dart';
import 'package:chat_app/models/MessageResponse.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  User userTarget;

  Future<List<Message>> getMessages(String userId) async {
    final response = await http.get('${Enviroment.apiUrl}/messages/${userId}',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthProvider.getToken()
        });

    final messageResponse = messageResponseFromJson(response.body);
    return messageResponse.messages;
  }
}
