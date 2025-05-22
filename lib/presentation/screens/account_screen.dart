import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/receta_viewmodel.dart';
import 'package:receta_app/data/models/receta_model.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'receta_detalle_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final allRecetas = context.watch<RecetaViewModel>().visibles;
    final usuario = auth.user;
    final misRecetas = usuario != null
        ? allRecetas.where((r) => r.autor == usuario.username).toList()
        : <RecetaModel>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Mi cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: auth.isLoggedIn
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hola, ${usuario!.username}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: const Text('Cerrar sesión'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Mis recetas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: misRecetas.isNotEmpty
                  ? ListView.builder(
                itemCount: misRecetas.length,
                itemBuilder: (ctx, i) {
                  final receta = misRecetas[i];
                  return ListTile(
                    title: Text(receta.titulo),
                    subtitle: Text(
                        '${receta.tiempoMinutos} min · ${receta.dificultad}'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RecetaDetalleScreen.routeName,
                        arguments: receta,
                      );
                    },
                  );
                },
              )
                  : const Center(
                child: Text('No has creado ninguna receta aún.'),
              ),
            ),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                  context, LoginScreen.routeName),
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                  context, RegisterScreen.routeName),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
