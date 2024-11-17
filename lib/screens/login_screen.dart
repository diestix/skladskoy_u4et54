import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/auth_service.dart';
import '../widgets/bottom_navigation_wrapper.dart';
import '../screens/admin_screen.dart';
import '../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  String _greeting = "Загрузка приветствия...";

  @override
  void initState() {
    super.initState();
    _fetchGreeting();
  }

  Future<void> _fetchGreeting() async {
    try {
      final response = await http.get(
        Uri.parse('https://hellosalut.stefanbohacek.dev/?mode=auto'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _greeting = data['hello'] != "Hello" && data['hello'] != null
              ? data['hello']
              : 'Добро пожаловать!'; // Текст по умолчанию
        });
      } else {
        setState(() {
          _greeting = 'Не удалось загрузить приветствие.';
        });
      }
    } catch (e) {
      setState(() {
        _greeting = 'Ошибка при загрузке приветствия.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _greeting,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kDefaultPadding * 2),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Логин',
                    labelStyle: TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: TextStyle(color: kSecondaryColor),
                ),
                SizedBox(height: kDefaultPadding),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    labelStyle: TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  style: TextStyle(color: kSecondaryColor),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: kErrorColor),
                    ),
                  ),
                SizedBox(height: kDefaultPadding),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text.trim();
                    final password = _passwordController.text.trim();

                    if (authService.login(username, password)) {
                      if (authService.role == 'user') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigationWrapper()),
                        );
                      } else if (authService.role == 'admin') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()),
                        );
                      }
                    } else {
                      setState(() {
                        _errorMessage = 'Данные были введены неверно';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2, vertical: kDefaultPadding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 16, color: kButtonTextColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
