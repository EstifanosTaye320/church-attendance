import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:flutter/material.dart';

class StatusScreenItem extends StatelessWidget {
  final Student student;

  const StatusScreenItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Attendance: ${student.totalAttendance}'),
          Text('Absence: ${student.totalAbsence}'),
        ],
      ),
    );
  }
}
