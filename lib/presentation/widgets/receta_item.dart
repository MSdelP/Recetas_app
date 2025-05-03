import 'package:flutter/material.dart';
import 'package:receta_app/domain/entities/receta.dart';
import 'package:receta_app/presentation/screens/receta_detalle_screen.dart';


class RecetaItem extends StatelessWidget {
  final Receta receta;

  const RecetaItem({Key? key, required this.receta}) : super(key: key);

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
        subtitle: Text('${receta.tiempoMinutos} min • ${receta.dificultad}'),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          // Aquí luego irá la navegación al detalle
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
