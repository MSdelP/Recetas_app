import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receta_app/presentation/viewmodels/receta_viewmodel.dart';
import 'package:receta_app/presentation/widgets/receta_item.dart';
import 'package:receta_app/presentation/widgets/receta_filters.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecetaViewModel>(context);

    return Column(
      children: [
        const RecetaFilters(),
        Expanded(
          child: viewModel.recetas.isEmpty
              ? const Center(child: Text('No se encontraron recetas.'))
              : ListView.builder(
            itemCount: viewModel.recetas.length,
            itemBuilder: (context, index) {
              final receta = viewModel.recetas[index];
              return RecetaItem(receta: receta);
            },
          ),
        ),
      ],
    );
  }
}
