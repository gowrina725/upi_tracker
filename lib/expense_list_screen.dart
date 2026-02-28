import 'package:flutter/material.dart';
import '../db/expense_db.dart';
import '../models/expense.dart';
import 'expense_entry_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  print("Started");
  const ExpenseListScreen({super.key});

  static const routeName = '/';

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late Future<List<Expense>> _future;

  @override
  void initState() {
    super.initState();
    _future = ExpenseDb.instance.getAllExpenses();
  }

  void _reload() {
    setState(() {
      _future = ExpenseDb.instance.getAllExpenses();
       print("Reload called");
    });
  }

  Future<void> _openEntry() async {
    final saved = await Navigator.pushNamed(
      context,
      ExpenseEntryScreen.routeName,
      arguments: const ExpenseEntryArgs(),
    );
    
    print("savegt");

    if (saved == true) _reload();
    else
    	print("niot true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UPI Expense Tracker')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openEntry,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No entries yet. Tap + to add.'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final e = items[i];
              final dt = DateTime.fromMillisecondsSinceEpoch(e.timestamp);
              return ListTile(
                title: Text('₹${e.amount.toStringAsFixed(2)} • ${e.category}'),
                subtitle: Text('${e.type} • ${dt.toLocal()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    if (e.id != null) {
                      await ExpenseDb.instance.deleteExpense(e.id!);
                      _reload();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
