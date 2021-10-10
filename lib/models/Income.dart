import 'package:financial/blocs/Income.dart';

class IncomeModel {
  int? _id;
  late String _start_date, _end_date;
  late int _amount;

  IncomeModel(this._start_date, this._end_date, this._amount);

  int? get id => _id;

  String get start_date => _start_date;

  String get end_date => _end_date;

  int get amount => _amount;

  IncomeModel.map(dynamic obj) {
    this._id = obj['id'];
    this._start_date = obj['start_date'];
    this._end_date = obj['end_date'];
    this._amount = obj['amount'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['start_date'] = _start_date;
    map['end_date'] = _end_date;
    map['amount'] = _amount;
    return map;
  }

  IncomeModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._start_date = map['start_date'];
    this._end_date = map['end_date'];
    this._amount = map['amount'];
  }
}

final incomeBloc = IncomeBloc();
