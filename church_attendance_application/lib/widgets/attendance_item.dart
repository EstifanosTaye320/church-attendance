import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final Student student;
  final String caseType;
  final VoidCallback onToggleAttendance;

  const AttendanceItem({
    Key? key,
    required this.student,
    required this.caseType,
    required this.onToggleAttendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: Checkbox(
        value: student.totalAttendance > 0,
        onChanged: (_) {
          onToggleAttendance();
        },
      ),
    );
  }
}
