import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth_service.dart';
import 'oefening_detail_page.dart';
import 'home_page.dart'; // Import your home page here
import 'prestatiespage.dart'; // Import your prestaties page here

class OefeningenPage extends StatefulWidget {
  @override
  _OefeningenPageState createState() => _OefeningenPageState();
}

class _OefeningenPageState extends State<OefeningenPage> {
  late Future<List<Oefening>> _oefeningen;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _oefeningen = fetchOefeningen();
  }

  Future<List<Oefening>> fetchOefeningen() async {
    final token = await _authService.storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/oefeningen'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((oefeningJson) => Oefening.fromJson(oefeningJson)).toList();
    } else {
      throw Exception('Failed to load oefeningen: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oefeningen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
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
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Prestaties'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/prestaties');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Oefening>>(
        future: _oefeningen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No oefeningen found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final oefening = snapshot.data![index];
                return ListTile(
                  title: Text(oefening.naam),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OefeningDetailPage(oefening: oefening),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Oefening {
  final int id;
  final String naam;
  final String beschrijvingNL;
  final String beschrijvingEN;

  Oefening({
    required this.id,
    required this.naam,
    required this.beschrijvingNL,
    required this.beschrijvingEN,
  });

  factory Oefening.fromJson(Map<String, dynamic> json) {
    return Oefening(
      id: json['id'],
      naam: json['naam'],
      beschrijvingNL: json['beschrijvingNL'],
      beschrijvingEN: json['beschrijvingEN'],
    );
  }
}
