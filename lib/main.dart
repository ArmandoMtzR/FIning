import 'package:flutter/material.dart';
import 'course.dart';
import 'catalog.dart';

void main() => runApp(const FiningApp());

class FiningApp extends StatelessWidget {
  const FiningApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FIning',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff12345b)),
            scaffoldBackgroundColor: const Color(0xfff6f7fa)),
        home: const Home(),
      );
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;
  String query = '';
  final selected = <Course>{};
  final approved = <Course>{};
  void toggle(Course course) {
    if (selected.contains(course)) {
      setState(() => selected.remove(course));
      return;
    }
    final conflicts = selected.where(course.overlaps);
    if (conflicts.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Empalme con ${conflicts.first.name}. Elige otro grupo.')));
      return;
    }
    setState(() => selected.add(course));
  }

  @override
  Widget build(BuildContext context) {
    final courses = demoCourses
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()));
    return Scaffold(
      appBar: AppBar(title: const Text('FIning'), actions: const [
        Padding(padding: EdgeInsets.all(16), child: Icon(Icons.school_outlined))
      ]),
      body: tab == 0
          ? const OfficialCatalog()
          : SafeArea(
              child: ListView(padding: const EdgeInsets.all(20), children: [
              Text(
                  [
                    'Tu próximo semestre',
                    'Tu semana, en orden',
                    'Cada materia cuenta'
                  ][tab],
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text('Ingeniería en Computación · FI UNAM'),
              const SizedBox(height: 16),
              const Card(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                          'DEMOSTRACIÓN · Materias y horarios ficticios. Los cambios se conservan solo mientras la app está abierta.'))),
              const SizedBox(height: 20),
              if (tab == 0) ...[
                TextField(
                    decoration: const InputDecoration(
                        labelText: 'Buscar materia',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder()),
                    onChanged: (value) => setState(() => query = value)),
                const SizedBox(height: 16),
                if (courses.isEmpty)
                  const Text('No encontramos materias con ese nombre.'),
                for (final c in courses)
                  Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                Text(
                                    '${c.credits} créditos de ejemplo · Grupo demo'),
                                const SizedBox(height: 8),
                                Text(c.schedule),
                                const SizedBox(height: 12),
                                FilledButton.tonal(
                                    onPressed: () => toggle(c),
                                    child: Text(selected.contains(c)
                                        ? 'Quitar del horario'
                                        : 'Agregar al horario')),
                              ]))),
              ],
              if (tab == 1) ...[
                for (final c in demoCourses)
                  FilledButton.tonal(
                      onPressed: () => toggle(c),
                      child: Text(
                          '${selected.contains(c) ? 'Quitar' : 'Agregar'} ${c.name} (demo)')),
                Text('${selected.length} materias seleccionadas'),
                if (selected.isEmpty)
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                          'Tu horario empieza aquí. Agrega una materia desde Materias.')),
                for (var day = 0; day < 5; day++) ...[
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                          [
                            'Lunes',
                            'Martes',
                            'Miércoles',
                            'Jueves',
                            'Viernes'
                          ][day],
                          style: Theme.of(context).textTheme.titleMedium)),
                  for (final c
                      in (selected.where((c) => c.days.contains(day)).toList()
                        ..sort((a, b) => a.hour.compareTo(b.hour))))
                    Card(
                        child: ListTile(
                            title: Text(c.name),
                            subtitle: Text('${c.hour}:00–${c.hour + 2}:00'),
                            trailing: IconButton(
                                tooltip: 'Quitar ${c.name}',
                                icon: const Icon(Icons.close),
                                onPressed: () => toggle(c)))),
                ],
              ],
              if (tab == 2) ...[
                Text(
                    '${approved.length} de ${demoCourses.length} materias de ejemplo aprobadas',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                    value: approved.length / demoCourses.length, minHeight: 8),
                const SizedBox(height: 12),
                Text(
                    '${approved.fold<int>(0, (sum, c) => sum + c.credits)} créditos de ejemplo completados'),
                const SizedBox(height: 16),
                for (final c in demoCourses)
                  CheckboxListTile(
                      title: Text(c.name),
                      subtitle: Text('${c.credits} créditos de ejemplo'),
                      value: approved.contains(c),
                      onChanged: (value) => setState(() {
                            if (value == true) {
                              approved.add(c);
                            } else {
                              approved.remove(c);
                            }
                          })),
              ],
            ])),
      bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (value) => setState(() => tab = value),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined), label: 'Materias'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined), label: 'Mi horario'),
            NavigationDestination(
                icon: Icon(Icons.insights_outlined), label: 'Avance'),
          ]),
    );
  }
}
