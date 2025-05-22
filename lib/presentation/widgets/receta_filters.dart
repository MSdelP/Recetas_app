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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de búsqueda
          TextField(
            decoration: const InputDecoration(
              labelText: 'Buscar',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: vm.setBusqueda,
          ),
          const SizedBox(height: 8),
          // Filtros en fila
          Row(
            children: [
              // Dieta
              Expanded(
                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: vm.dieta.isEmpty ? null : vm.dieta,
                  hint: const Text('Dieta'),
                  items: [
                    // Único elemento null para "Todas"
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('— Todas —'),
                    ),
                    // Solo dietas no vacías
                    for (var d in vm.dietasDisponibles)
                      if (d.isNotEmpty)
                        DropdownMenuItem<String?>(
                          value: d,
                          child: Text(d),
                        ),
                  ],
                  onChanged: (v) => vm.setDieta(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              // Dificultad
              Expanded(
                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: vm.dificultad.isEmpty ? null : vm.dificultad,
                  hint: const Text('Dificultad'),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('— Todas —'),
                    ),
                    for (var dd in vm.dificultadesDisponibles)
                      if (dd.isNotEmpty)
                        DropdownMenuItem<String?>(
                          value: dd,
                          child: Text(dd),
                        ),
                  ],
                  onChanged: (v) => vm.setDificultad(v ?? ''),
                ),
              ),
              const SizedBox(width: 8),
              // País
              Expanded(
                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: vm.pais.isEmpty ? null : vm.pais,
                  hint: const Text('País'),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('— Todos —'),
                    ),
                    for (var c in vm.paisesDisponibles)
                      if (c.isNotEmpty)
                        DropdownMenuItem<String?>(
                          value: c,
                          child: Text(c),
                        ),
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
