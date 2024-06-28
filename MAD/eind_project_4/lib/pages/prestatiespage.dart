import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth_service.dart';

class PrestatiesPage extends StatefulWidget {
  @override
  _PrestatiesPageState createState() => _PrestatiesPageState();
}

class _PrestatiesPageState extends State<PrestatiesPage> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _gebruikerIdController = TextEditingController();
  final TextEditingController _aantalController = TextEditingController();
  final TextEditingController _datumController = TextEditingController();

  List<Oefening> _oefeningen = [];
  List<Prestatie> _prestaties = [];
  String? _errorMessage;
  bool _isLoading = false;
  Oefening? _selectedOefening;
  bool _isEditing = false;
  Prestatie? _currentPrestatie;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await _authService.getToken();
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      await _fetchOefeningen();
      await _fetchPrestaties();
    }
  }

  Future<void> _fetchOefeningen() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/oefeningen'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      setState(() {
        _oefeningen = jsonData.map((oefeningJson) => Oefening.fromJson(oefeningJson)).toList();
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load oefeningen: ${response.statusCode}';
      });
    }
  }

  Future<void> _fetchPrestaties() async {
    final token = await _authService.getToken();
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/prestaties'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        print('Fetched Prestaties: $jsonData');
        setState(() {
          _prestaties = jsonData.map((prestatieJson) => Prestatie.fromJson(prestatieJson)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load prestaties: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load prestaties: $e';
        _isLoading = false;
      });
    }
  }

  Widget _buildPrestatieItem(Prestatie prestatie) {
    return ListTile(
      title: Text(
        'Oefening: ${prestatie.oefeningNaam} - Gebruiker ID: ${prestatie.gebruikerId}',
      ),
      subtitle: Text('Aantal: ${prestatie.aantal} - Datum: ${prestatie.datum}'),
      trailing: Wrap(
        spacing: 12,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editPrestatie(prestatie);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deletePrestatie(prestatie.id);
            },
          ),
        ],
      ),
    );
  }

  void _editPrestatie(Prestatie prestatie) {
    _gebruikerIdController.text = prestatie.gebruikerId.toString();
    _aantalController.text = prestatie.aantal.toString();
    _datumController.text = prestatie.datum;
    _selectedOefening = _oefeningen.firstWhere((oef) => oef.id == prestatie.oefeningId);
    _currentPrestatie = prestatie;
    setState(() {
      _isEditing = true;
    });
    _showForm();
  }


  Future<void> _deletePrestatie(int id) async {
    final token = await _authService.getToken();
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/api/prestaties/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await _fetchPrestaties();
      } else {
        setState(() {
          _errorMessage = 'Failed to delete prestatie: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _createPrestatie() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final token = await _authService.getToken();
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/prestaties'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, dynamic>{
            'oefeningId': _selectedOefening?.id ?? '',
            'gebruikerId': int.parse(_gebruikerIdController.text),
            'aantal': int.parse(_aantalController.text),
            'datum': _datumController.text, // Assuming _datumController.text is in ISO format
          }),
        );

        if (response.statusCode == 201) {
          await _fetchPrestaties();  // Fetch the prestaties again to update the list
          Navigator.pop(context);
        } else {
          setState(() {
            _errorMessage = 'Failed to create prestatie: ${response.statusCode} ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updatePrestatie(Prestatie prestatie) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final token = await _authService.getToken();
      try {
        final response = await http.put(
          Uri.parse('http://127.0.0.1:8000/api/prestaties/${prestatie.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, dynamic>{
            'oefeningId': _selectedOefening?.id ?? '',
            'gebruikerId': int.parse(_gebruikerIdController.text),
            'aantal': int.parse(_aantalController.text),
            'datum': _datumController.text, // Assuming _datumController.text is in ISO format
          }),
        );

        if (response.statusCode == 200) {
          await _fetchPrestaties();  // Fetch the prestaties again to update the list
          Navigator.pop(context);
        } else {
          setState(() {
            _errorMessage = 'Failed to update prestatie: ${response.statusCode} ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isEditing ? 'Update Prestatie' : 'Create Prestatie'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<Oefening>(
                    value: _selectedOefening,
                    onChanged: (Oefening? newValue) {
                      setState(() {
                        _selectedOefening = newValue;
                      });
                    },
                    items: _oefeningen.map((Oefening oefening) {
                      return DropdownMenuItem<Oefening>(
                        value: oefening,
                        child: Text(oefening.naam),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Oefening'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an oefening';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _gebruikerIdController,
                    decoration: InputDecoration(labelText: 'Gebruiker ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gebruiker ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _aantalController,
                    decoration: InputDecoration(labelText: 'Aantal'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter aantal';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _datumController,
                    decoration: InputDecoration(labelText: 'Datum'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter datum';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_isEditing) {
                  _updatePrestatie(_currentPrestatie!);
                } else {
                  _createPrestatie();
                }
              },
              child: Text(_isEditing ? 'Update' : 'Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestaties'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : ListView.builder(
        itemCount: _prestaties.length,
        itemBuilder: (context, index) {
          final prestatie = _prestaties[index];
          return _buildPrestatieItem(prestatie);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditing = false;
            _currentPrestatie = null;
            _gebruikerIdController.clear();
            _aantalController.clear();
            _datumController.clear();
            _selectedOefening = null;
          });
          _showForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Oefening {
  final int id;
  final String naam;

  Oefening({required this.id, required this.naam});

  factory Oefening.fromJson(Map<String, dynamic> json) {
    return Oefening(
      id: json['id'],
      naam: json['naam'],
    );
  }
}

class Prestatie {
  final int id;
  final int gebruikerId;
  final int oefeningId;
  final String oefeningNaam;  // Added to store oefening name
  final String datum;
  final int aantal;

  Prestatie({
    required this.id,
    required this.gebruikerId,
    required this.oefeningId,
    required this.oefeningNaam,  // Initialize with oefening name
    required this.datum,
    required this.aantal,
  });

  factory Prestatie.fromJson(Map<String, dynamic> json) {
    return Prestatie(
      id: json['id'],
      gebruikerId: json['gebruikerId'],
      oefeningId: json['oefeningId'],
      oefeningNaam: json['oefeningNaam'],  // Parse oefening name from JSON
      datum: json['datum'],
      aantal: json['aantal'],
    );
  }
}
