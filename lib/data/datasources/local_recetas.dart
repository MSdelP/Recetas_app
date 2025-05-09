import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/receta_model.dart';

/// Datasource que guarda las recetas creadas/editadas/eliminadas por el usuario
/// en SharedPreferences como JSON.
class LocalRecetasDatasource {
  static const String _localKey = 'local_recetas';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  /// Carga todas las recetas de usuario.
  Future<List<RecetaModel>> loadRecetas() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_localKey);
    if (raw == null) return [];
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => RecetaModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Guarda la lista completa de recetas de usuario.
  Future<void> saveRecetas(List<RecetaModel> recetas) async {
    final prefs = await _prefs;
    final jsonList = recetas.map((r) => r.toJson()).toList();
    await prefs.setString(_localKey, jsonEncode(jsonList));
  }

  /// Añade una nueva receta de usuario.
  Future<void> addReceta(RecetaModel receta) async {
    final recetas = await loadRecetas();
    recetas.add(receta);
    await saveRecetas(recetas);
  }

  /// Actualiza una receta existente (por id).
  Future<void> updateReceta(RecetaModel receta) async {
    final recetas = await loadRecetas();
    final idx = recetas.indexWhere((r) => r.id == receta.id);
    if (idx != -1) {
      recetas[idx] = receta;
      await saveRecetas(recetas);
    }
  }

  /// Elimina una receta de usuario por id.
  Future<void> deleteReceta(String id) async {
    final recetas = await loadRecetas();
    recetas.removeWhere((r) => r.id == id);
    await saveRecetas(recetas);
  }
}
