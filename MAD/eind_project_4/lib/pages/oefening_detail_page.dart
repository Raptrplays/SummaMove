import 'package:flutter/material.dart';
import 'oefeningen_page.dart';

class OefeningDetailPage extends StatelessWidget {
  final Oefening oefening;

  OefeningDetailPage({required this.oefening});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(oefening.naam),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Beschrijving NL:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(oefening.beschrijvingNL),
            SizedBox(height: 16),
            Text(
              'Beschrijving EN:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(oefening.beschrijvingEN),
          ],
        ),
      ),
    );
  }
}
