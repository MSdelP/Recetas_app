import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _favoritosKey = 'favoritos';
  static const _historialKey = 'historial';

  Future<List<String>> getFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritosKey) ?? [];
  }

  Future<List<String>> getHistorial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historialKey) ?? [];
  }

  Future<void> toggleFavorito(String recetaId) async {
    final prefs = await SharedPreferences.getInstance();
    final actuales = prefs.getStringList(_favoritosKey) ?? [];

    if (actuales.contains(recetaId)) {
      actuales.remove(recetaId);
    } else {
      actuales.add(recetaId);
    }

    await prefs.setStringList(_favoritosKey, actuales);
  }

  Future<void> agregarAHistorial(String recetaId) async {
    final prefs = await SharedPreferences.getInstance();
    final actuales = prefs.getStringList(_historialKey) ?? [];

    actuales.remove(recetaId); // evitar duplicados
    actuales.insert(0, recetaId); // más reciente primero

    if (actuales.length > 50) {
      actuales.removeLast();
    }

    await prefs.setStringList(_historialKey, actuales);
  }
}
