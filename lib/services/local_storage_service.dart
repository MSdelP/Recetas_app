import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart'; // <-- para saber qué usuario está logueado

/// Servicio para favoritos e historial, ahora por usuario.
class LocalStorageService {
  static const String _favKeyPrefix = 'favorites';
  static const String _histKeyPrefix = 'history';

  final AuthService _authService;

  LocalStorageService({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  /// Construye la clave única de favoritos para el usuario actual.
  Future<String> _favoritesKey() async {
    final user = await _authService.getCurrentUser();
    final uname = user?.username ?? 'guest';
    return '$_favKeyPrefix\_$uname';
  }

  /// Construye la clave única de historial para el usuario actual.
  Future<String> _historyKey() async {
    final user = await _authService.getCurrentUser();
    final uname = user?.username ?? 'guest';
    return '$_histKeyPrefix\_$uname';
  }

  /// Alterna un favorito (añade o quita) en la lista del usuario.
  Future<void> toggleFavorite(String id) async {
    final prefs = await _prefs;
    final key = await _favoritesKey();
    final favs = prefs.getStringList(key) ?? [];
    if (favs.contains(id)) {
      favs.remove(id);
    } else {
      favs.add(id);
    }
    await prefs.setStringList(key, favs);
  }

  /// Comprueba si una receta es favorita para el usuario actual.
  Future<bool> isFavorite(String id) async {
    final prefs = await _prefs;
    final key = await _favoritesKey();
    final favs = prefs.getStringList(key) ?? [];
    return favs.contains(id);
  }

  /// Devuelve la lista de IDs favoritas del usuario actual.
  Future<List<String>> getFavorites() async {
    final prefs = await _prefs;
    final key = await _favoritesKey();
    return prefs.getStringList(key) ?? [];
  }

  /// Añade un elemento al historial del usuario actual.
  Future<void> addToHistory(String id) async {
    final prefs = await _prefs;
    final key = await _historyKey();
    final hist = prefs.getStringList(key) ?? [];
    if (!hist.contains(id)) {
      hist.add(id);
      await prefs.setStringList(key, hist);
    }
  }

  /// Devuelve la lista de IDs del historial del usuario actual.
  Future<List<String>> getHistory() async {
    final prefs = await _prefs;
    final key = await _historyKey();
    return prefs.getStringList(key) ?? [];
  }
}
