import 'package:flutter/material.dart';
import 'course.dart';
import 'catalog.dart';
import 'theme.dart';

void main() => runApp(const FiningApp());

class FiningApp extends StatelessWidget {
  const FiningApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'FIning',
      debugShowCheckedModeBanner: false,
      theme: FiningTheme.light,
      home: const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('FIning'), actions: const [
          Padding(
              padding: EdgeInsets.all(16), child: Icon(Icons.school_outlined))
        ]),
        body: SafeArea(
            child: IndexedStack(index: tab, children: [
          ListView(padding: const EdgeInsets.all(20), children: [
            Text('Tu semestre empieza aquí',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text(
                'Facultad de Ingeniería · UNAM\nIngeniería en Computación'),
            const SizedBox(height: 20),
            Card(
                color: FiningTheme.red,
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_month,
                              color: Colors.white, size: 32),
                          const SizedBox(height: 16),
                          const Text('Planea una semana a tu medida',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              '${selected.length} materias en tu horario de demostración',
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 16),
                          FilledButton.tonal(
                              onPressed: () => setState(() => tab = 2),
                              child: const Text('Abrir mi horario')),
                        ]))),
            const SizedBox(height: 24),
            Text('Encuentra lo que necesitas',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final entry in [
              (
                Icons.menu_book_outlined,
                'Materias',
                'Explora el catálogo oficial del plan 2026',
                1
              ),
              (
                Icons.calendar_month_outlined,
                'Mi horario',
                'Organiza tus clases en una vista semanal',
                2
              ),
              (
                Icons.insights_outlined,
                'Avance académico',
                'Prueba el registro de materias aprobadas',
                3
              )
            ])
              Card(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                          backgroundColor: FiningTheme.paleRed,
                          foregroundColor: FiningTheme.red,
                          child: Icon(entry.$1)),
                      title: Text(entry.$2),
                      subtitle: Text(entry.$3),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => setState(() => tab = entry.$4))),
            const SizedBox(height: 20),
            const Text(
                'Proyecto estudiantil independiente. El catálogo es parcial; horario y avance usan datos de ejemplo.'),
          ]),
          const OfficialCatalog(),
          ListView(padding: const EdgeInsets.all(20), children: [
            Text('Mi horario',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const DemoNotice(),
            const SizedBox(height: 12),
            Text(
                '${selected.length} materias · ${selected.fold<int>(0, (sum, c) => sum + c.credits)} créditos de ejemplo'),
            const SizedBox(height: 16),
            if (selected.isEmpty)
              const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                      'Agrega un grupo de ejemplo para ver tus clases en la cuadrícula.')),
            WeeklySchedule(courses: selected),
            const SizedBox(height: 24),
            Text('Grupos de demostración',
                style: Theme.of(context).textTheme.titleLarge),
            for (final c in demoCourses)
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.name,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            Text(
                                'Grupo de ejemplo · ${c.credits} créditos ficticios'),
                            Text(c.schedule),
                            const SizedBox(height: 12),
                            FilledButton.tonal(
                                onPressed: () => toggle(c),
                                child: Text(
                                    '${selected.contains(c) ? 'Quitar' : 'Agregar'} ${c.name}')),
                          ]))),
          ]),
          ListView(padding: const EdgeInsets.all(20), children: [
            Text('Avance académico',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const DemoNotice(),
            const SizedBox(height: 16),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${approved.length} de ${demoCourses.length} aprobadas',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                              value: approved.length / demoCourses.length,
                              minHeight: 10),
                          const SizedBox(height: 12),
                          Text(
                              '${approved.fold<int>(0, (sum, c) => sum + c.credits)} créditos de ejemplo completados'),
                        ]))),
            const SizedBox(height: 16),
            const Text('Materias de ejemplo · toca para marcar o desmarcar'),
            for (final c in demoCourses)
              Card(
                  child: CheckboxListTile(
                      title: Text(c.name),
                      subtitle: Text(approved.contains(c)
                          ? 'Aprobada · ${c.credits} créditos ficticios'
                          : 'Pendiente · ${c.credits} créditos ficticios'),
                      value: approved.contains(c),
                      onChanged: (value) => setState(() {
                            if (value == true) {
                              approved.add(c);
                            } else {
                              approved.remove(c);
                            }
                          }))),
          ]),
        ])),
        bottomNavigationBar: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (value) => setState(() => tab = value),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: 'Inicio'),
              NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined), label: 'Materias'),
              NavigationDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Mi horario'),
              NavigationDestination(
                  icon: Icon(Icons.insights_outlined), label: 'Avance'),
            ]),
      );
}

class DemoNotice extends StatelessWidget {
  const DemoNotice({super.key});
  @override
  Widget build(BuildContext context) => const Card(
      color: FiningTheme.paleRed,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
              'DEMOSTRACIÓN · Datos ficticios. Tus cambios se conservan solo mientras la app está abierta.')));
}

class WeeklySchedule extends StatelessWidget {
  const WeeklySchedule({super.key, required this.courses});
  final Set<Course> courses;
  @override
  Widget build(BuildContext context) => Card(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
              width: 660,
              child: Column(children: [
                Row(children: [
                  for (final label in [
                    'Hora',
                    'Lun',
                    'Mar',
                    'Mié',
                    'Jue',
                    'Vie'
                  ])
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(label,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: FiningTheme.red))))
                ]),
                for (var hour = 7; hour < 19; hour++)
                  IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text('$hour:00'))),
                        for (var day = 0; day < 5; day++)
                          Expanded(
                              child: Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 60),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: FiningTheme.border,
                                          width: 0.5),
                                      color: courses.any((c) =>
                                              c.days.contains(day) &&
                                              hour >= c.hour &&
                                              hour < c.hour + 2)
                                          ? FiningTheme.paleRed
                                          : Colors.white),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (final c in courses.where((c) =>
                                            c.days.contains(day) &&
                                            hour >= c.hour &&
                                            hour < c.hour + 2))
                                          Text(
                                              hour == c.hour
                                                  ? '${c.name}\n${c.hour}:00–${c.hour + 2}:00'
                                                  : 'Continúa ${c.name}',
                                              style: const TextStyle(
                                                  color: FiningTheme.ink,
                                                  fontSize: 12)),
                                      ]))),
                      ])),
              ]))));
}
