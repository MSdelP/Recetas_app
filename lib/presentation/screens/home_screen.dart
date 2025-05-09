import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/receta_item.dart';
import '../widgets/receta_filters.dart';
import 'receta_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recetaVm = context.watch<RecetaViewModel>();
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Recetas')),
      body: Column(
        children: [
          const RecetaFilters(),
          Expanded(
            child: recetaVm.visibles.isEmpty
                ? const Center(child: Text('No se encontraron recetas.'))
                : ListView.builder(
              itemCount: recetaVm.visibles.length,
              itemBuilder: (ctx, i) => RecetaItem(receta: recetaVm.visibles[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: authVm.isLoggedIn
          ? FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, RecetaFormScreen.routeName),
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}