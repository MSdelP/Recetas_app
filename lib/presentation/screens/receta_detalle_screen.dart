import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/receta_model.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'receta_form_screen.dart';

class RecetaDetalleScreen extends StatelessWidget {
  static const routeName = '/receta-detalle';

  final RecetaModel receta;
  const RecetaDetalleScreen({Key? key, required this.receta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recetaVm = context.read<RecetaViewModel>();
    final authVm = context.read<AuthViewModel>();

    // Añadir al historial una vez
    WidgetsBinding.instance.addPostFrameCallback((_) {
      recetaVm.addToHistory(receta.id);
    });

    final isAuthor = authVm.isLoggedIn && receta.autor == authVm.user!.username;

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (receta.imagenUrl.isNotEmpty)
            Image.network(receta.imagenUrl),
          const SizedBox(height: 12),
          Text(receta.descripcion),
          // … resto de detalle …
        ]),
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
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
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