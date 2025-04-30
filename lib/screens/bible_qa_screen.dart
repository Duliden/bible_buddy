import 'package:flutter/material.dart';

class BibleQAScreen extends StatelessWidget {
  const BibleQAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bible Q&A')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Bible Q&A coming soon!',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
