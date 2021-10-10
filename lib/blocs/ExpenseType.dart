
import 'package:financial/models/ExpenseType.dart';

import 'package:financial/services/Routes.dart';
import 'package:rxdart/rxdart.dart';


class ExpenseTypeBloc {
  final Routes = RouteServices();
  final fetchExpenseType = PublishSubject<List<ExpenseTypeModel>>();
  final name = BehaviorSubject<String>();

  Observable<List<ExpenseTypeModel>> get getFetchAllExpenseType =>
      fetchExpenseType.stream;

  Function(String) get getName => name.sink.add;

  createExpenseType() {
    try {
      Routes.createExpenseType(ExpenseTypeModel(id: null,name:name.value)).then((value) {
       // fetchAllExpenseType();
        print("berhasil");
      });
    } catch (e) {
      print(e);
    }
  }

  fetchAllExpenseType() async {
    // List<ExpenseTypeModel>? expenseType = await Routes.fetchAllExpenseType();
    // fetchExpenseType.sink.add(expenseType);

  }
}
