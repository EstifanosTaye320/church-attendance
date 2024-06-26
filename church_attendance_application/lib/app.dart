import 'package:church_attendance_application/screens/attendance_screen.dart';
import 'package:church_attendance_application/screens/home_screen.dart';
import 'package:church_attendance_application/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/attendance/:case',
            name: 'attendance',
            builder: (context, state) =>
                AttendanceScreen(caseType: state.params['case']!),
          ),
          GoRoute(
            path: '/status',
            name: 'status',
            builder: (context, state) => StatusScreen(),
          ),
        ],
      );
}
