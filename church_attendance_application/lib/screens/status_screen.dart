import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:church_attendance_application/logic/attendance_service.dart';
import 'package:church_attendance_application/widgets/status_screen_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Status'),
      ),
      body: FutureBuilder<List<Student>>(
        future: ref.read(attendanceServiceProvider).getStudents('daytime'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final student = snapshot.data![index];
                return StatusScreenItem(
                  student: student,
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading students'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
