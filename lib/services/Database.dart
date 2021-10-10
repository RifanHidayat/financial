import 'package:financial/models/Expense.dart';
import 'package:financial/models/ExpenseType.dart';
import 'package:financial/models/Income.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'f11aa.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int NewViersion) async {
    await db.execute(
        'CREATE TABLE income (id INTEGER PRIMARY KEY AUTOINCREMENT,start_date TEXT,end_date TEXT,amount INTEGER)');
    await db.execute(
        'CREATE TABLE expense_type (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)');

    await db.execute(
        'CREATE TABLE expense (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,type TEXT,description TEXT,amount INTEGER,income_id INTEGER,expense_type_id INTEGER'
        ',FOREIGN KEY (income_id) REFERENCES income (id) , FOREIGN KEY (expense_type_id) REFERENCES expense_type (id) )');
  }

  //income
  Future<int> createIncome(IncomeModel incomeModel) async {
    var dbClient = await db;
    var result = await dbClient!.insert("income", incomeModel.toMap());
    return result;
  }

  Future<int> updateIncome(IncomeModel incomeModel) async {
    var dbClient = await db;
    return await dbClient!.update("income", incomeModel.toMap(),
        where: "id = ?", whereArgs: [incomeModel.id]);
  }

  Future<List<IncomeModel>> fetchIncome() async {
    var dbClient = await db;
    List<IncomeModel> incomeModel = [];
    var result = await dbClient!.query(
      "income",
      columns: [
        'id',
        "start_date",
        "end_date",
        "amount",
      ],
    );
    result.forEach((element) {
      incomeModel.add(IncomeModel.fromMap(element));
      // print(element);
    });
    print(result);

    return incomeModel;
  }

  Future<int> deleteIncome(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("income", where: "id = ?", whereArgs: [id]);
  }

  //expense
  Future<int> createExpense(ExpenseModel expenseModel) async {
    var dbClient = await db;
    var result = await dbClient!.insert("expense", expenseModel.toMap());
    return result;
  }

  Future<int> updateExpense(ExpenseModel expenseModel) async {
    var dbClient = await db;
    return await dbClient!.update("expense", expenseModel.toMap(),
        where: "id = ?", whereArgs: [expenseModel.id]);
  }

  Future<int> deleteExpense(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("expense", where: "id = ?", whereArgs: [id]);
  }

  Future<List<ExpenseModel>> fetchExpense(var incomeId) async {
    var dbClient = await db;
    List<ExpenseModel> expensemodel = [];

    var result = await dbClient!.query(
      "expense",
      columns: ['id', "date", "type", "amount","description", "income_id", "expense_type_id"],
      where: "income_id=${incomeId}",
    );

    result.forEach((element) {
      expensemodel.add(ExpenseModel.fromMap(element));
      // print(element);
    });

    return expensemodel;
  }

  Future<List> expenseTotal(var incomeId) async{
    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT SUM(amount) as amount FROM expense where income_id=${incomeId}");
    //print("${result[0]['amount']}");

    return result;
  }

  //expense Type
  Future<int> createExpenseType(ExpenseTypeModel expenseTypeModel) async {
    var dbClient = await db;
    var result =
        await dbClient!.insert("expense_type", expenseTypeModel.toMap());
    return result;
  }

  Future<List<ExpenseTypeModel>> fetchExpenseType() async {
    var dbClient = await db;

    var result = await dbClient!.query(
      "expense_type",
      columns: [
        'id',
        "name",
      ],
    );

    var data = ExpenseTypeModel.fromJsonList(result);
    return data;
  }
}
