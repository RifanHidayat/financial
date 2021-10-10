

import 'package:financial/models/ExpenseType.dart';

import 'package:financial/models/Income.dart';
import 'package:financial/models/Expense.dart';
import 'package:financial/services/Database.dart';



class RouteServices{
  DatabaseHelper db = new DatabaseHelper();
  //income
  Future createIncome(IncomeModel) => db.createIncome(IncomeModel);
  Future updateIncome(IncomeModel) => db.updateIncome(IncomeModel);
  Future<List<IncomeModel>>? fetchAllIncome() => db.fetchIncome();
  Future destroyIncome(id)=>db.deleteIncome(id);
  Future expnseTotal(id)=>db.expenseTotal(id.toString());
  //expense
  Future createExpense(ExpenseModel)=>db.createExpense(ExpenseModel);
  Future<List<ExpenseModel>>? fetchAllexpense(var incomeId) => db.fetchExpense(incomeId.toString());
  Future updateExpense(ExpenseModel) => db.updateExpense(ExpenseModel);
  Future destroyExpense(id)=>db.deleteExpense(id);

  //expense Type
  Future createExpenseType(ExpenseTypeModel)=>db.createExpenseType(ExpenseTypeModel);
  Future<List<ExpenseTypeModel>>? fetchAllExpenseType() => db.fetchExpenseType();

}