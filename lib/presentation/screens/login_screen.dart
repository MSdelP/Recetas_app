import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _loading = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorText != null)
                Text(_errorText!, style: const TextStyle(color: Colors.red)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuario'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _username = v!.trim(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _password = v!.trim(),
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: const Text('Entrar'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _loading = true;
      _errorText = null;
    });
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final ok = await auth.login(_username, _password);
    setState(() => _loading = false);
    if (ok) {
      Navigator.pop(context);
    } else {
      setState(() => _errorText = 'Usuario o contraseña incorrectos');
    }
  }
}