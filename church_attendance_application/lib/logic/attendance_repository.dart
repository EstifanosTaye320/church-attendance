import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository();
});

class AttendanceRepository {
  // File paths for CSV files
  Future<String> _getFilePath(String caseType) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${caseType}.csv';
  }

  // Load students from CSV
  Future<List<Student>> loadStudents(String caseType) async {
    try {
      final filePath = await _getFilePath(caseType);
      final file = File(filePath);
      final csvString = await file.readAsString();
      final csvList = const CsvToListConverter().convert(csvString);
      return csvList.map((row) => Student.fromMap(row)).toList();
    } catch (e) {
      // Handle errors (e.g., file not found)
      print('Error loading students: ${e.toString()}');
      return [];
    }
  }

  // Save students to CSV
  Future<void> saveStudents(String caseType, List<Student> students) async {
    try {
      final filePath = await _getFilePath(caseType);
      final file = File(filePath);
      final csvString = const ListToCsvConverter()
          .convert(students.map((student) => student.toMap()).toList());
      await file.writeAsString(csvString);
    } catch (e) {
      // Handle errors (e.g., file write errors)
      print('Error saving students: ${e.toString()}');
    }
  }
}
