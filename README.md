📱 Receta App

Receta App es una aplicación multiplataforma desarrollada con Flutter que permite a los usuarios explorar, buscar, guardar y compartir recetas de cocina. Está diseñada para ser funcional tanto en dispositivos móviles como en la web.

🎯 Objetivo del Proyecto

Ofrecer una herramienta práctica, intuitiva y segura para la gestión de recetas, planificación de comidas, y comunidad culinaria.

✨ Funciones Principales

🍽️ Funciones Esenciales

Autenticación de usuarios: registro, inicio y cierre de sesión.

Explorar recetas: listado basado en un mock de recetas base, con filtros por nombre, ingredientes, tipo de comida, dificultad, tiempo, dieta y país.

CRUD de recetas de usuario: los usuarios autenticados pueden crear, editar y eliminar sus propias recetas; las recetas base (mock) permanecen inmutables.

Vista detallada de receta: descripción, ingredientes, pasos, imagen con manejo de errores (fallback), tiempo, dificultad y autor.

Favoritos e historial: marcar recetas como favoritas y registrar automáticamente las vistas; persistencia local con SharedPreferences.

Perfil de usuario: pantalla de cuenta con bienvenida y botón de cerrar sesión.

🍳 Funciones de Interfaz y Usabilidad

Formulario de recetas: creación y edición con validación de campos y selección de fecha de creación.

Manejo de imágenes: Image.network con errorBuilder para mostrar un icono cuando la URL falla.

Navegación: barra inferior con pestañas para Inicio, Favoritos, Historial y Cuenta.

🌍 Filtro por País

Se añadió el campo pais al modelo de receta y al mock.

Dropdown dinámico en los filtros para seleccionar un país y refinar el listado.

🛠️ Tecnologías y Paquetes

Flutter & Dart

Provider para gestión de estado

SharedPreferences para persistencia local

Material 3 para componentes UI

🗂️ Estructura del Proyecto
```
lib/
├── core/              → Temas, constantes y utilidades globales (`theme.dart` con `appTheme`).
├── data/
│   ├── datasources/   → `mock_recetas.dart`, `local_recetas.dart` (CRUD local).
│   └── models/        → `receta_model.dart` (serialización JSON).
├── domain/
│   └── entities/      → `receta.dart`, `user.dart`.
├── services/          → `auth_service.dart`, `local_storage_service.dart`.
├── presentation/
│   ├── viewmodels/    → `auth_viewmodel.dart`, `receta_viewmodel.dart`.
│   ├── screens/       →
│   │   • `main_navigation_screen.dart`
│   │   • `home_screen.dart` (+ filtros)
│   │   • `receta_detalle_screen.dart` 
│   │   • `receta_form_screen.dart` (crear/editar)
│   │   • `favoritos_screen.dart`
│   │   • `historial_screen.dart`
│   │   • `login_screen.dart`, `register_screen.dart`, `account_screen.dart`
│   └── widgets/       → `receta_item.dart`, `receta_filters.dart`.
└── main.dart          → Configuración de rutas y Providers.
```

🚀 Cómo Ejecutar el Proyecto

Clona el repositorio:
```
git clone [<tu-repo-url>](https://github.com/MSdelP/Recetas_app)
cd Receta_APP
```
Instala dependencias:

flutter pub get

Corre en dispositivo o emulador:
```
flutter clean
flutter pub get
flutter run
```
Nota: Ajusta en android/app/build.gradle.kts la propiedad ndkVersion si aparece un conflicto de NDK.

📱 Para lanzarlo en tu móvil

1. Habilita las Opciones de Desarrollador y USB Debugging
En tu móvil ve a Ajustes → Acerca del teléfono y pulsa “Número de compilación” 7 veces hasta que te diga “¡Eres desarrollador!”.

Vuelve a Ajustes y entra en Opciones de desarrollador (o “Programador”), activa Depuración USB.

Conecta el cable USB; en la notificación de “Cargando por USB” selecciona Transferencia de archivos (MTP) o directamente el modo Depuración USB si tu ROM lo ofrece.

2. Instala las herramientas ADB en Arch (ajusta el paquete a tu SO)
```
sudo pacman -Syu android-tools
```
Esto te proporcionará el comando adb.

3. Comprueba que adb vea tu dispositivo
En un terminal ejecuta:
```
adb start-server
adb devices
```
Deberías ver un listado con el serial de tu móvil y el estado device. Si aparece vacío o unauthorized, desbloquea la pantalla del móvil y acepta la clave RSA que te pide.

🛡️ Estado Actual y Próximos Pasos

✅ Fase 1 – Autenticación de usuarios

✅ Fase 2 – Persistencia local de recetas de usuario (CRUD)

✅ Fase 3 – UI de gestión de recetas y filtros avanzados (incluido país)

🔜 Fase 4 – Pruebas, pulido de diseño y mejoras de rendimiento

🔜 Integración con backend y sincronización en la nube

🔜 Funciones sociales: comentarios, retos y comunidad

¡Gracias por contribuir y disfruta cocinando con Receta App!
