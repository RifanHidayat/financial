import 'package:financial/assets/Color.dart';
import 'package:financial/models/Income.dart';
import 'package:financial/pages/Settings.dart';
import 'package:financial/services/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class IncomeBloc {
  late FToast fToast;
  final Routes = RouteServices();
  final fetchIncome = PublishSubject<List<IncomeModel>>();
  final incomeId = BehaviorSubject<String>();
  final incomeAmount = BehaviorSubject<String>();
  final startDateIncome = BehaviorSubject<String>();
  final endDateIncome = BehaviorSubject<String>();

  Observable<List<IncomeModel>> get semuaDataBarang => fetchIncome.stream;

  Function(String) get getIncomeId => incomeId.sink.add;

  Function(String) get getIncomeAmount => incomeAmount.sink.add;

  Function(String) get getStartDateIncome => startDateIncome.sink.add;

  Function(String) get getEndDateIncome => endDateIncome.sink.add;

  createIncome(BuildContext context) {
    try {
      Routes.createIncome(IncomeModel(startDateIncome.value,
              endDateIncome.value, int.parse(incomeAmount.value)))
          .then((value) {
        fetchAllIncome();
        showMessage(context, "Data has been saved", greenColor);
        Get.back();
      });
    } catch (e) {
      print(e);
      showMessage(context, e, redColor);
    }
  }

  updateIncome(BuildContext context) {
    print(incomeId.value);
    try {
      Routes.updateIncome(IncomeModel.fromMap({
        'id': int.parse(incomeId.value),
        'start_date': startDateIncome.value,
        'end_date': endDateIncome.value,
        'amount': int.parse(incomeAmount.value)
      })).then((value) {
        fetchAllIncome();
        showMessage(context, "Data has been saved", greenColor);
        Get.back();
      });
    } catch (e) {
      print('${e}');
      //showMessage(context, 'e', redColor);
    }
  }

  destroyincome(BuildContext context) {
    try {
      Routes.destroyIncome(int.parse(incomeId.value)).then((value) {
        fetchAllIncome();

        showMessage(context, "Data has been deleted", greenColor);

        Get.back();
      });
    } catch (e) {
      showMessage(context, e, redColor);
      print(e);
    }
  }

  fetchAllIncome() async {
    List<IncomeModel>? listBarang = await Routes.fetchAllIncome();
    fetchIncome.sink.add(listBarang);
    print(semuaDataBarang);
  }

  showMessage(BuildContext context, message, Color color) {
    fToast = FToast();
    fToast.init(context);
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
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
