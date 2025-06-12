import 'package:flutter/material.dart';
import '../../data/models/receta_model.dart';
import '../screens/receta_detalle_screen.dart';

class RecetaItem extends StatelessWidget {
  final RecetaModel receta;
  const RecetaItem({super.key, required this.receta});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: Image.network(
          receta.imagenUrl,
          width: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.image),
        ),
        title: Text(receta.titulo),
        subtitle: Text('${receta.tiempoMinutos} min · ${receta.dificultad}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecetaDetalleScreen(receta: receta),
            ),
          );
        },
      ),
    );
  }
}