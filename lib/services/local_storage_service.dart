import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para favoritos e historial (stubs para compilar).
class LocalStorageService {
  static const String _favKey = 'favorites';
  static const String _histKey = 'history';

  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  /// Alterna un favorito (añade o quita).
  Future<void> toggleFavorite(String id) async {
    final prefs = await _prefs;
    final favs = prefs.getStringList(_favKey) ?? [];
    if (favs.contains(id)) {
      favs.remove(id);
    } else {
      favs.add(id);
    }
    await prefs.setStringList(_favKey, favs);
  }

  /// Comprueba si una receta es favorita.
  Future<bool> isFavorite(String id) async {
    final prefs = await _prefs;
    final favs = prefs.getStringList(_favKey) ?? [];
    return favs.contains(id);
  }

  /// Devuelve la lista de IDs favoritas.
  Future<List<String>> getFavorites() async {
    final prefs = await _prefs;
    return prefs.getStringList(_favKey) ?? [];
  }

  /// Añade un ID al historial (si no existía).
  Future<void> addToHistory(String id) async {
    final prefs = await _prefs;
    final hist = prefs.getStringList(_histKey) ?? [];
    if (!hist.contains(id)) {
      hist.add(id);
      await prefs.setStringList(_histKey, hist);
    }
  }

  /// Devuelve la lista de IDs del historial.
  Future<List<String>> getHistory() async {
    final prefs = await _prefs;
    return prefs.getStringList(_histKey) ?? [];
  }
}