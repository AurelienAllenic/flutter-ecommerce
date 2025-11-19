import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutIcon extends StatelessWidget {
  final Color color;
  final double size;

  const LogoutIcon({super.key, this.color = Colors.black, this.size = 28});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout, color: color, size: size),
      onPressed: () => _logout(context),
      tooltip: "Se déconnecter",
    );
  }
}
