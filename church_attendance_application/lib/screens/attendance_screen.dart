import 'package:church_attendance_application/data_models.dart/student.dart';
import 'package:church_attendance_application/logic/attendance_service.dart';
import 'package:church_attendance_application/widgets/attendance_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  final String caseType;

  const AttendanceScreen({Key? key, required this.caseType}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture =
        ref.read(attendanceServiceProvider).getStudents(widget.caseType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.caseType.toUpperCase()} Attendance'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Handle saving attendance data
              // Use ref.read(attendanceServiceProvider).updateAttendance()
              // Show snackbar for success or failure
              context.pop();
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: FutureBuilder<List<Student>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AttendanceList(
                students: snapshot.data!, caseType: widget.caseType);
          } else if (snapshot.hasError) {
            // Handle error display
            return const Center(child: Text('Error loading students'));
          } else {
            // Show loading indicator while fetching data
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
