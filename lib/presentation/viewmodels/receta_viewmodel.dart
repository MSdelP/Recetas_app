import 'package:flutter/material.dart';
import '../../data/datasources/mock_recetas.dart';
import '../../data/datasources/local_recetas.dart';
import '../../data/models/receta_model.dart';
import '../../services/local_storage_service.dart';

class RecetaViewModel extends ChangeNotifier {
  final LocalRecetasDatasource _localDs = LocalRecetasDatasource();
  final LocalStorageService _storage = LocalStorageService();

  final List<RecetaModel> _todas = [];
  List<RecetaModel> _visibles = [];
  List<RecetaModel> get visibles => _visibles;

  String _search = '';
  String get busqueda => _search;
  String _dietFilter = '';
  String get dieta => _dietFilter;
  String _difficultyFilter = '';
  String get dificultad => _difficultyFilter;
  String _countryFilter = '';
  String get pais => _countryFilter;

  RecetaViewModel() {
    _init();
  }

  Future<void> _init() async {
    _todas.clear();
    _todas.addAll(recetasMock);
    final localList = await _localDs.loadRecetas();
    _todas.addAll(localList);
    _visibles = List.from(_todas);
    notifyListeners();
  }

  // getters para las opciones dinámicas de filtro
  List<String> get dietasDisponibles =>
      _todas.expand((r) => r.dietas).toSet().toList();
  List<String> get dificultadesDisponibles =>
      _todas.map((r) => r.dificultad).toSet().toList();
  List<String> get paisesDisponibles =>
      _todas.map((r) => r.pais).toSet().toList();

  // ------------- filtros y búsqueda --------------

  void setBusqueda(String q) {
    _search = q;
    _applyFilters();
  }

  void setDieta(String d) {
    _dietFilter = d;
    _applyFilters();
  }

  void setDificultad(String d) {
    _difficultyFilter = d;
    _applyFilters();
  }

  void setPais(String p) {
    _countryFilter = p;
    _applyFilters();
  }

  void _applyFilters() {
    _visibles = _todas.where((r) {
      if (_search.isNotEmpty &&
          !r.titulo.toLowerCase().contains(_search.toLowerCase())) {
        return false;
      }
      if (_dietFilter.isNotEmpty && !r.dietas.contains(_dietFilter)) {
        return false;
      }
      if (_difficultyFilter.isNotEmpty && r.dificultad != _difficultyFilter) {
        return false;
      }
      if (_countryFilter.isNotEmpty && r.pais != _countryFilter) {
        return false;
      }
      return true;
    }).toList();
    notifyListeners();
  }

  // ------------- CRUD recetas de usuario --------------

  Future<void> addReceta(RecetaModel receta) async {
    await _localDs.addReceta(receta);
    _todas.add(receta);
    _applyFilters();
  }

  Future<void> updateReceta(RecetaModel receta) async {
    await _localDs.updateReceta(receta);
    final idx = _todas.indexWhere((r) => r.id == receta.id);
    if (idx != -1) {
      _todas[idx] = receta;
      _applyFilters();
    }
  }

  Future<void> deleteReceta(String id) async {
    await _localDs.deleteReceta(id);
    _todas.removeWhere((r) => r.id == id);
    _applyFilters();
  }

  // ------------- favoritos e historial --------------

  Future<void> toggleFavorite(String id) async {
    await _storage.toggleFavorite(id);
    notifyListeners();
  }

  Future<bool> isFavorite(String id) async {
    return _storage.isFavorite(id);
  }

  Future<void> addToHistory(String id) async {
    await _storage.addToHistory(id);
    notifyListeners();
  }

  Future<List<String>> getFavoriteIds() async {
    return _storage.getFavorites();
  }

  Future<List<String>> getHistoryIds() async {
    return _storage.getHistory();
  }
}