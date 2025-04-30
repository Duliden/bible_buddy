import 'package:flutter/material.dart';

class VerseTile extends StatelessWidget {
  final Map<String, dynamic> data;
  const VerseTile({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = data['book'];
    final chapter = data['chapter'];
    final verse = data['verse'];
    final text = data['text'];
    return ListTile(
      title: Text('$book $chapter:$verse'),
      subtitle: Text(text),
    );
  }
}