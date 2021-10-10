import 'package:expandable/expandable.dart';
import 'package:financial/assets/Color.dart';
import 'package:financial/models/Expense.dart';
import 'package:financial/pages/AddExpense.dart';
import 'package:financial/pages/EditExpense.dart';
import 'package:financial/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailFinancialTracking extends StatefulWidget {
  var incomeId, startDateFormat, endDateFormat, amount;

  DetailFinancialTracking(
      {this.incomeId, this.startDateFormat, this.endDateFormat, this.amount});

  @override
  _DetailFinancialTrackingState createState() =>
      _DetailFinancialTrackingState();
}

class _DetailFinancialTrackingState extends State<DetailFinancialTracking> {
  var balance, balanceFormat, totalIn, totalInFormat, totalOut, totalOutFormat;
  bool _visible = true, _loading = true;
  List<ExpenseModel> expenseTypeModel = [];

  String currencyFormat(String s) =>
      NumberFormat.decimalPattern("id").format(int.parse(s));

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
    "Ioni": 2,
  };
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.blueGrey,
  ];

  @override
  void initState() {
    super.initState();
    expenseBloc.incomeId.sink.add(widget.incomeId.toString());
    expenseBloc.fetchAllExpense();
    totalInFormat =
        '${currencyFormat(widget.amount.toString().replaceAll('.', ''))}';
    totalIn = int.parse(widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: AddExpsense(
                    incomeId: widget.incomeId,
                  )));
        },
        icon: Icon(Icons.add),
        label: Text("Expense"),
      ),
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Detail",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: blackthin,
              fontFamily: "Playfair-reguler",
              fontWeight: FontWeight.bold),
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
          height: Get.mediaQuery.size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Output flow from date",
                  style: TextStyle(fontFamily: "Poppins-Black", fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "${widget.startDateFormat} - ${widget.endDateFormat}",
                  style: TextStyle(fontFamily: "Walkway-UltraBold"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //card for remaining dan starting budget
                    Container(
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: Get.mediaQuery.size.width / 3 - 20,
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Total In",
                                            style: TextStyle(
                                                color: blackthin,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    "Poppins-ExtraLight"),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "${totalInFormat} ",
                                            // "IDR ${_transaction['data']['total_in'] - _transaction['data']['total_out']}",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontFamily:
                                                    "Walkway-UltraBold"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: VerticalDivider(
                                        color: Colors.black38,
                                      )),
                                  //Container
                                  Container(
                                    width: Get.mediaQuery.size.width / 3 - 20,
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Total Out",
                                            style: TextStyle(
                                                color: blackthin,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    "Poppins-ExtraLight"),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "${totalOutFormat}",
                                            // "IDR ${_transaction['data']['total_in'] - _transaction['data']['total_out']}",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontFamily:
                                                    "Walkway-UltraBold"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: VerticalDivider(
                                        color: Colors.black38,
                                      )),

                                  //Container
                                  Expanded(
                                    child: Container(
                                      width: Get.mediaQuery.size.width / 3 - 20,
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Balance",
                                              style: TextStyle(
                                                  color: blackthin,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      "Poppins-ExtraLight"),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "${balanceFormat}",
                                              // "IDR ${_transaction['data']['total_in'] - _transaction['data']['total_out']}",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontFamily:
                                                      "Walkway-UltraBold"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 10,
                              thickness: 1,
                            ),
                            ExpandableNotifier(
                                child: Column(
                              children: <Widget>[
                                ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: false,
                                  child: ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      tapBodyToCollapse: true,
                                    ),
                                    header: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        "Expense Category",
                                        style: TextStyle(
                                            fontFamily:
                                                "Poppins-ExtraLightItalic"),
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: PieChart(
                                            dataMap: dataMap,
                                            animationDuration:
                                                Duration(milliseconds: 800),
                                            chartLegendSpacing: 32,
                                            chartRadius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2,
                                            colorList: colorList,
                                            initialAngleInDegree: 0,
                                            chartType: ChartType.ring,
                                            ringStrokeWidth: 32,
                                            centerText: "HYBRID",
                                            legendOptions: LegendOptions(
                                              showLegendsInRow: true,
                                              legendPosition:
                                                  LegendPosition.bottom,
                                              showLegends: true,
                                              legendShape: BoxShape.circle,
                                              legendTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            chartValuesOptions:
                                                ChartValuesOptions(
                                              showChartValueBackground: true,
                                              showChartValues: true,
                                              showChartValuesInPercentage: false,
                                              showChartValuesOutside: false,
                                              decimalPlaces: 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: Expandable(
                                          collapsed: collapsed,
                                          expanded: expanded,
                                          theme: const ExpandableThemeData(
                                              crossFadePoint: 0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                            // Row(
                            //   children: [
                            //     Container(
                            //       margin: EdgeInsets.only(
                            //           top: 10, bottom: 10, left: 10, right: 10),
                            //       child: Text(
                            //         "Expense Category",
                            //         style: TextStyle(
                            //             fontFamily: "Poppins-ExtraLightItalic"),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Container(
                            //         width: double.maxFinite,
                            //         alignment: Alignment.centerRight,
                            //         child: Icon(
                            //           Icons.arrow_back_ios,
                            //           color: blackthin,
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: Get.mediaQuery.size.width,
                      height: Get.mediaQuery.size.height / 2,

                      child: StreamBuilder(
                        stream: expenseBloc.fetchExpense,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            expenseTypeModel = snapshot.data;

                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              setState(() {
                                var sum = snapshot.data.fold(0,
                                    (value, element) => value + element.amount);
                                totalOut = sum;
                                totalOutFormat =
                                    '${currencyFormat(sum.toString().replaceAll('.', ''))}';

                                balance = totalIn - totalOut;
                                balanceFormat =
                                    '${currencyFormat(balance.toString().replaceAll('.', ''))}';
                              });
                            });
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (contex, i) {
                                  return ListExpense(i);
                                });
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      // ListView.builder(
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) {
                      //       return ListExpense();
                      //     }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListExpense(i) {
    var date = DateFormat.yMMMd()
        .format(DateTime.parse("${expenseTypeModel[i].date}"));
    var amountCurrencyFormat =
        '${currencyFormat(expenseTypeModel[i].amount.toString().replaceAll('.', ''))}';
    return Card(
      child: Container(
        width: Get.mediaQuery.size.width,
        height: 150,
        color: Colors.white,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Get.mediaQuery.size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        expenseBloc.expenseId.sink
                            .add(expenseTypeModel[i].id.toString());
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
                                  expenseBloc.destroyExpense(context),
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
                        Get.to(EditExpsense(
                          incomeId: widget.incomeId.toString(),
                          expnseTypeId:
                              expenseTypeModel[i].expenseTypeId.toString(),
                          id: expenseTypeModel[i].id.toString(),
                          amount: expenseTypeModel[i].amount.toString(),
                          amountCurrencyFormat: amountCurrencyFormat,
                          date: expenseTypeModel[i].date,
                          dateFormat: date,
                          description: expenseTypeModel[i].description,
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
              Container(
                child: Row(
                  children: [
                    Container(
                        child: Text(
                      "${date}",
                      style: TextStyle(fontFamily: "Walkway-UltraBold"),
                    )),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: double.maxFinite,
                          child: Text(
                            "Jenis Expense",
                            style: TextStyle(fontFamily: "Poppins-ExtraLight"),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  "IDR  ${amountCurrencyFormat}",
                  style: TextStyle(
                      fontFamily: "Walkway-UltraBold", color: redColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "${expenseTypeModel[i].description != null ? expenseTypeModel[i].description : ""}",
                  style: TextStyle(fontFamily: "Walkway-SemiBold"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
