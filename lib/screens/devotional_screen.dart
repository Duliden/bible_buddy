import 'package:flutter/material.dart';
import '../services/devotional_service.dart';

class DevotionalScreen extends StatefulWidget {
  const DevotionalScreen({Key? key}) : super(key: key);

  @override
  _DevotionalScreenState createState() => _DevotionalScreenState();
}

class _DevotionalScreenState extends State<DevotionalScreen> {
  String _devotional = '';

  @override
  void initState() {
    super.initState();
    _loadDevotional();
  }

  void _loadDevotional() async {
    final text = await DevotionalService.getTodayDevotional();
    setState(() => _devotional = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Devotional')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _devotional.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Text(_devotional, style: const TextStyle(fontSize: 18)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/search'),
        child: const Icon(Icons.search),
      ),
    );
  }
}