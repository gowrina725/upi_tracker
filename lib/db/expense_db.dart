import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';

class ExpenseDb {
  ExpenseDb._();
  static final ExpenseDb instance = ExpenseDb._();

  Database? _db;

  Future<Database> get db async {
    final existing = _db;
    if (existing != null) return existing;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'upi_expenses.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL NOT NULL,
            type TEXT NOT NULL,
            category TEXT NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');
      },
    );
    return _db!;
  }

  Future<int> insertExpense(Expense e) async {
    final database = await db;
    return database.insert('expenses', e.toMap());
  }

  Future<List<Expense>> getAllExpenses() async {
    final database = await db;
    final rows = await database.query('expenses', orderBy: 'timestamp DESC');
    return rows.map((r) => Expense.fromMap(r)).toList();
  }

  Future<int> deleteExpense(int id) async {
    final database = await db;
    return database.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
