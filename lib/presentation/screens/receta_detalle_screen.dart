// lib/presentation/screens/receta_detalle_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/receta_model.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'receta_form_screen.dart';

class RecetaDetalleScreen extends StatelessWidget {
  static const routeName = '/receta-detalle';

  final RecetaModel receta;
  const RecetaDetalleScreen({super.key, required this.receta});

  @override
  Widget build(BuildContext context) {
    final recetaVm = context.read<RecetaViewModel>();
    final authVm = context.read<AuthViewModel>();

    // Añadir al historial solo una vez tras pintar el frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      recetaVm.addToHistory(receta.id);
    });

    final isAuthor =
        authVm.isLoggedIn && receta.autor == authVm.user!.username;

    return Scaffold(
      appBar: AppBar(
        title: Text(receta.titulo),
        actions: [
          FutureBuilder<bool>(
            future: recetaVm.isFavorite(receta.id),
            builder: (ctx, snap) {
              final fav = snap.data ?? false;
              return IconButton(
                icon: Icon(fav ? Icons.star : Icons.star_border),
                onPressed: () => recetaVm.toggleFavorite(receta.id),
              );
            },
          ),
          if (isAuthor) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RecetaFormScreen.routeName,
                  arguments: receta,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen cabecera o placeholder
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: receta.imagenUrl.isNotEmpty
                  ? Image.network(
                receta.imagenUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (ctx, error, stack) =>
                const Center(child: Icon(Icons.broken_image, size: 64)),
              )
                  : const Center(child: Icon(Icons.image, size: 64)),
            ),
            const SizedBox(height: 16),
            // Descripción
            Text(
              receta.descripcion,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            // Chips de información rápida
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (receta.tiempoMinutos > 0)
                  Chip(label: Text('${receta.tiempoMinutos} min')),
                if (receta.dificultad.isNotEmpty)
                  Chip(label: Text(receta.dificultad)),
                if (receta.pais.isNotEmpty) Chip(label: Text(receta.pais)),
                for (var d in receta.dietas) Chip(label: Text(d)),
              ],
            ),
            const Divider(height: 32),
            // Ingredientes
            Text(
              'Ingredientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...receta.ingredientes.map(
                  (ing) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(ing),
              ),
            ),
            const Divider(height: 32),
            // Pasos
            Text(
              'Pasos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...receta.pasos.asMap().entries.map(
                  (e) {
                final idx = e.key + 1;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(radius: 12, child: Text('$idx')),
                  title: Text(e.value),
                );
              },
            ),
            const Divider(height: 32),
            // Metadatos adicionales
            if (receta.autor.isNotEmpty) Text('Autor: ${receta.autor}'),
            if (receta.calorias > 0) Text('Calorías: ${receta.calorias} kcal'),
            Text(
              'Creada en: ${receta.creadaEn.toLocal().toString().split(' ')[0]}',
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Eliminar receta?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    ).then((ok) {
      if (ok == true) {
        context.read<RecetaViewModel>().deleteReceta(receta.id);
        Navigator.pop(context);
      }
    });
  }
}
