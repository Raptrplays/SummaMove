import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'pages/home_page.dart';
import 'pages/login_screen.dart'; // Make sure to import LoginScreen
import 'pages/register_screen.dart';
import 'pages/oefeningen_page.dart';
import 'pages/prestatiespage.dart';
import 'pages/aboutmepage.dart';
import 'pages/help_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summa Move',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
          future: _authService.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == true) {
              return HomePage();
            } else {
              return LoginScreen(); // Ensure LoginScreen route is defined
            }
          },
        ),
        '/login': (context) => LoginScreen(), // Define the LoginScreen route here
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/oefeningen': (context) => OefeningenPage(),
        '/prestaties': (context) => PrestatiesPage(),
        '/about': (context) => AboutMePage(),
        '/help': (context) => HelpPage(),
      },
    );

  }
}
