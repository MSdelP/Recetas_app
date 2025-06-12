import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../widgets/receta_item.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecetaViewModel>();
    return FutureBuilder<List<String>>(
      future: vm.getHistoryIds(),
      builder: (ctx, snap) {
        final hIds = snap.data ?? [];
        final historial = vm.visibles.where((r) => hIds.contains(r.id)).toList();
        if (hIds.isEmpty) {
          return const Center(child: Text('No hay historial aún'));
        }
        return ListView.builder(
          itemCount: historial.length,
          itemBuilder: (_, i) => RecetaItem(receta: historial[i]),
        );
      },
    );
  }
}