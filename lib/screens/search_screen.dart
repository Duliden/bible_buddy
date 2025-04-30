import 'package:flutter/material.dart';
import '../services/bible_database.dart';
import '../widgets/verse_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];

  void _search() async {
    if (_controller.text.isEmpty) return;
    final res = await BibleDatabase.instance.searchVerses(_controller.text);
    setState(() => _results = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bible Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search verses',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _search(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (_, i) => VerseTile(data: _results[i]),
            ),
          ),
        ],
      ),
    );
  }
}