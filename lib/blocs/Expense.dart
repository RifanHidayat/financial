import 'package:financial/assets/Color.dart';
import 'package:financial/models/Expense.dart';
import 'package:financial/models/Income.dart';
import 'package:financial/services/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ExpenseBloc {
  FToast? fToast;
  final Routes = RouteServices();
  final fetchExpense = PublishSubject<List<ExpenseModel>>();
  final expenseId = BehaviorSubject<String>();
  final expenseTypeId = BehaviorSubject<String>();
  final incomeId = BehaviorSubject<String>();
  final expenseAmount = BehaviorSubject<String>();
  final dateExpense = BehaviorSubject<String>();
  final expenseDescription = BehaviorSubject<String>();
  final expenseTotal = BehaviorSubject<String>();


  Observable<List<ExpenseModel>> get getFetchAllExpense => fetchExpense.stream;

  Function(String) get getExpenseId => expenseId.sink.add;

  Function(String) get getExpenseTypeId => expenseTypeId.sink.add;

  Function(String) get getIncomeId => incomeId.sink.add;

  Function(String) get getExpenseAmount => expenseAmount.sink.add;

  Function(String) get geDateExpense => dateExpense.sink.add;

  Function(String) get getDescription => expenseDescription.sink.add;

  Function(String) get getExpenseTotal => expenseTotal.sink.add;

  createExpense(BuildContext context) {
    print(expenseDescription.value);
    try {
      Routes.createExpense(ExpenseModel(
              int.parse(expenseTypeId.value),
              int.parse(incomeId.value),
              int.parse(expenseAmount.value),
              dateExpense.value,
              expenseDescription.value,
              'out'))
          .then((value) {
        print(value);
        showMessage(context, "Data has been saved", greenColor);
        fetchAllExpense();
        Navigator.pop(context);
        // fetchAllExpense();
      });
    } catch (e) {
      print(e);
      showMessage(context, e, redColor);
    }
  }

  updateExpense(BuildContext context) {
    print(incomeId.value);
    try {
      Routes.updateExpense(ExpenseModel.fromMap({
        'id': int.parse(expenseId.value),
        'income_id': int.parse(incomeId.value),
        'expense_type_id': int.parse(expenseTypeId.value),
        'date': dateExpense.value,
        'amount': int.parse(expenseAmount.value),
        'type': "out"
      })).then((value) {
        fetchAllExpense();
        showMessage(context, "Data has been saved", greenColor);
        Get.back();
      });
    } catch (e) {
      print('${e}');
      //showMessage(context, 'e', redColor);
    }
  }

  destroyExpense(
    BuildContext context,
  ) {
    try {
      Routes.destroyExpense(int.parse(expenseId.value)).then((value) {
        fetchAllExpense();

        showMessage(context, "Data has been deleted", greenColor);

        Get.back();
      });
    } catch (e) {
      showMessage(context, e, redColor);
      print(e);
    }
  }

  fetchAllExpense() async {
    List<ExpenseModel>? expense =
        await Routes.fetchAllexpense(incomeId.value.toString());
    fetchExpense.sink.add(expense);
    print(expense);
  }

  calculateExpense(id) async {
   return await Routes.expnseTotal(id.toString());
  }

  showMessage(BuildContext context, message, Color color) {
    fToast = FToast();
    fToast!.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: black,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: black, fontFamily: "Walkway-Oblique"),
          ),
        ],
      ),
    );
    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
