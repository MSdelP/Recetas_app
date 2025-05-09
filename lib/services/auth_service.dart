import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/entities/user.dart';

/// Servicio de autenticación simple usando SharedPreferences.
class AuthService {
  static const String _usersKey = 'users_list';
  static const String _currentUserKey = 'current_user';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<List<Map<String, String>>> _loadUsers() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_usersKey);
    if (raw == null) return [];
    final List<dynamic> decoded = jsonDecode(raw);
    return decoded.cast<Map<String, dynamic>>().map((m) => m.cast<String, String>()).toList();
  }

  Future<void> _saveUsers(List<Map<String, String>> users) async {
    final prefs = await _prefs;
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  /// Registra un nuevo usuario. Devuelve false si el usuario ya existía.
  Future<bool> register(String username, String password) async {
    final users = await _loadUsers();
    if (users.any((u) => u['username'] == username)) return false;
    users.add({'username': username, 'password': password});
    await _saveUsers(users);
    return true;
  }

  /// Intenta hacer login. Devuelve el objeto User si tiene éxito, o null si falla.
  Future<User?> login(String username, String password) async {
    final users = await _loadUsers();
    final match = users.firstWhere(
          (u) => u['username'] == username && u['password'] == password,
      orElse: () => {},
    );
    if (match.isEmpty) return null;
    final prefs = await _prefs;
    await prefs.setString(_currentUserKey, username);
    return User(username: username);
  }

  /// Cierra la sesión del usuario actual.
  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_currentUserKey);
  }

  /// Recupera el usuario actualmente logueado, o null si no hay ninguno.
  Future<User?> getCurrentUser() async {
    final prefs = await _prefs;
    final username = prefs.getString(_currentUserKey);
    if (username == null) return null;
    return User(username: username);
  }
}