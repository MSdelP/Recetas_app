import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _loading = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorText != null)
                Text(_errorText!, style: TextStyle(color: Colors.red)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _username = v!.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                onSaved: (v) => _password = v!.trim(),
              ),
              SizedBox(height: 24),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: Text('Crear cuenta'),
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
    final created = await auth.register(_username, _password);
    setState(() => _loading = false);
    if (created) {
      // auto-login tras registro
      final logged = await auth.login(_username, _password);
      if (logged) Navigator.pop(context);
    } else {
      setState(() => _errorText = 'El usuario ya existe');
    }
  }
}