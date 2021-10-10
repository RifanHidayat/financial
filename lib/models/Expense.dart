import 'package:financial/blocs/Expense.dart';

class ExpenseModel {
  int? _id, _expenseTypeId, _incomeId;
  int? _amount;
  String? _date, _description,_type;


  ExpenseModel(this._expenseTypeId, this._incomeId, this._amount, this._date,
      this._description,this._type);

  int? get id => _id;

  int? get expenseTypeId => _expenseTypeId;

  int? get incomeId => _incomeId;

  int? get amount => _amount;

  String? get date => _date;

  String? get description => _description;

  String? get type=>_type;

  ExpenseModel.map(dynamic obj) {
    this._id = obj['id'];
    this._amount = obj['amount'];
    this._expenseTypeId = obj['expense_type_id'];
    this._incomeId= obj['income_id'];
    this._date = obj['date'];
    this._description = obj['description'];
    this._type = obj['type'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['expense_type_id'] = _expenseTypeId;
    map['income_id'] = _incomeId;
    map['amount'] = _amount;
    map['date'] = _date;
    map['description'] = _description;
    map['type']=_type;

    return map;
  }

  ExpenseModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._expenseTypeId = map['expense_type_id'];
    this._incomeId = map['income_id'];
    this._amount = map['amount'];
    this._date = map['date'];
    this._description = map['description'];
    this._type=map['type'];
  }
}

final expenseBloc = ExpenseBloc();
