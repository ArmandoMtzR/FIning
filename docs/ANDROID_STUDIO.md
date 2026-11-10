# Compilar y emular con Android Studio

1. Abre C:\Users\harma\Escritorio\FIning como proyecto (la carpeta raíz).
2. Los plugins Flutter y Dart están instalados. Si solicita el SDK Flutter, usa C:\Users\harma\source\flutter.
3. En Device Manager inicia FIning_Pixel (Android 16 / API 36), o selecciónalo en la lista de dispositivos.
4. Selecciona la configuración FIning y pulsa Run. El punto de entrada es lib/main.dart.
5. Para APK: ejecuta flutter build apk --debug en la terminal. Salida: build/app/outputs/flutter-apk/app-debug.apk.

ANDROID_HOME apunta al SDK local y Flutter está agregado al PATH del usuario; reinicia terminales previas para recoger esas variables.

El dispositivo virtual se almacena en el perfil .android del usuario y el SDK en AppData/Local/Android/Sdk; no se suben a GitHub.
