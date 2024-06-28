import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  void _showVersionNumber(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Versie'),
          content: Text('Summa Move Versie 1.0.0'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleAccountButtonPress(BuildContext context) async {
    try {
      bool isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        await _authService.logout();
      }
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error handling account button press: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Er is een fout opgetreden. Probeer het opnieuw.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<bool>(
          future: _authService.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.data!) {
              return _buildDrawerLoggedIn(false, context);
            } else {
              return _buildDrawerLoggedIn(true, context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welkom bij Summa Move!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Summa Move is een app die je helpt bij het bijhouden van je oefeningen en prestaties.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Functies:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Oefeningen: Bekijk een lijst van beschikbare oefeningen.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Prestaties: Registreer en verwijder je prestaties om je voortgang bij te houden.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Onze missie is om jou te helpen je fitnessdoelen te bereiken door een gebruiksvriendelijke en effectieve manier te bieden om je oefeningen en prestaties bij te houden.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Veel succes en blijf bewegen!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showVersionNumber(context),
              child: Text('Versienummer weergeven'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/help');
              },
              child: Text('Hulp nodig?'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/oefeningen');
              },
              child: Text('View Oefeningen'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerLoggedIn(bool isLoggedIn, BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Navigation'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        ListTile(
          title: Text('Oefeningen'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/oefeningen');
          },
        ),
        ListTile(
          title: Text(isLoggedIn ? 'Prestaties' : 'Prestaties (Login Required)'),
          onTap: () {
            if (!isLoggedIn) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Je moet ingelogd zijn om toegang te krijgen tot Prestaties'),
                ),
              );
            } else {
              Navigator.pushReplacementNamed(context, '/prestaties');
            }
          },
        ),
        if (!isLoggedIn)
          ListTile(
            title: Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        if (isLoggedIn)
          ListTile(
            title: Text('Logout'),
            onTap: () {
              _handleAccountButtonPress(context);
            },
          ),
      ],
    );
  }
}
