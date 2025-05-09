import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Mi cuenta')),
      body: Center(
        child: auth.isLoggedIn
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hola, ${auth.user!.username}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: const Text('Cerrar sesión'),
            ),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, RegisterScreen.routeName),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}