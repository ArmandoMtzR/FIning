class Course {
  const Course(this.id, this.name, this.credits, this.days, this.hour);
  final String id, name;
  final int credits, hour;
  final List<int> days;
  bool overlaps(Course other) =>
      hour == other.hour && days.any(other.days.contains);
  String get schedule => '${days.map((d) => [
        'Lun',
        'Mar',
        'Mié',
        'Jue',
        'Vie'
      ][d]).join(' / ')} · $hour:00–${hour + 2}:00';
}

const demoCourses = [
  Course('demo-1', 'Programación', 8, [0, 2], 9),
  Course('demo-2', 'Álgebra', 8, [0, 2], 9),
  Course('demo-3', 'Cálculo', 8, [1, 3], 11),
  Course('demo-4', 'Computación', 6, [0, 4], 13),
];
