

import 'package:flutter/material.dart';
import '../services/purchase_service.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    PurchaseService.init();
  }

  @override
  void dispose() {
    PurchaseService.dispose();
    super.dispose();
  }

  Future<void> _buy() async {
    setState(() => _loading = true);
    await PurchaseService.buyPremium();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade to Premium')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _buy,
                child: const Text('Buy Premium'),
              ),
      ),
    );
  }
}