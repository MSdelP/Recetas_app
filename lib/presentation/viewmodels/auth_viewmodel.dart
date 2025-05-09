import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../services/auth_service.dart';

/// ViewModel para estado de autenticación.
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  AuthViewModel() {
    _init();
  }

  Future<void> _init() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }

  /// Registra y, opcionalmente, hace login.
  Future<bool> register(String username, String password) async {
    final ok = await _authService.register(username, password);
    return ok;
  }

  /// Hace login. Devuelve true si tuvo éxito.
  Future<bool> login(String username, String password) async {
    final u = await _authService.login(username, password);
    if (u != null) {
      _user = u;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Cierra la sesión.
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}