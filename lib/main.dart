// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';               // asegúrate de que en theme.dart exista 'appTheme'
import 'data/models/receta_model.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/viewmodels/receta_viewmodel.dart';
import 'presentation/screens/main_navigation_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/account_screen.dart';
import 'presentation/screens/receta_form_screen.dart';
import 'presentation/screens/receta_detalle_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RecetaViewModel()),
      ],
      child: MaterialApp(
        title: 'Recetas App',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const MainNavigationScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          AccountScreen.routeName: (ctx) => const AccountScreen(),

          // RecetaFormScreen: si recibe argumentos, entra en modo edición
          RecetaFormScreen.routeName: (ctx) {
            final receta = ModalRoute.of(ctx)!.settings.arguments as RecetaModel?;
            return RecetaFormScreen(receta: receta);
          },

          // RecetaDetalleScreen: muestra detalle y permite editar pasando la receta
          RecetaDetalleScreen.routeName: (ctx) {
            final receta = ModalRoute.of(ctx)!.settings.arguments as RecetaModel;
            return RecetaDetalleScreen(receta: receta);
          },
        },
      ),
    );
  }
}
