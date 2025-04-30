import 'package:flutter/material.dart';
import 'screens/devotional_screen.dart';
import 'screens/search_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/bible_qa_screen.dart';
import 'screens/personalized_study_screen.dart';
import 'services/bible_database.dart';
import 'services/purchase_service.dart';
import 'screens/purchase_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize and prepopulate the local database
  await BibleDatabase.instance.database;
  await PurchaseService.init();
  runApp(const BibleMVP());
}

class BibleMVP extends StatelessWidget {
  const BibleMVP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Buddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PurchaseService.isPremiumAvailable(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final isPremium = snapshot.data!;
        if (!isPremium) {
          return const PurchaseScreen();
        }
        return const HomeScreen(title: 'Bible Buddy');
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardScreen(),
    DevotionalScreen(),
    BibleQAScreen(),
    PersonalizedStudyScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Daily Devotionals'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Bible Q&A'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Personalized Study'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search/Reference'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}