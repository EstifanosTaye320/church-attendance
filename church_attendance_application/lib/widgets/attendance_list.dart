import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:church_attendance_application/logic/attendance_service.dart';
import 'package:church_attendance_application/widgets/attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceList extends ConsumerWidget {
  final List<Student> students;
  final String caseType;

  const AttendanceList(
      {Key? key, required this.students, required this.caseType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return AttendanceItem(
          student: student,
          caseType: caseType,
          onToggleAttendance: () {
            ref
                .read(attendanceServiceProvider)
                .toggleAttendance(caseType, student.name);
          },
        );
      },
    );
  }
}
