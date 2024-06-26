import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:church_attendance_application/logic/attendance_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attendanceServiceProvider = Provider<AttendanceService>((ref) {
  return AttendanceService(
      attendanceRepository: ref.read(attendanceRepositoryProvider));
});

class AttendanceService {
  final AttendanceRepository _attendanceRepository;

  AttendanceService({required AttendanceRepository attendanceRepository})
      : _attendanceRepository = attendanceRepository;

  // Functions to read, update, and save attendance data
  Future<List<Student>> getStudents(String caseType) async {
    return await _attendanceRepository.loadStudents(caseType);
  }

  Future<void> updateAttendance(String caseType, List<Student> students) async {
    await _attendanceRepository.saveStudents(caseType, students);
  }

  // Example:
  Future<void> toggleAttendance(String caseType, String studentName) async {
    try {
      final students = await getStudents(caseType);
      final updatedStudents = students.map((student) {
        if (student.name == studentName) {
          return Student(
            name: student.name,
            totalAttendance:
                student.totalAttendance + (student.totalAbsence > 0 ? 1 : 0),
            totalAbsence:
                student.totalAbsence - (student.totalAbsence > 0 ? 1 : 0),
          );
        }
        return student;
      }).toList();
      await updateAttendance(caseType, updatedStudents);
      // You could add a snackbar here for success or failure
    } catch (e) {
      // Handle errors with snackbars or logs
      print('Error: ${e.toString()}');
    }
  }
}
