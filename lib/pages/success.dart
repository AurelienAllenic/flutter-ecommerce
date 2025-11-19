import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paiement réussi")),
      body: const Center(
        child: Text(
          "Merci pour votre achat ! ✅",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
