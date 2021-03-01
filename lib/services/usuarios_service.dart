import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get('${Enviroment.apiUrl}/users', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthProvider.getToken()
      });
      return userResponseFromJson(resp.body).users;
    } catch (e) {
      return [];
    }
  }
}
