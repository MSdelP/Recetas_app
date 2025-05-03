import 'package:flutter/foundation.dart';
import 'package:receta_app/domain/entities/receta.dart';
import 'package:receta_app/data/datasources/mock_recetas.dart';
import 'package:receta_app/services/local_storage_service.dart';

class RecetaViewModel extends ChangeNotifier {
  final _storage = LocalStorageService();

  List<Receta> _todas = [];
  List<Receta> _visibles = [];

  List<Receta> get recetas => _visibles;

  String _busqueda = '';
  String _dieta = 'Todas';
  String _dificultad = 'Todas';
  String _pais = 'Todos';

  String get dieta => _dieta;
  String get dificultad => _dificultad;
  String get pais => _pais;

  /// Retorna lista de países únicos desde las recetas (más opción 'Todos')
  List<String> get paisesDisponibles {
    final paisesUnicos = _todas.map((r) => r.pais).toSet().toList();
    paisesUnicos.sort();
    return ['Todos', ...paisesUnicos];
  }

  Set<String> favoritos = {};
  Set<String> historial = {};

  RecetaViewModel() {
    cargarRecetas();
    cargarFavoritosYHistorial();
  }

  void cargarRecetas() {
    _todas = recetasMock;
    aplicarFiltros();
  }

  Future<void> cargarFavoritosYHistorial() async {
    favoritos = (await _storage.getFavoritos()).toSet();
    historial = (await _storage.getHistorial()).toSet();
    notifyListeners();
  }

  void alternarFavorito(String recetaId) async {
    await _storage.toggleFavorito(recetaId);
    await cargarFavoritosYHistorial();
  }

  void agregarAHistorial(String recetaId) async {
    await _storage.agregarAHistorial(recetaId);
    await cargarFavoritosYHistorial();
  }

  bool esFavorita(String recetaId) {
    return favoritos.contains(recetaId);
  }

  void setBusqueda(String texto) {
    _busqueda = texto.toLowerCase();
    aplicarFiltros();
  }

  void setDieta(String dieta) {
    _dieta = dieta;
    aplicarFiltros();
  }

  void setDificultad(String dificultad) {
    _dificultad = dificultad;
    aplicarFiltros();
  }

  void setPais(String pais) {
    _pais = pais;
    aplicarFiltros();
  }

  void aplicarFiltros() {
    _visibles = _todas.where((receta) {
      final coincideBusqueda = receta.titulo.toLowerCase().contains(_busqueda) ||
          receta.ingredientes.any((i) => i.toLowerCase().contains(_busqueda));

      final coincideDieta =
          _dieta == 'Todas' || receta.dietas.contains(_dieta.toLowerCase());

      final coincideDificultad =
          _dificultad == 'Todas' || receta.dificultad == _dificultad.toLowerCase();

      final coincidePais = _pais == 'Todos' || receta.pais == _pais;

      return coincideBusqueda && coincideDieta && coincideDificultad && coincidePais;
    }).toList();

    notifyListeners();
  }
}
