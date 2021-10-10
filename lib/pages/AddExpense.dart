import 'package:dropdown_search/dropdown_search.dart';
import 'package:financial/assets/Color.dart';
import 'package:financial/models/Expense.dart';
import 'package:financial/models/ExpenseType.dart';
import 'package:financial/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddExpsense extends StatefulWidget {
  var incomeId;

  AddExpsense({this.incomeId});

  @override
  _AddExpsenseState createState() => _AddExpsenseState();
}

class _AddExpsenseState extends State<AddExpsense> {
  //controller
  var ControllerAmount = new TextEditingController();
  var ControllerAddExpenseType = new TextEditingController();
  var ControllerDate = new TextEditingController();
  var ControllerDescription = new TextEditingController();

  bool requiredAmount = false, requiredDate = false,requiredExpenseType=false;

  DatabaseHelper db = new DatabaseHelper();

  String currencyFormat(String s) =>
      NumberFormat.decimalPattern("id").format(int.parse(s));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    expenseBloc.incomeId.sink.add(widget.incomeId.toString());
    expenseTypeBloc.fetchAllExpenseType();
  }

  Future<List<ExpenseTypeModel>> getData(filter) async {
    var data;
    await db.fetchExpenseType().then((item) async {
      data = item;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Add",
          textAlign: TextAlign.left,
          style: TextStyle(color: blackthin,fontFamily: "Playfair-reguler",fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: blackthin),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  //amount
                  Container(
                    width: Get.mediaQuery.size.width,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //amount
                        Container(
                          width: Get.mediaQuery.size.width,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: black, fontFamily: "Poppins-ExtraLight"),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, //
                                      color: lineColor),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 5, left: 5),
                                        child: Text(
                                          "IDR",
                                          style: TextStyle(
                                              color: black,
                                              fontFamily: "Poppins-ExtraLight"),
                                        )),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        width: double.maxFinite,
                                        child: TextFormField(
                                          controller: ControllerAmount,
                                          onChanged: (number) {
                                            if (number.isNotEmpty) {
                                              setState(() {
                                                requiredAmount = true;
                                              });
                                              expenseBloc.expenseAmount.sink.add(number
                                                  .toString()
                                                  .replaceAll(
                                                  new RegExp(r'[^\w\s]+'), ''));
                                              number =
                                              '${currencyFormat(number.replaceAll('.', ''))}';
                                              ControllerAmount.value =
                                                  TextEditingValue(
                                                    text: number,
                                                    selection: TextSelection.collapsed(
                                                        offset: number.length),
                                                  );
                                            } else {
                                              setState(() {
                                                requiredAmount = false;
                                              });
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none)),
                                          onSaved: (String? value) {},
                                          validator: (String? value) {
                                            return (value != null &&
                                                value.contains('@'))
                                                ? 'Do not use the @ char.'
                                                : null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              requiredAmount == false
                                  ? Container(
                                child: Text(
                                  "* required",
                                  style:
                                  TextStyle(color: redColor, fontSize: 12),
                                ),
                              )
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // //amount
                        // Container(
                        //   child: Text("Amount"),
                        // ),
                        // TextFormField(
                        //   controller: ControllerAmount,
                        //   decoration: const InputDecoration(
                        //     hintText: '0',
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   onChanged: (amount) {
                        //     print(amount);
                        //     expenseBloc.expenseAmount.sink.add(amount
                        //         .toString()
                        //         .replaceAll(new RegExp(r'[^\w\s]+'), ''));
                        //     amount =
                        //         '${currencyFormat(amount.replaceAll('.', ''))}';
                        //     ControllerAmount.value = TextEditingValue(
                        //       text: amount,
                        //       selection: TextSelection.collapsed(
                        //           offset: amount.length),
                        //     );
                        //   },
                        //   onSaved: (String? value) {},
                        //   validator: (String? value) {
                        //     return (value != null && value.contains('@'))
                        //         ? 'Do not use the @ char.'
                        //         : null;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),

                        //date
                        // Container(
                        //   child: Text("Date"),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     DatePicker.showDatePicker(context,
                        //         showTitleActions: true,
                        //         minTime: DateTime(2000, 3, 5),
                        //         maxTime: DateTime(2030, 6, 7),
                        //         theme: DatePickerTheme(
                        //             headerColor: Colors.orange,
                        //             backgroundColor: Colors.blue,
                        //             itemStyle: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 18),
                        //             doneStyle: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 16)), onChanged: (date) {
                        //       print('change $date in time zone ' +
                        //           date.timeZoneOffset.inHours.toString());
                        //     }, onConfirm: (date) {
                        //       ControllerDate.text = DateFormat.yMMMd()
                        //           .format(DateTime.parse("${date}"));
                        //       expenseBloc.dateExpense.sink.add(date.toString());
                        //       print('confirm $date');
                        //     },
                        //         currentTime: DateTime.now(),
                        //         locale: LocaleType.en);
                        //   },
                        //   child: TextFormField(
                        //     enabled: false,
                        //     controller: ControllerDate,
                        //     decoration: const InputDecoration(
                        //       hintText: 'dd/mm.yy',
                        //     ),
                        //     onSaved: (String? value) {},
                        //     validator: (String? value) {
                        //       return (value != null && value.contains('@'))
                        //           ? 'Do not use the @ char.'
                        //           : null;
                        //     },
                        //   ),
                        // ),
                        Column(
                          children: [
                            Container(
                              width: Get.mediaQuery.size.width,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: "Poppins-ExtraLight"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () async {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2000, 3, 5),
                                            maxTime: DateTime(2030, 6, 7),
                                            theme: DatePickerTheme(

                                                headerColor: blue,
                                                backgroundColor: whitethin,
                                                itemStyle: TextStyle(
                                                    color: blackthin,
                                                    fontFamily: "Poppins-ExtraLight",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)), onChanged: (date) {
                                              print('change $date in time zone ' +
                                                  date.timeZoneOffset.inHours.toString());
                                            }, onConfirm: (date) {
                                          setState(() {
                                            requiredDate=true;
                                          });
                                              ControllerDate.text = DateFormat.yMMMd()
                                                  .format(DateTime.parse("${date}"));
                                              expenseBloc.dateExpense.sink.add(date.toString());
                                              print('confirm $date');

                                            },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);


                                      },
                                      child: TextFormField(
                                        cursorColor: Theme.of(context).cursorColor,
                                        enabled: false,
                                        controller: ControllerDate,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.red)),

                                          ),
                                        ),
                                      ),
                                    ),

                                  requiredDate == false
                                      ? Container(
                                    child: Text(
                                      "* required",
                                      style: TextStyle(
                                          color: redColor, fontSize: 12),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //description
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            "Description",
                            style: TextStyle(
                              
                                color: black,
                                fontFamily: "Poppins-ExtraLight"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, //
                                color: lineColor),
                          ),
                          child: TextFormField(
                            controller: ControllerDescription,
                            onChanged: (value)=>expenseBloc.expenseDescription.sink.add(value),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (String? value) {},
                            validator: (String? value) {
                              return (value != null &&
                                  value.contains('@'))
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //description
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            "Expense Type",
                            style: TextStyle(
                                color: black,
                                fontFamily: "Poppins-ExtraLight"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: Get.mediaQuery.size.width - 100,
                                child: DropdownSearch<ExpenseTypeModel>(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  compareFn: (i, s) => i?.isEqual(s) ?? false,
                                  onChanged: (ExpenseTypeModel? data) {
                                    print(data!.id);
                                   setState(() {
                                   requiredExpenseType=true;
                                   });
                                    expenseBloc.expenseTypeId.sink.add("${data.id}");

                                  },


                                  onFind: (String? filter) => getData(filter),
                                  favoriteItemsAlignment:
                                      MainAxisAlignment.start,
                                  // favoriteItems: (items) {
                                  //   return items.toList();
                                  // },
                                  favoriteItemBuilder: (context, item) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[100]),
                                      child: Text(
                                        "1${item.id}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: Get.mediaQuery.size.width -
                                    (Get.mediaQuery.size.width - 70),
                                height: 50,
                                margin: EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    Alert(
                                        context: context,
                                        title: "Expense",
                                        content: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              onChanged: (name) {
                                                expenseTypeBloc.name.sink
                                                    .add(name);
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'jenis Expense',
                                              ),
                                            ),
                                          ],
                                        ),
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              try {
                                                Navigator.pop(context);
                                                expenseTypeBloc
                                                    .createExpenseType();
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ]).show();
                                    // showMaterialModalBottomSheet(
                                    //   context: context,
                                    //   builder: (context) => SingleChildScrollView(
                                    //     controller:
                                    //         ModalScrollController.of(context),
                                    //     child: Container(
                                    //       height: Get.mediaQuery.size.height / 4,
                                    //       child: Container(
                                    //         height:
                                    //             Get.mediaQuery.size.height / 4,
                                    //         margin: EdgeInsets.only(
                                    //             top: 10, left: 10, right: 10),
                                    //         child: Stack(
                                    //           children: <Widget>[
                                    //             Container(
                                    //               child: Text("jenis Expense"),
                                    //             ),
                                    //             Container(
                                    //               margin: EdgeInsets.only(top: 10),
                                    //               child: TextFormField(
                                    //                 decoration:
                                    //                     const InputDecoration(
                                    //                   hintText: '',
                                    //                 ),
                                    //                 onSaved: (String? value) {
                                    //
                                    //                 },
                                    //                 onChanged: expenseTypeBloc.getName,
                                    //                 validator: (String? value) {
                                    //                   return (value != null &&
                                    //                           value.contains('@'))
                                    //                       ? 'Do not use the @ char.'
                                    //                       : null;
                                    //                 },
                                    //               ),
                                    //             ),
                                    //             Positioned(
                                    //               bottom: 30,
                                    //               child: Container(
                                    //                 width:
                                    //                     Get.mediaQuery.size.width,
                                    //                 child: ElevatedButton(
                                    //                   child: Text("Save"),
                                    //                   onPressed: () {
                                    //
                                    //                   },
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        requiredExpenseType == false
                            ? Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            "* required",
                            style: TextStyle(
                                color: redColor, fontSize: 12),
                          ),
                        )
                            : Container(),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //date start
                ],
              ),
              Positioned(
                  width: Get.mediaQuery.size.width - 20,
                  height: 50,
                  left: 10,
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: () {
                     if ((requiredAmount!=false) && (requiredDate!=false) && (requiredExpenseType!=false)){
                       expenseBloc.createExpense(context);
                     }
                    },
                    child: const Text('Save'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
