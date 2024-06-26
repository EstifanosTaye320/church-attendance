class Student {
  final String name;
  final int totalAttendance;
  final int totalAbsence;

  Student({
    required this.name,
    this.totalAttendance = 0,
    this.totalAbsence = 0,
  });

  // Optional: For mapping from CSV
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      totalAttendance: int.tryParse(map['totalAttendance']) ?? 0,
      totalAbsence: int.tryParse(map['totalAbsence']) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'totalAttendance': totalAttendance,
      'totalAbsence': totalAbsence,
    };
  }
}
