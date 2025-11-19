import 'package:flutter/material.dart';

class CancelPage extends StatelessWidget {
  const CancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paiement annulé")),
      body: const Center(
        child: Text(
          "Votre paiement n’a pas été effectué ❌",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
