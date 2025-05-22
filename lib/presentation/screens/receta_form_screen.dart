import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receta_app/data/models/receta_model.dart';
import '../viewmodels/receta_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

class RecetaFormScreen extends StatefulWidget {
  static const routeName = '/receta-form';
  final RecetaModel? receta;
  const RecetaFormScreen({super.key, this.receta});

  @override
  _RecetaFormScreenState createState() => _RecetaFormScreenState();
}

class _RecetaFormScreenState extends State<RecetaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late String _titulo;
  late String _descripcion;
  late String _ingredientes;
  late String _pasos;
  late String _imagenUrl;
  late String _tiempoMinutos;
  late String _dificultad;
  late String _tipoComida;
  late String _dietas;
  late String _pais;
  late DateTime _creadaEn;

  @override
  void initState() {
    super.initState();
    final r = widget.receta;
    if (r != null) {
      _id = r.id;
      _titulo = r.titulo;
      _descripcion = r.descripcion;
      _ingredientes = r.ingredientes.join(', ');
      _pasos = r.pasos.join('\n');
      _imagenUrl = r.imagenUrl;
      _tiempoMinutos = r.tiempoMinutos.toString();
      _dificultad = r.dificultad;
      _tipoComida = r.tipoComida;
      _dietas = r.dietas.join(', ');
      _pais = r.pais;
      _creadaEn = r.creadaEn;
    } else {
      _id = DateTime.now().millisecondsSinceEpoch.toString();
      _titulo = '';
      _descripcion = '';
      _ingredientes = '';
      _pasos = '';
      _imagenUrl = '';
      _tiempoMinutos = '';
      _dificultad = '';
      _tipoComida = '';
      _dietas = '';
      _pais = '';
      _creadaEn = DateTime.now();
    }
  }

  Future<void> _pickDate() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _creadaEn,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (fecha != null) setState(() => _creadaEn = fecha);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final receta = RecetaModel(
      id: _id,
      titulo: _titulo,
      descripcion: _descripcion,
      ingredientes: _ingredientes
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      pasos: _pasos
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      imagenUrl: _imagenUrl,
      tiempoMinutos: int.tryParse(_tiempoMinutos) ?? 0,
      dificultad: _dificultad,
      tipoComida: _tipoComida,
      dietas: _dietas
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      autor: Provider.of<AuthViewModel>(context, listen: false)
          .user!
          .username,
      valoracion: widget.receta?.valoracion ?? 0.0,
      calorias: widget.receta?.calorias ?? 0,
      creadaEn: _creadaEn,
      pais: _pais,
    );
    final vm = Provider.of<RecetaViewModel>(context, listen: false);
    if (widget.receta != null) {
      vm.updateReceta(receta);
    } else {
      vm.addReceta(receta);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.receta != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar receta' : 'Nueva receta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _titulo,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _titulo = v!.trim(),
              ),
              TextFormField(
                initialValue: _descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _descripcion = v!.trim(),
              ),
              TextFormField(
                initialValue: _ingredientes,
                decoration: InputDecoration(labelText: 'Ingredientes (separados por coma)'),
                maxLines: 2,
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _ingredientes = v!.trim(),
              ),
              TextFormField(
                initialValue: _pasos,
                decoration: InputDecoration(labelText: 'Pasos (una línea por paso)'),
                maxLines: 3,
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _pasos = v!.trim(),
              ),
              TextFormField(
                initialValue: _imagenUrl,
                decoration: InputDecoration(labelText: 'URL de imagen (opcional)'),
                onSaved: (v) => _imagenUrl = v?.trim() ?? '',
              ),
              TextFormField(
                initialValue: _tiempoMinutos,
                decoration: InputDecoration(labelText: 'Tiempo (minutos)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Requerido';
                  if (int.tryParse(v.trim()) == null) return 'Número inválido';
                  return null;
                },
                onSaved: (v) => _tiempoMinutos = v!.trim(),
              ),
              TextFormField(
                initialValue: _dificultad,
                decoration: InputDecoration(labelText: 'Dificultad'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _dificultad = v!.trim(),
              ),
              TextFormField(
                initialValue: _tipoComida,
                decoration: InputDecoration(labelText: 'Tipo de comida'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _tipoComida = v!.trim(),
              ),
              TextFormField(
                initialValue: _dietas,
                decoration: InputDecoration(labelText: 'Dietas (separadas por coma)'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _dietas = v!.trim(),
              ),
              TextFormField(
                initialValue: _pais,
                decoration: InputDecoration(labelText: 'País'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                onSaved: (v) => _pais = v!.trim(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Fecha creación: ${_creadaEn.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  TextButton(onPressed: _pickDate, child: Text('Cambiar')),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Guardar cambios' : 'Crear receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
