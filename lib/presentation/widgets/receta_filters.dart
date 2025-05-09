import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/receta_viewmodel.dart';

class RecetaFilters extends StatelessWidget {
  const RecetaFilters({Key? key}) : super(key: key);

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
                  value: vm.dieta.isEmpty ? null : vm.dieta,
                  hint: const Text('Dieta'),
                  items: vm.dietasDisponibles
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) => vm.setDieta(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: vm.dificultad.isEmpty ? null : vm.dificultad,
                  hint: const Text('Dificultad'),
                  items: vm.dificultadesDisponibles
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) => vm.setDificultad(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: vm.pais.isEmpty ? null : vm.pais,
                  hint: const Text('País'),
                  items: vm.paisesDisponibles
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
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