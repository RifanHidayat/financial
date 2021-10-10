import 'package:expandable/expandable.dart';
import 'package:financial/assets/Color.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _switchValue = true;
  final List<String> changelog1 = <String>['Initial release', 'Base Features'];
     bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,

        title: Text(
          "Settings",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: blackthin,
              fontFamily: "Playfair-reguler",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //mode
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Mode",
                              style: TextStyle(fontFamily: "Walkway-UltraBold"),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Change your mode dark mode",
                              style: TextStyle(
                                  fontFamily: "Walkway-SemiBold", fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: double.maxFinite,
                        child: CupertinoSwitch(
                          value: _switchValue,
                          onChanged: (value) {
                            setState(() {
                              _switchValue = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "langguange",
                              style: TextStyle(fontFamily: "Walkway-UltraBold"),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Change your mode Indonesian languange",
                              style: TextStyle(
                                  fontFamily: "Walkway-SemiBold", fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child:  DayNightSwitcher(
                        isDarkModeEnabled: isDarkModeEnabled,
                        onStateChanged: onStateChanged,
                      ),
                    )
                  ],
                ),
              ),
              ExpandableNotifier(
                  child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Changelog",
                                style:
                                    TextStyle(fontFamily: "Walkway-UltraBold"),
                              ),
                            ),
                            Container(
                              child: Text(
                                "List Perubahan Aplikasi",
                                style: TextStyle(
                                    fontFamily: "Walkway-SemiBold",
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                      collapsed: Container(

                          child: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.mediaQuery.size.width / 2.5 - 10,
                                  child: Text(
                                    "22 November 2022",
                                    style: TextStyle(
                                        color: blue,
                                        fontFamily: "Poppins-Black"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(

                                    alignment: Alignment.centerRight,
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Row(
                                          children: [
                                            Text(
                                              "Alpha v0.0.1",
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-ExtraLight",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              color: redColor,

                                              child: Container(margin:EdgeInsets.all(5)
                                                  ,child: Text("NEW",style: TextStyle(fontFamily: "Walkway-UltraBold",color: Colors.white),)),
                                            ),
                                          ],
                                        )),
                                        Container(
                                            child: Text(
                                          "Initial",
                                          style: TextStyle(
                                              fontFamily: "Walkway-SemiBold"),
                                        )),
                                        Container(
                                            child: Text(
                                          "Base Features",
                                          style: TextStyle(
                                              fontFamily: "Walkway-SemiBold"),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(""),
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        );
                      },
                    ),
                  ),
                ],
              )),

              //languange

              //profile

              //change log
            ],
          ),
        ),
      ),
    );
  }
  /// Called when the state (day / night) has changed.
  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}
