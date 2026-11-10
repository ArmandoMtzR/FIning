import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OfficialCatalog extends StatefulWidget {
  const OfficialCatalog({super.key});
  @override
  State<OfficialCatalog> createState() => _OfficialCatalogState();
}

class _OfficialCatalogState extends State<OfficialCatalog> {
  late final Future<Map<String, dynamic>> catalog = rootBundle
      .loadString('assets/data/computacion_2026.json')
      .then((s) => jsonDecode(s) as Map<String, dynamic>);
  String query = '';
  @override
  Widget build(BuildContext context) => FutureBuilder<Map<String, dynamic>>(
        future: catalog,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Center(
                child: Text(
                    'No se pudo cargar el catálogo local. Reinicia la aplicación.'));
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final data = snapshot.requireData;
          final courses = (data['courses'] as List).where((c) =>
              (c['name'] as String)
                  .toLowerCase()
                  .contains(query.toLowerCase()));
          return ListView(padding: const EdgeInsets.all(20), children: [
            Text('Explora tu carrera',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text(
                'Ingeniería en Computación · Plan 2026 · Generación 2027'),
            const SizedBox(height: 16),
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                        'Catálogo parcial verificado: asignaturas con créditos visibles en el mapa oficial. No incluye bloques de temas selectos ni optativas. Horarios de demostración disponibles en Mi horario.'))),
            const SizedBox(height: 16),
            TextField(
                decoration: const InputDecoration(
                    labelText: 'Buscar asignatura oficial',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()),
                onChanged: (s) => setState(() => query = s)),
            const SizedBox(height: 16),
            if (courses.isEmpty)
              const Text('No hay coincidencias en este catálogo.'),
            for (final c in courses)
              Card(
                  child: ListTile(
                      title: Text(c['name'] as String),
                      subtitle: Text('${c['credits']} créditos · Plan 2026'),
                      onTap: () => showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text(c['name'] as String),
                                  content: SingleChildScrollView(
                                      child: SelectableText(
                                          'Fuente: Facultad de Ingeniería, UNAM\n${c['url']}\n\nConsulta: 9 de noviembre de 2026. Grupos y horarios todavía no importados.')),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cerrar'))
                                  ])))),
            const SizedBox(height: 16),
            SelectableText(
                'Fuente: Facultad de Ingeniería, UNAM\n${data['source']}\nConsulta: 9 de noviembre de 2026. Proyecto estudiantil independiente.'),
          ]);
        },
      );
}
