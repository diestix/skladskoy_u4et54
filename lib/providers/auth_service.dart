import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  // Список пользователей и их роли
  final Map<String, Map<String, String>> _users = {
    '1231': {'password': '123', 'role': 'user'},
    '123': {'password': '123', 'role': 'admin'},
  };

  String? _role;

  String? get role => _role; // Роль текущего пользователя

  // Метод для входа
  bool login(String username, String password) {
    if (_users.containsKey(username) &&
        _users[username]!['password'] == password) {
      _role = _users[username]!['role'];
      notifyListeners();
      return true;
    }
    return false;
  }

  // Метод для выхода
  void logout() {
    _role = null;
    notifyListeners();
  }
}
