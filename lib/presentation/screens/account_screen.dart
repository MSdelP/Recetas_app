// lib/presentation/screens/account_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../widgets/receta_item.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final recetaVm = context.watch<RecetaViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mi cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: authVm.isLoggedIn
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hola, ${authVm.user!.username}',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Mis recetas
            Expanded(
              child: Builder(
                builder: (_) {
                  final misRecetas = recetaVm.visibles
                      .where((r) => r.autor == authVm.user!.username)
                      .toList();

                  if (misRecetas.isEmpty) {
                    return Center(
                      child: Text(
                        'Aún no has creado ninguna receta.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: misRecetas.length,
                    itemBuilder: (ctx, i) =>
                        RecetaItem(receta: misRecetas[i]),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                authVm.logout();
                Navigator.pushReplacementNamed(
                    context, '/'); // o la ruta de login
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/login'),
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/register'),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
