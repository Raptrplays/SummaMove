import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to user page
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              currentAccountPicture: CircleAvatar(
                child: Text('U'),
              ),
              accountEmail: null, // Remove email
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Language'),
              onTap: () {
                // Handle language selection
              },
            ),
            ListTile(
              title: Text('Oefeningen'),
              onTap: () {
                // Navigate to exercises page
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExercisesPage()));
              },
            ),
            ListTile(
              title: Text('Prestaties'),
              onTap: () {
                // Navigate to performances page
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PerformancesPage()));
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Show about version page
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to login page
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExercisesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oefeningen'),
      ),
      body: Center(
        child: Text('Exercises Page'),
      ),
    );
  }
}

class PerformancesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestaties'),
      ),
      body: Center(
        child: Text('Performances Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add prestaties
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Version'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About My App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Version: 1.0.0',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This app is designed to help users with...',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'For help, please contact support@example.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
