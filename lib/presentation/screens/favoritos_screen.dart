import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receta_app/presentation/viewmodels/receta_viewmodel.dart';
import 'package:receta_app/presentation/widgets/receta_item.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecetaViewModel>(context);
    final favoritas = viewModel.recetas
        .where((r) => viewModel.favoritos.contains(r.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Favoritas'),
      ),
      body: favoritas.isEmpty
          ? const Center(child: Text('No hay recetas favoritas.'))
          : ListView.builder(
        itemCount: favoritas.length,
        itemBuilder: (context, index) {
          return RecetaItem(receta: favoritas[index]);
        },
      ),
    );
  }
}
