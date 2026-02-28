import 'package:flutter/material.dart';
import 'screens/expense_entry_screen.dart';
import 'screens/expense_list_screen.dart';

void main() {
  runApp(const UpITrackerApp());
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
