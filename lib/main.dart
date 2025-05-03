import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'presentation/screens/main_navigation_screen.dart';
import 'presentation/viewmodels/receta_viewmodel.dart';

void main() {
  runApp(const RecetaApp());
}

class RecetaApp extends StatelessWidget {
  const RecetaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecetaViewModel()),
      ],
      child: MaterialApp(
        title: 'Recetas',
        theme: AppTheme.lightTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
