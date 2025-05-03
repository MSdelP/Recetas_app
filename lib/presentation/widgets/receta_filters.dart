import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:receta_app/presentation/viewmodels/receta_viewmodel.dart';

class RecetaFilters extends StatelessWidget {
  const RecetaFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecetaViewModel>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar por nombre o ingrediente...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: viewModel.setBusqueda,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: viewModel.dieta,
                      isExpanded: true,
                      onChanged: (val) => viewModel.setDieta(val!),
                      items: const [
                        DropdownMenuItem(value: 'Todas', child: Text('Todas las dietas')),
                        DropdownMenuItem(value: 'vegetariana', child: Text('Vegetariana')),
                        DropdownMenuItem(value: 'vegana', child: Text('Vegana')),
                        DropdownMenuItem(value: 'keto', child: Text('Keto')),
                        DropdownMenuItem(value: 'sin gluten', child: Text('Sin Gluten')),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton<String>(
                      value: viewModel.dificultad,
                      isExpanded: true,
                      onChanged: (val) => viewModel.setDificultad(val!),
                      items: const [
                        DropdownMenuItem(value: 'Todas', child: Text('Todas las dificultades')),
                        DropdownMenuItem(value: 'fácil', child: Text('Fácil')),
                        DropdownMenuItem(value: 'media', child: Text('Media')),
                        DropdownMenuItem(value: 'difícil', child: Text('Difícil')),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownSearch<String>(
                items: viewModel.paisesDisponibles,
                selectedItem: viewModel.pais,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Filtrar por país",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.public),
                  ),
                ),
                onChanged: (val) {
                  if (val != null) {
                    viewModel.setPais(val);
                  }
                },
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      labelText: 'Buscar país...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
