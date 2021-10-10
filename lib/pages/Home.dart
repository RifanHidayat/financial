import 'dart:ui';

import 'package:financial/assets/Color.dart';
import 'package:financial/models/Expense.dart';
import 'package:financial/models/ExpenseType.dart';
import 'package:financial/models/Income.dart';
import 'package:financial/pages/DetailFinancialTracking.dart';
import 'package:financial/pages/EditFinancialTracking.dart';
import 'package:financial/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper db = new DatabaseHelper();
  var tempExpenseTotal = "";

  String currencyFormat(String s) =>
      NumberFormat.decimalPattern("id").format(int.parse(s));

  @override
  void initState() {
    // TODO: implement initState
    incomeBloc.fetchAllIncome();
    super.initState();
    //db.deleteIncome(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Financial",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: blackthin,
              fontFamily: "Playfair-reguler",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height,
          child: StreamBuilder(
            stream: incomeBloc.semuaDataBarang,
            builder: (context, AsyncSnapshot snapshot) {
              //print(AsyncSnapshot.waiting());

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (contex, i) {
                      var balance = 0;

                      return Listdata(
                          snapshot.data[i].id,
                          snapshot.data[i].start_date,
                          snapshot.data[i].end_date,
                          snapshot.data[i].amount,
                          balance);
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          // child: ListView.builder(
          //   itemCount: 2,
          //     itemBuilder: (context, index) {
          //   return Listdata();
          // }),
        ),
      ),
    );
  }

  Widget Listdata(var id, startDate, endDate, amount, out) {


    var startDateFormat =
        DateFormat.yMMMd().format(DateTime.parse("${startDate}"));
    var endDateFormat = DateFormat.yMMMd().format(DateTime.parse("${endDate}"));
    var amountCurrencyFormat =
        '${currencyFormat(amount.toString().replaceAll('.', ''))}';

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: DetailFinancialTracking(
                    incomeId: id,
                    startDateFormat: startDateFormat,
                    endDateFormat: endDateFormat,
                    amount: amount.toString(),
                  )));
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              width: Get.mediaQuery.size.width,
              height: 130,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.mediaQuery.size.width,
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            incomeBloc.incomeId.sink.add(id.toString());
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Delete",
                              desc: "Are you sure ?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: whitethin,
                                        fontSize: 20,
                                        fontFamily: "Walkway-UltraBold"),
                                  ),
                                  onPressed: () =>
                                      incomeBloc.destroyincome(context),
                                  color: redColor,
                                ),
                                DialogButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: blackthin,
                                        fontSize: 20,
                                        fontFamily: "Walkway-UltraBold"),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: greyColor,
                                )
                              ],
                            ).show();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: greyColor,
                            margin: EdgeInsets.all(2),
                            child: Icon(
                              Icons.restore_from_trash_outlined,
                              size: 20,
                              color: blackthin,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(EditFinancialTracking(
                              id: id,
                              startDate: startDate,
                              startDateFormat: startDateFormat,
                              endDate: endDate,
                              endDateFormat: endDateFormat,
                              amount: amount.toString(),
                              amountCurrencyFormat: amountCurrencyFormat,
                            ));
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: greyColor,
                            margin: EdgeInsets.all(2),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: blackthin,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: blackthin,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          "${startDateFormat} - ${endDateFormat}",
                          style: TextStyle(fontFamily: "Walkway-UltraBold"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          "IDR ${amount}",
                          style: TextStyle(
                              fontFamily: "Poppins-ExtraLight",
                              color: amount >= 0 ? greenColor : redColor),
                        ),
                      ),
                    ],
                  ),
                  amount < 0
                      ? Expanded(
                          child: Container(
                            width: Get.mediaQuery.size.width,
                            height: double.maxFinite,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: Get.mediaQuery.size.width,
                              height: 50,
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Container(
                                width: Get.mediaQuery.size.width,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(1),
                                      child: Icon(
                                        Icons.warning_amber_outlined,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "Over Budget",
                                        style: TextStyle(
                                            fontFamily: "Poppins-ExtraLight",
                                            color: blackthin),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculate(id) async {

    //dispose();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
