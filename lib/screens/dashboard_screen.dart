

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'devotional_screen.dart';
import 'bible_qa_screen.dart';
import 'personalized_study_screen.dart';
import 'search_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todayDate = DateFormat('MMMM d').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Buddy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          children: [
            // Daily Devotional panel
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DevotionalScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Today', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(todayDate, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      const Text(
                        '“The Lord is near to all who call on him.”\nPsalm 145:18',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bible Q&A panel
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BibleQAScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.chat_bubble, size: 40),
                    SizedBox(height: 8),
                    Text('Bible Q&A', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            // Personalized Study panel
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PersonalizedStudyScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check_circle, size: 40),
                    SizedBox(height: 8),
                    Text('Personalized Study', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            // Search/Reference panel
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.search, size: 40),
                    SizedBox(height: 8),
                    Text('Search / Reference', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}