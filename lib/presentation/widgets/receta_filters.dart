import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/receta_viewmodel.dart';

class RecetaFilters extends StatelessWidget {
  const RecetaFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecetaViewModel>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Buscar',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: vm.setBusqueda,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: vm.dieta.isEmpty ? '' : vm.dieta,
                  hint: const Text('Dieta'),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('— Todas —')),
                    for (var d in vm.dietasDisponibles) DropdownMenuItem(value: d, child: Text(d)),
                  ],
                  onChanged: (v) => vm.setDieta(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: vm.dificultad.isEmpty ? '' : vm.dificultad,
                  hint: const Text('Dificultad'),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('— Todas —')),
                    for (var d in vm.dificultadesDisponibles) DropdownMenuItem(value: d, child: Text(d)),
                  ],
                  onChanged: (v) => vm.setDificultad(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: vm.pais.isEmpty ? '' : vm.pais,
                  hint: const Text('País'),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('— Todas —')),
                    for (var c in vm.paisesDisponibles) DropdownMenuItem(value: c, child: Text(c)),
                  ],
                  onChanged: (v) => vm.setPais(v ?? ''),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}