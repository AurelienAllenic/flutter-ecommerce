import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🔥 Chemins corrigés selon le nom du projet et ton dossier `pages`
import 'package:e_commerce/pages/register.dart';
import 'package:e_commerce/pages/product_listing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous êtes bien connecté !')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductListingPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: login, child: const Text("Se connecter")),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text("Créer un compte"),
            ),
          ],
        ),
      ),
    );
  }
}
