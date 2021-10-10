import 'package:financial/blocs/ExpenseType.dart';

class ExpenseTypeModel {
  int? id;
  String name;


  ExpenseTypeModel( {required this.id,required this.name});

  int? get getId => id;

  String? get getName => name;

  // ExpenseTypeModel.map(dynamic obj) {
  //   this.id = obj['id'];
  //   this.name = obj['name'];
  // }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;

    return map;
  }

  // ExpenseTypeModel.fromMap(Map<String, dynamic> map) {
  //   this.id = map['id'];
  //   this.name = map['name'];
  //
  // }
  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTypeModel(id: json['id'],name: json['name']);
  }

  static List<ExpenseTypeModel> fromJsonList(List list) {

    return list.map((item) => ExpenseTypeModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }
  bool isEqual(ExpenseTypeModel? model) {
    return this.id == model?.id;
  }
  @override
  String toString() => name;

}
final expenseTypeBloc = ExpenseTypeBloc();
