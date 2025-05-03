import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receta_app/presentation/viewmodels/receta_viewmodel.dart';
import 'package:receta_app/presentation/widgets/receta_item.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecetaViewModel>(context);
    final historial = viewModel.recetas
        .where((r) => viewModel.historial.contains(r.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Recetas'),
      ),
      body: historial.isEmpty
          ? const Center(child: Text('No has visto ninguna receta aún.'))
          : ListView.builder(
        itemCount: historial.length,
        itemBuilder: (context, index) {
          return RecetaItem(receta: historial[index]);
        },
      ),
    );
  }
}
