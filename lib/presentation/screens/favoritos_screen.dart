import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../widgets/receta_item.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecetaViewModel>();
    return FutureBuilder<List<String>>(
      future: vm.getFavoriteIds(),
      builder: (ctx, snap) {
        final favIds = snap.data ?? [];
        final favoritas = vm.visibles.where((r) => favIds.contains(r.id)).toList();
        if (favIds.isEmpty) {
          return const Center(child: Text('No tienes recetas favoritas'));
        }
        return ListView.builder(
          itemCount: favoritas.length,
          itemBuilder: (_, i) => RecetaItem(receta: favoritas[i]),
        );
      },
    );
  }
}