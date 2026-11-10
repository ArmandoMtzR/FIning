# Retomar FIning

## Objetivo y decisiones

Aplicación con un amigo para Android e iOS, empezando por Android. Público: Facultad de Ingeniería UNAM, Ingeniería en Computación. Repositorio: https://github.com/ArmandoMtzR/FIning.git
Ruta local: C:\Users\harma\Escritorio\FIning
Stack: Flutter. Paleta elegida por el usuario: blanco y rojo carmín. Referencia visual solicitada: https://ingenieriatracker.com/ y sus capturas; ver docs/DISENO.md y docs/referencias/ingenieriatracker.png.
Todos los documentos en docs/ dentro del proyecto; no crear archivos sueltos en el escritorio. Mantener GitHub actualizado. README en raíz como entrada.

## Estado al cerrar esta sesión

Último commit de implementación: 3e472cf (main, subido a origin). Incluye inicio con accesos, horario en cuadrícula semanal, resumen de avance y navegación de cuatro secciones. Previo: e4c8ef0 aplicó tema blanco/rojo; 6ed7bc0 configuró ejecución en Android Studio.

- lib/main.dart: inicio, navegación, horario semanal y avance demostrativo. Estado en memoria.
- lib/theme.dart: tokens y tema Material 3 blanco y rojo.
- lib/catalog.dart: catálogo oficial parcial y búsqueda, fuente por asignatura.
- lib/course.dart: cuatro materias ficticias y detección de empalmes (actualmente compara hora inicial y días; mejorar para intervalos generales antes de importar horarios).
- assets/data/computacion_2026.json: 37 asignaturas verificadas con créditos y fuentes. Plan 2026, generación 2027. No es todo el plan; no usar este subconjunto para avance oficial. Plan total declarado: 366 créditos.
- docs/FUENTES.md: fuentes, alcance y límites. No se importaron aún grupos, profesores, salones, seriaciones ni optativas reales.
- test/widget_test.dart: dos pruebas aprobadas (empalmes y búsqueda del catálogo).

Última validación: flutter analyze sin problemas; flutter test 2/2; flutter build apk --debug exitoso después del rediseño. APK en build/app/outputs/flutter-apk/app-debug.apk, ignorado por Git.
La última versión NO fue comprobada visualmente: el emulador se cerró durante la instalación. Versiones anteriores sí se instalaron y se confirmó MainActivity activa. No afirmar que el último rediseño ya se vio en dispositivo.

## Entorno listo

Flutter: C:\Users\harma\source\flutter\bin\flutter.bat (3.47.9). Agregado al PATH de usuario; terminales antiguas pueden requerir ruta completa.
Android Studio: C:\Program Files\Android\Android Studio\bin\studio64.exe. Plugins Flutter y Dart instalados.
SDK: C:\Users\harma\AppData\Local\Android\Sdk. ANDROID_HOME configurado. SDK platform/build-tools 36, licencias aceptadas. Java incluido con Android Studio detectado por Flutter.
Emulador actualizado. AVD: FIning_Pixel, Android 16/API 36, google_apis x86_64. Usa GPU software y WHPX; no deshabilitar Hyper-V. Imagen antigua API35 incompleta; no usarla. avdmanager emitió avisos sobre devices.xml, pero se creó el AVD y se arrancó correctamente.
Configuración de ejecución compartida: .run/FIning.run.xml. Archivos .idea y fining.iml locales ignorados. Abrir raíz del proyecto en Android Studio.

## Próximos pasos en orden

1. Iniciar FIning_Pixel desde Device Manager. Esperar sys.boot_completed=1 antes de instalar.
2. Ejecutar configuración FIning o instalar el APK y abrir com.fining.fining/.MainActivity.
3. Revisar visualmente inicio, catálogo, horario vacío y con materias, bloqueo de empalmes, avance; comprobar pantalla estrecha, paisaje y texto ampliado. La cuadrícula usa desplazamiento horizontal.
4. Corregir cualquier problema observado y añadir prueba de integración de selección/empalmes tras cambio de navegación si es necesario.
5. Implementar persistencia local; luego importar grupos reales con semestre y fecha de consulta. Acordar planes 2016/2023/2026 antes de ampliar avance oficial. No mezclar créditos ficticios con catálogo real.

## Comandos

```powershell
C:\Users\harma\source\flutter\bin\flutter.bat analyze
C:\Users\harma\source\flutter\bin\flutter.bat test
C:\Users\harma\source\flutter\bin\flutter.bat build apk --debug
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" shell getprop sys.boot_completed
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" install -r build\app\outputs\flutter-apk\app-debug.apk
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" shell am start -n com.fining.fining/.MainActivity
```

## Instrucciones de trabajo del usuario

Usar gstack /browse para navegación web. No usar claude-in-chrome. OMEGA no estuvo disponible entre las herramientas; el contexto se conserva aquí. No se usaron subagentes. Revisar instrucciones AGENTS del próximo chat y git status antes de modificar archivos.
