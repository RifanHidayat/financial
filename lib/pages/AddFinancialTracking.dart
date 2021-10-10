import 'package:financial/assets/Color.dart';
import 'package:financial/blocs/Income.dart';
import 'package:financial/models/Income.dart';
import 'package:flutter/material.dart';
import 'package:future_button/future_button.dart';
import 'package:get/get.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

//import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class AddFinancialTracking extends StatefulWidget {
  @override
  _AddFinancialTrackingState createState() => _AddFinancialTrackingState();
}

class _AddFinancialTrackingState extends State<AddFinancialTracking> {
  var ControllerDate = new TextEditingController();
  var ControllerAmount = new TextEditingController();

  bool _search = true;
  bool requiredAmount = false, requiredDate = false;
  var firstDate, lastDate;

  String currencyFormat(String s) =>
      NumberFormat.decimalPattern("id").format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Create",
          textAlign: TextAlign.left,
          style: TextStyle(color: blackthin,fontFamily: "Playfair-reguler",fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: blackthin),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height - 50,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                      color: blue,
                      width: Get.mediaQuery.size.width,
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.info_outline,
                              color: whitethin,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Track your spending flow",
                              style: TextStyle(
                                  color: whitethin,
                                  fontFamily: "Poppins-ExtraLight"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //amount
                  Container(
                    width: Get.mediaQuery.size.width,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Income Amount",
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
                                        incomeBloc.incomeAmount.sink.add(number
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
                                  final List<DateTime> picked =
                                      await DateRangePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate: new DateTime.now(),
                                          initialLastDate: (new DateTime.now())
                                              .add(new Duration(days: 7)),
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(
                                              DateTime.now().year + 2));
                                  if (picked != null && picked.length == 2) {
                                    print(picked);
                                    incomeBloc.startDateIncome.sink
                                        .add(picked[0].toString());
                                    incomeBloc.endDateIncome.sink
                                        .add(picked[1].toString());
                                    // ControllerDate.text = picked[0].toString();
                                    // firstDate = DateFormat("dd/MM/yyyy")
                                    //     .format(DateTime.parse("${picked[0]}"));
                                    // lastDate = DateFormat("dd/MM/yyyy")
                                    //     .format(DateTime.parse("${picked[1]}"));
                                    var startDateFormat =
                                    DateFormat.yMMMd().format(DateTime.parse("${picked[0]}"));
                                    var endDateFormat = DateFormat.yMMMd().format(DateTime.parse("${picked[1]}"));

                                    ControllerDate.text =
                                        '${startDateFormat}-${endDateFormat}';

                                    setState(() {
                                      _search = true;
                                      requiredDate = true;
                                    });
                                  }
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
                                    suffixIcon: Container(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _search = true;
                                            ControllerDate.text = "";
                                          });
                                        },
                                        child: Icon(
                                          _search == true
                                              ? Icons.date_range
                                              : Icons.close,
                                        ),
                                      ),
                                    ),
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
                  )

                  // new MaterialButton(
                  //     color: Colors.deepOrangeAccent,
                  //     onPressed: () async {
                  //       final List<DateTime> picked = await DateRangePicker.showDatePicker(
                  //           context: context,
                  //           initialFirstDate: new DateTime.now(),
                  //           initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                  //           firstDate: new DateTime(2015),
                  //           lastDate: new DateTime(DateTime.now().year + 2)
                  //       );
                  //       if (picked != null && picked.length == 2) {
                  //         print(picked);
                  //       }
                  //     },
                  //     child: new Text("Pick date range")
                  // )
                  //date start
                ],
              ),
              Positioned(
                width: Get.mediaQuery.size.width - 20,
                height: 50,
                left: 10,
                bottom: 10,
                child: 
                RaisedButton(
                  color: blue,
                  child: Text('Save',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    if ((requiredAmount != false) && (requiredDate != false)) {
                      incomeBloc.createIncome(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> waitFor([int seconds = 2]) {
          incomeBloc.createIncome(context);
          return Future.delayed(Duration(seconds: seconds));
  }}
