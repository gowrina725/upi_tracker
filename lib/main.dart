import 'package:flutter/material.dart';
import 'screens/expense_entry_screen.dart';
import 'screens/expense_list_screen.dart';

void main() {
  runApp(const UpITrackerApp());
import 'package:permission_handler/permission_handler.dart';

void main() async {
  import 'package:permission_handler/permission_handler.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await requestSmsPermission();
    runApp(const MyApp());
  }

  Future<void> requestSmsPermission() async {
    PermissionStatus status = await Permission.sms.request();

    if (status.isGranted) {
      print("SMS Permission Granted");
    } else {
      print("SMS Permission Denied");
    }
  }
}

class UpITrackerApp extends StatelessWidget {
  const UpITrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPI Expense Tracker',
      theme: ThemeData(useMaterial3: true),
      routes: {
        ExpenseListScreen.routeName: (_) => const ExpenseListScreen(),
        ExpenseEntryScreen.routeName: (_) => const ExpenseEntryScreen(),
      },
      initialRoute: ExpenseListScreen.routeName,
    );
  }
}
