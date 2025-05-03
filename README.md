# 📱 Receta App

**Receta App** es una aplicación multiplataforma desarrollada con Flutter que permite a los usuarios explorar, buscar, guardar y compartir recetas de cocina. Está diseñada para ser funcional tanto en dispositivos móviles como en la web.

---

## 🎯 Objetivo del Proyecto

Ofrecer una herramienta práctica, intuitiva y personalizable para la gestión de recetas, planificación de comidas, y comunidad culinaria.

---

## ✨ Funciones Principales

### 🍽️ Funciones Esenciales
- **Explorar recetas** por nombre, ingredientes, tipo de comida, dificultad, tiempo, dieta.
- **Vista detallada** con ingredientes ajustables, pasos, imágenes, valoraciones y nutrición.
- **Perfil de usuario** con favoritos, historial y preferencias alimenticias.
- **Gestión de ingredientes**: lista de compra, despensa y escaneo de códigos de barras.

### 🍳 Funciones Avanzadas
- **Modo cocina** manos libres con temporizadores y comandos.
- **Planner semanal** con sugerencias y lista automática de compras.
- **IA inteligente** para sugerencias basadas en ingredientes disponibles.
- **Subida de recetas** por usuarios con moderación.

### 🧠 Sociales y Gamificación
- Comunidad, foros, comentarios, retos de cocina.
- Logros, niveles y rankings.

### 🔗 Extras Técnicos
- Sincronización App/Web y almacenamiento en la nube.
- Integraciones con dispositivos inteligentes y asistentes de voz.

---

## 🛠️ Tecnologías

- **Flutter + Dart**
- **Provider** para gestión de estado
- **SQLite / SharedPreferences**
- **HTTP** para conexión API
- **Material 3** y **Google Fonts**

---

## 🗂️ Estructura del Proyecto

```bash
lib/
├── core/              → Temas, constantes, utilidades
├── data/              → Modelos, data sources, repositorios
├── domain/            → Entidades, repositorios, casos de uso
├── presentation/      → Pantallas, widgets, viewmodels
├── services/          → Autenticación, sincronización, etc.
└── main.dart
🚀 Cómo Ejecutar el Proyecto

flutter pub get
flutter run

Asegúrate de tener configurado tu entorno de desarrollo Flutter (puedes verificar con flutter doctor).

📌 Estado Actual
✅ Estructura inicial lista

🔜 Modelado de recetas y vista principal

🔜 Funcionalidades de usuario y listas

🔜 Planner, IA, comunidad y gamificación

✅ FASE 1.1 – MODELO DE RECETA FINAL
📁 Organización de archivos
Creamos los siguientes archivos:

lib/
├── domain/
│   └── entities/
│       └── receta.dart
├── data/
│   └── models/
│   │   └── receta_model.dart
│   └── datasources/
│       └── mock_recetas.drart

🧱 Resultado de la Fase 1.1
✅ Entidad de dominio separada
✅ Modelo serializable/deserializable preparado para red o base de datos
✅ Datos mock disponibles para testing y desarrollo local


✅ FASE 1.2 – VISTA PRINCIPAL: EXPLORACIÓN DE RECETAS
📌 Objetivo:
Crear una pantalla de inicio que muestre una lista de recetas mock usando ListView, conectada a un ViewModel con Provider. Esta es la base para la exploración de recetas.

🧩 1. Estructura de archivos para esta fase
vbnet
Copy
Edit
lib/
├── presentation/
│   ├── screens/
│   │   └── home_screen.dart
│   ├── viewmodels/
│   │   └── receta_viewmodel.dart
│   └── widgets/
│       └── receta_item.dart

🧪 5. Comprobación rápida
Asegúrate de tener este provider en main.dart:

ChangeNotifierProvider(create: (_) => RecetaViewModel()),
Y corre:

flutter pub get
flutter run

✅ Resultado
 Vista principal con listado funcional

 Integración con ViewModel

 Mock de recetas mostrado en UI

 Separación en widgets reutilizables

✅ FASE 1.3 – BÚSQUEDA Y FILTROS DE RECETAS
📌 Objetivo:
Agregar un campo de búsqueda y filtros simples al HomeScreen para refinar las recetas mostradas desde el ViewModel.

🧩 1. Estructura actualizada
Añadimos:

vbnet
Copy
Edit
lib/
├── presentation/
│   └── widgets/
│       ├── receta_item.dart
│       └── receta_filters.dart ✅ nuevo

✅ Resultado de la Fase 1.3
 Búsqueda en vivo por nombre o ingredientes

 Filtros por dieta y dificultad

 Filtro reactivo y escalable para futuro

✅ FASE 1.4 – VISTA DETALLADA DE RECETA
📌 Objetivo:
Mostrar al usuario los datos completos de una receta al tocarla desde el listado.

🧩 1. Estructura del proyecto
Añade:

lib/
└── presentation/
    └── screens/
        └── receta_detalle_screen.dart ✅
        
🧠 2. Navegación desde RecetaItem
Abre lib/presentation/widgets/receta_item.dart y modifica onTap:


onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RecetaDetalleScreen(receta: receta),
    ),
  );
},

✅ Resultado esperado
Al tocar una receta en la pantalla principal, se abre una nueva pantalla con:

Imagen grande

Ingredientes y pasos

Info nutricional, tiempo, dificultad

Autor, valoración, etiquetas

✅ FASE 1.5 – FAVORITOS E HISTORIAL DE USUARIO
📌 Objetivo:
Permitir que el usuario:

Guarde recetas como favoritas

Vea un historial de recetas vistas

Persista estos datos localmente con shared_preferences

✅ Resultado esperado
Al tocar una receta, se guarda automáticamente en el historial.

Puedes marcarla como favorita (❤) y persistirá entre sesiones.

Los datos están guardados localmente (usando SharedPreferences).

✅ FASE 1.6 – PANTALLA DE FAVORITOS E HISTORIAL
📌 Objetivo:
Mostrar al usuario dos nuevas pantallas:

🧡 Recetas favoritas

🕓 Historial de recetas vistas

Reutilizar los datos y widgets ya existentes (RecetaItem, RecetaViewModel, etc.)

🧩 1. Estructura de archivos
Agrega:

markdown
Copy
Edit
lib/
└── presentation/
    └── screens/
        ├── favoritos_screen.dart ✅
        └── historial_screen.dart ✅

✅ Resultado final de la fase
 Pantalla de favoritos 100% funcional

 Pantalla de historial funcional

 Persistencia local con shared_preferences

 Acceso desde cualquier parte de la app

✅ OBJETIVO: Añadir una clasificación y búsqueda por país es una mejora útil y coherente con la funcionalidad de exploración de recetas. Vamos a integrarla sin romper lo ya implementado.
Esto incluirá:

➕ Añadir el campo país en el modelo Receta

🗂️ Adaptar los mocks y datos

🌍 Agregar un nuevo filtro de país en la interfaz

🔍 Integrar la lógica de filtrado por país en el RecetaViewModel

🧩 PASO 1 – Ampliar el modelo Receta
📄 En receta.dart, agrega:
dart
Copy
Edit
final String pais; // Ej: 'España', 'Italia'
Y actualiza el constructor para incluirlo.

🧩 PASO 2 – Actualiza el modelo RecetaModel
En receta_model.dart, añade el campo pais:

En el constructor: required super.pais,

En fromJson: pais: json['pais'] as String,

En toJson: 'pais': pais,

🧩 PASO 3 – Agrega el campo a los datos mock
En mock_recetas.dart, por ejemplo:

pais: 'España',

Hazlo para cada receta que tengas.

🧠 PASO 4 – Ampliar el RecetaViewModel
1. Añadir campo de filtro:

String _pais = 'Todos';
String get pais => _pais;

void setPais(String pais) {
  _pais = pais;
  aplicarFiltros();
}

2. Añadir lógica en aplicarFiltros():

final coincidePais = _pais == 'Todos' || receta.pais == _pais;

return coincideBusqueda && coincideDieta && coincideDificultad && coincidePais;
🎛️ PASO 5 – Filtro en la interfaz
Abre receta_filters.dart y añade un nuevo DropdownButton para países. Por ejemplo:

Expanded(
  child: DropdownButton<String>(
    value: viewModel.pais,
    isExpanded: true,
    onChanged: (val) => viewModel.setPais(val!),
    items: const [
      DropdownMenuItem(value: 'Todos', child: Text('Todos los países')),
      DropdownMenuItem(value: 'España', child: Text('España')),
      DropdownMenuItem(value: 'Italia', child: Text('Italia')),
      DropdownMenuItem(value: 'México', child: Text('México')),
      DropdownMenuItem(value: 'Japón', child: Text('Japón')),
    ],
  ),
),

→ Colócalo arriba o junto a los filtros existentes, según tu diseño.

✅ Resultado final
Las recetas pueden clasificarse y buscarse por país
El campo se guarda en los datos y se filtra correctamente
Interfaz coherente y escalable (puedes usar un Dropdown dinámico en el futuro)