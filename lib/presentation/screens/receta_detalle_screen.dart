import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receta_app/domain/entities/receta.dart';
import 'package:receta_app/presentation/viewmodels/receta_viewmodel.dart';

class RecetaDetalleScreen extends StatelessWidget {
  final Receta receta;

  const RecetaDetalleScreen({super.key, required this.receta});

  @override
  Widget build(BuildContext context) {
    // Registrar en historial tras build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecetaViewModel>(context, listen: false)
          .agregarAHistorial(receta.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(receta.titulo),
        actions: [
          Consumer<RecetaViewModel>(
            builder: (context, viewModel, _) {
              final esFavorita = viewModel.esFavorita(receta.id);
              return IconButton(
                icon: Icon(
                  esFavorita ? Icons.favorite : Icons.favorite_border,
                  color: esFavorita ? Colors.red : null,
                ),
                onPressed: () {
                  viewModel.alternarFavorito(receta.id);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              receta.imagenUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image),
            ),
            const SizedBox(height: 16),
            Text(
              receta.descripcion,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredientes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...receta.ingredientes.map((i) => Text('• $i')).toList(),
            const SizedBox(height: 16),
            Text(
              'Pasos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...receta.pasos.asMap().entries.map(
                  (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('${e.key + 1}. ${e.value}'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Dificultad: ${receta.dificultad}  •  Tiempo: ${receta.tiempoMinutos} min',
            ),
            Text('Calorías: ${receta.calorias} kcal'),
            const SizedBox(height: 8),
            Text('Autor: ${receta.autor}'),
            Text('Etiquetas: ${receta.dietas.join(', ')}'),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text('${receta.valoracion} / 5.0'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
