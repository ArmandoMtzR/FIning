# FIning

Aplicación Flutter para estudiantes de Ingeniería en Computación de la Facultad de Ingeniería de la UNAM. Proyecto estudiantil independiente.

## Estado

- Materias: catálogo parcial oficial del plan 2026, generación 2027, con 37 asignaturas, créditos, búsqueda y fuentes por materia.
- Mi horario: demostración con materias ficticias, agenda por día y detección de empalmes.
- Avance: demostración con créditos ficticios. No representa el avance del plan oficial.
- Sin persistencia: las selecciones se pierden al cerrar.
- Proyectos nativos Android e iOS generados.

Fuentes y límites: [docs/FUENTES.md](docs/FUENTES.md).

## Desarrollo

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

SDK local en C:\Users\harma\source\flutter. Agrega su carpeta bin al PATH o invoca flutter.bat con ruta completa.

Android SDK instalado, pero flutter doctor reporta cmdline-tools faltantes y licencias sin verificar. Completar esa configuración antes de compilar un APK. iOS requiere macOS y Xcode.

## Siguiente entrega

Importación de grupos con semestre y fecha verificables; soporte de planes 2016/2023; persistencia local; avance oficial con optativas y requisitos modelados.
