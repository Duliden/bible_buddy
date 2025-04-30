import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class BibleDatabase {
  static final BibleDatabase instance = BibleDatabase._init();
  static Database? _database;
  BibleDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bible.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE verses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book TEXT,
        chapter INTEGER,
        verse INTEGER,
        text TEXT
      )
    ''');
    await _prepopulate(db);
  }

  Future _prepopulate(Database db) async {
    final data = await rootBundle.loadString('assets/bible/NIV_bible.json');
    final dynamic jsonResult = json.decode(data);
    // Prepare a homogeneous list of verse maps
    final List<Map<String, dynamic>> versesList = [];
    
    if (jsonResult is List) {
      // JSON is already a list of verse objects
      for (var item in jsonResult) {
        versesList.add(Map<String, dynamic>.from(item as Map));
      }
    } else if (jsonResult is Map<String, dynamic>) {
      final dynamic versesField = jsonResult['verses'];
      if (versesField is List) {
        // Wrapped list under "verses" key
        for (var item in versesField) {
          versesList.add(Map<String, dynamic>.from(item as Map));
        }
      } else if (versesField is Map<String, dynamic>) {
        // Nested structure: versesField[book][chapter][verse] = text
        versesField.forEach((book, chapters) {
          if (chapters is Map<String, dynamic>) {
            chapters.forEach((chapterKey, versesMap) {
              final chapterNum = int.tryParse(chapterKey) ?? 0;
              if (versesMap is Map<String, dynamic>) {
                versesMap.forEach((verseKey, text) {
                  final verseNum = int.tryParse(verseKey) ?? 0;
                  versesList.add({
                    'book': book,
                    'chapter': chapterNum,
                    'verse': verseNum,
                    'text': text.toString(),
                  });
                });
              }
            });
          }
        });
      }
    }
    final batch = db.batch();
    for (var v in versesList) {
      batch.insert('verses', {
        'book': v['book'],
        'chapter': v['chapter'],
        'verse': v['verse'],
        'text': v['text'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> searchVerses(String query) async {
    final db = await instance.database;
    return await db.query(
      'verses',
      where: 'text LIKE ?',
      whereArgs: ['%$query%'],
    );
  }
}