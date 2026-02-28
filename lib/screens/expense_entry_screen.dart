import 'package:flutter/material.dart';
import '../db/expense_db.dart';
import '../models/expense.dart';

class ExpenseEntryArgs {
  final double? amount;
  final String? type; // "Expense" / "Income"
  const ExpenseEntryArgs({this.amount, this.type});
}

class ExpenseEntryScreen extends StatefulWidget {
  const ExpenseEntryScreen({super.key});

  static const routeName = '/entry';

  @override
  State<ExpenseEntryScreen> createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends State<ExpenseEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();

  String _type = 'Expense';
  String _category = 'Food';

  final _categories = const ['Food', 'Travel', 'Shopping', 'Bills', 'Other'];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ExpenseEntryArgs) {
      if (args.amount != null && _amountCtrl.text.isEmpty) {
        _amountCtrl.text = args.amount!.toStringAsFixed(2);
      }
      if (args.type != null) _type = args.type!;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountCtrl.text.trim());
    final e = Expense(
      amount: amount,
      type: _type,
      category: _category,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await ExpenseDb.instance.insertExpense(e);

    if (!mounted) return;
    Navigator.pop(context, true); // return "saved"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Expense', label: Text('Expense')),
                  ButtonSegment(value: 'Income', label: Text('Income')),
                ],
                selected: {_type},
                onSelectionChanged: (s) => setState(() => _type = s.first),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final t = (v ?? '').trim();
                  if (t.isEmpty) return 'Enter amount';
                  final n = double.tryParse(t);
                  if (n == null || n <= 0) return 'Enter valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? 'Other'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
