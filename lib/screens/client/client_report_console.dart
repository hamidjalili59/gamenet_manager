import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/main.dart';
import 'package:gamenet_manager/models/hive_database.dart';
import 'package:gamenet_manager/screens/client/client_drawer_desktop.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamenet_manager/utils/helper_functions.dart';
import 'package:shamsi_date/shamsi_date.dart';

ValueNotifier<String> _startDate = ValueNotifier<String>('');
ValueNotifier<String> _endDate = ValueNotifier<String>('');
ValueNotifier<String> _selectedItemNOC = ValueNotifier<String>("0");
String pageNum = "0";
bool showDetails = false;
List timesList = List.empty(growable: true);
List currentMoneyList = List.empty(growable: true);

class DatePicker extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final AppController _appController = Get.put(AppController());
    _startDate = useState("choose_please".tr);
    _endDate = useState("choose_please".tr);
    var _noc = List.generate((_appController.titlemenuItems.length), (index) {
      if (index < _appController.titlemenuItems.length - 1) {
        return "${_appController.titlemenuItems[index + 1]}";
      } else {
        return "All";
      }
    });
    _selectedItemNOC = useState(_noc[int.parse(pageNum) - 1]);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white60;
      }
      return Colors.blueGrey.withOpacity(0.9);
    }

    return Obx(() {
      currentMoneyList = [];
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Main Body
          Container(
            width: 0.76.sw,
            height: 1.sh,
            child: Column(
              children: [
                SizedBox(height: 45),
                //header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 280, child: _buildDateSelection(context, "fromDate".tr, true)),
                    SizedBox(width: 280, child: _buildDateSelection(context, "toDate".tr, false)),
                    SizedBox(width: 10),
                    _buildCalculateButton(_appController, getColor),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 12),
                //select Button for choose Console
                Container(
                    padding: EdgeInsets.only(right: 30, left: 15),
                    decoration: BoxDecoration(color: Color(0xff3d4b6b), borderRadius: BorderRadius.circular(8)),
                    width: 0.7.sw,
                    height: 42,
                    child: DropdownButton<String>(
                      icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white30, size: 20),
                      value: _noc[int.parse(pageNum) - 1],
                      underline: Container(),
                      style: AppTheme.fontCreator(),
                      dropdownColor: Color(0xff3d4b6b),
                      isExpanded: true,
                      items: _noc.map((h) {
                        return DropdownMenuItem<String>(
                          value: h,
                          child: Text(
                            h,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? d) {
                        _appController.totalSum.value = 0;
                        _selectedItemNOC.value = d ?? _noc[int.parse(pageNum)];
                        if (_selectedItemNOC.value == _noc[0]) {
                          pageNum = "1";
                        } else if (_selectedItemNOC.value == _noc[1]) {
                          pageNum = "2";
                        } else if (_selectedItemNOC.value == _noc[2]) {
                          pageNum = "3";
                        } else if (_selectedItemNOC.value == _noc[3]) {
                          pageNum = "4";
                        } else if (_selectedItemNOC.value == _noc[4]) {
                          pageNum = "5";
                        } else if (_selectedItemNOC.value == _noc[5]) {
                          pageNum = "6";
                        } else if (_selectedItemNOC.value == _noc[6]) {
                          pageNum = "7";
                        } else if (_selectedItemNOC.value == _noc[7]) {
                          pageNum = "8";
                        } else if (_selectedItemNOC.value == _noc[8]) {
                          pageNum = "9";
                        } else if (_selectedItemNOC.value == _noc[9]) {
                          pageNum = "10";
                        } else if (_selectedItemNOC.value == _noc[10]) {
                          pageNum = "11";
                        } else if (_selectedItemNOC.value == _noc[11]) {
                          pageNum = "12";
                        } else if (_selectedItemNOC.value == _noc[12]) {
                          pageNum = "13";
                        } else if (_selectedItemNOC.value == _noc[13]) {
                          pageNum = "14";
                        } else if (_selectedItemNOC.value == _noc[14]) {
                          pageNum = "15";
                        } else if (_selectedItemNOC.value == _noc[15]) {
                          pageNum = "16";
                        } else if (_selectedItemNOC.value == _noc[16]) {
                          pageNum = "17";
                        } else if (_selectedItemNOC.value == _noc[17]) {
                          pageNum = "18";
                        } else if (_selectedItemNOC.value == _noc[18]) {
                          pageNum = "19";
                        } else if (_selectedItemNOC.value == _noc[19]) {
                          pageNum = "20";
                        } else if (_selectedItemNOC.value == _noc[20]) {
                          pageNum = "21";
                        }
                        showDetails = false;
                      },
                    )),
                SizedBox(height: 15),
                Container(
                  width: 0.7.sw,
                  height: 0.7.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xff2f2f50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                                  child: Text(_selectedItemNOC.value != "All" ? "date".tr : "date_consoleDate".tr,
                                      style: AppTheme.fontCreator(fontSize: 11), textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 16),
                                  child: Text("hour".tr, style: AppTheme.fontCreator(fontSize: 12)),
                                ),
                              ),
                            ),
                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                                  child: Text("received_money".tr, style: AppTheme.fontCreator(fontSize: 12)),
                                ),
                              ),
                            ),
                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                            Expanded(
                              flex: 6,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 50, child: Text("number".tr, style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                      SizedBox(width: 90, child: Text("cast".tr, style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                      SizedBox(width: 120, child: Text("items".tr, style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                                  child: Text("online".tr, style: AppTheme.fontCreator(fontSize: 12), textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                                  child: Text("number".tr, style: AppTheme.fontCreator(fontSize: 12), textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Footer page and ListViews
                      Container(width: 1.sw, height: 0.5, color: Colors.white),
                      Expanded(
                        child: SizedBox(
                          child: SingleChildScrollView(
                              child: SizedBox(
                            width: 1.sw,
                            height: 1.sh,
                            child: ListView.builder(
                                cacheExtent: 500000,
                                shrinkWrap: false,
                                itemCount: (box.length ?? 0),
                                itemBuilder: (context, index) {
                                  final _databaseContact = box.getAt(index) as HiveDatabase;
                                  if (_selectedItemNOC.value != "All") {
                                    if (_databaseContact.consoleName == _appController.titlemenuItems[int.parse(pageNum)]) {
                                      if (_appController.isFiltered.isFalse) {
                                        var consoleDate =
                                            Gregorian(_databaseContact.date.year, _databaseContact.date.month, _databaseContact.date.day).toJalali();
                                        var totalTime = _databaseContact.consoleData["totalTime"];
                                        var currentMoney = _databaseContact.consoleData["currentMoney"];
                                        var items = _databaseContact.consoleData["items"] ?? [];
                                        var isOnline = _databaseContact.consoleData["isOnline"];
                                        var playerLenght = _databaseContact.consoleData["playerLenght"];

                                        if (!currentMoneyList.contains(currentMoney)) {
                                          currentMoneyList.add(currentMoney);
                                        }
                                        return SizedBox(
                                          height: 65,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        height: 64.5,
                                                        child: Text(
                                                          consoleDate.year.toString() +
                                                              "/" +
                                                              consoleDate.month.toString() +
                                                              "/" +
                                                              consoleDate.day.toString() +
                                                              "\n" +
                                                              _databaseContact.date.hour.toString() +
                                                              ":" +
                                                              _databaseContact.date.minute.toString() +
                                                              ":" +
                                                              _databaseContact.date.second.toString(),

                                                          // _databaseContact.consoleName,
                                                          style: AppTheme.fontCreator(fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(width: 0.5, height: 1.sh, color: Colors.white),
                                              //second for time play in each Console
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 64.5,
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text(
                                                                (totalTime.toInt().round()) < 60
                                                                    ? (totalTime.toInt()).toString()
                                                                    : (totalTime.toInt() ~/ 60) > 60
                                                                        ? ((totalTime.toInt() / 60) ~/ 60).round().toString() +
                                                                            ":" +
                                                                            ((totalTime.toInt() / 60) % 60).round().toString()
                                                                        : (totalTime.toInt() / 60).round().toString(),
                                                                style: AppTheme.fontCreator(fontSize: 15),
                                                              ),
                                                              Text(
                                                                (totalTime.toInt().round()) < 60
                                                                    ? "sec".tr
                                                                    : (totalTime.toInt() ~/ 60) < 60
                                                                        ? "min".tr
                                                                        : "",
                                                                style: AppTheme.fontCreator(fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(width: 0.5, height: 1.sh, color: Colors.white),
                                              //third for total money each Console
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 64.5,
                                                        child: Center(
                                                          child: Text(
                                                            currentMoney.toInt().toString(),
                                                            style: AppTheme.fontCreator(fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(width: 0.5, height: 1.sh, color: Colors.white),
                                              Expanded(
                                                  flex: 6,
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 64.5,
                                                          child: (items.length ?? 0) < 1
                                                              ? Center(child: Text("empty".tr, style: AppTheme.fontCreator(fontSize: 12)))
                                                              : ListView.builder(
                                                                  cacheExtent: 500000,
                                                                  shrinkWrap: false,
                                                                  itemCount: items.length,
                                                                  itemBuilder: (context, index) {
                                                                    try {
                                                                      return Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: 50,
                                                                              child: Text(items[index]["itemCount"],
                                                                                  style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                          SizedBox(
                                                                              width: 90,
                                                                              child: Text(items[index]["itemPrice"].toString(),
                                                                                  style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                          SizedBox(
                                                                              width: 120,
                                                                              child: Text(items[index]["itemName"],
                                                                                  style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                        ],
                                                                      );
                                                                    } catch (e) {
                                                                      print(e.toString() + " report 1 ");
                                                                      return Container();
                                                                    }
                                                                  }),
                                                        ),
                                                        Container(width: 1.sw, height: 0.5, color: Colors.white),
                                                      ],
                                                    ),
                                                  )),
                                              Container(width: 0.5, height: 1.sh, color: Colors.white),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 64.5,
                                                        child: Center(
                                                            child: Icon(
                                                          isOnline ? Icons.check : Icons.close,
                                                          color: Colors.white,
                                                          size: 18,
                                                        )),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(width: 0.5, height: 1.sh, color: Colors.white),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 64.5,
                                                        child: Center(
                                                          child: Text(
                                                            playerLenght.toString(),
                                                            style: AppTheme.fontCreator(fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (_appController.isFiltered.isTrue) {
                                        var start = Jalali(
                                                int.parse(_startDate.value.substring(0, 4)),
                                                int.parse(_startDate.value.substring(5, _startDate.value.indexOf("/", 5))),
                                                int.parse(_startDate.value.substring(_startDate.value.indexOf("/", 5) + 1, _startDate.value.length)))
                                            .toGregorian();
                                        var end = Jalali(
                                                int.parse(_endDate.value.substring(0, 4)),
                                                int.parse(_endDate.value.substring(5, _endDate.value.indexOf("/", 5))),
                                                int.parse(_endDate.value.substring(_endDate.value.indexOf("/", 5) + 1, _endDate.value.length)))
                                            .toGregorian();
                                        if (_databaseContact.date.year >= start.year && _databaseContact.date.year <= end.year) {
                                          if (_databaseContact.date.month >= start.month && _databaseContact.date.month <= end.month) {
                                            if (_databaseContact.date.day >= start.day && _databaseContact.date.day <= end.day) {
                                              final _databaseContact = box.getAt(index) as HiveDatabase;
                                              var consoleDate =
                                                  Gregorian(_databaseContact.date.year, _databaseContact.date.month, _databaseContact.date.day)
                                                      .toJalali();
                                              var totalTime = _databaseContact.consoleData["totalTime"];
                                              var currentMoney = _databaseContact.consoleData["currentMoney"];
                                              var items = _databaseContact.consoleData["items"] ?? [];
                                              var isOnline = _databaseContact.consoleData["isOnline"];
                                              var playerLenght = _databaseContact.consoleData["playerLenght"];
                                              var name = _databaseContact.consoleName;
                                              if (!currentMoneyList.contains(currentMoney)) {
                                                currentMoneyList.add(currentMoney);
                                              }
                                              return SizedBox(
                                                height: 65,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment.center,
                                                              height: 64.5,
                                                              child: Text(
                                                                consoleDate.year.toString() +
                                                                    "/" +
                                                                    consoleDate.month.toString() +
                                                                    "/" +
                                                                    consoleDate.day.toString() +
                                                                    "\n" +
                                                                    _databaseContact.date.hour.toString() +
                                                                    ":" +
                                                                    _databaseContact.date.minute.toString() +
                                                                    ":" +
                                                                    _databaseContact.date.second.toString() +
                                                                    name,
                                                                style: AppTheme.fontCreator(fontSize: 15),
                                                              ),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                    //second for time play in each Console
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 64.5,
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      (totalTime.toInt().round()) < 60
                                                                          ? (totalTime.toInt()).toString()
                                                                          : (totalTime.toInt() ~/ 60) > 60
                                                                              ? ((totalTime.toInt() / 60) ~/ 60).round().toString() +
                                                                                  ":" +
                                                                                  ((totalTime.toInt() / 60) % 60).round().toString()
                                                                              : (totalTime.toInt() / 60).round().toString(),
                                                                      style: AppTheme.fontCreator(fontSize: 15),
                                                                    ),
                                                                    Text(
                                                                      (totalTime.toInt().round()) < 60
                                                                          ? "sec".tr
                                                                          : (totalTime.toInt() ~/ 60) < 60
                                                                              ? "min".tr
                                                                              : "",
                                                                      style: AppTheme.fontCreator(fontSize: 15),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                    //third for total money each Console
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 64.5,
                                                              child: Center(
                                                                child: Text(
                                                                  currentMoney.toInt().toString(),
                                                                  style: AppTheme.fontCreator(fontSize: 15),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                    Expanded(
                                                        flex: 6,
                                                        child: SizedBox(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 64.5,
                                                                child: items.length < 1
                                                                    ? Center(child: Text("empty".tr, style: AppTheme.fontCreator(fontSize: 12)))
                                                                    : ListView.builder(
                                                                        cacheExtent: 500000,
                                                                        shrinkWrap: false,
                                                                        itemCount: items.length,
                                                                        itemBuilder: (context, index) {
                                                                          return Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                  width: 50,
                                                                                  child: Text(items[index]["itemCount"],
                                                                                      style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                              SizedBox(
                                                                                  width: 90,
                                                                                  child: Text(items[index]["itemPrice"].toString(),
                                                                                      style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                              SizedBox(
                                                                                  width: 120,
                                                                                  child: Text(items[index]["itemName"],
                                                                                      style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ),
                                                              Container(width: 1.sw, height: 0.5, color: Colors.white),
                                                            ],
                                                          ),
                                                        )),
                                                    Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 64.5,
                                                              child: Center(
                                                                  child: Icon(
                                                                isOnline ? Icons.check : Icons.close,
                                                                color: Colors.white,
                                                                size: 18,
                                                              )),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 64.5,
                                                              child: Center(
                                                                child: Text(
                                                                  playerLenght.toString(),
                                                                  style: AppTheme.fontCreator(fontSize: 15),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    final _databaseContact = box.getAt(index) as HiveDatabase;
                                    if (_appController.isFiltered.isFalse) {
                                      var consoleDate =
                                          Gregorian(_databaseContact.date.year, _databaseContact.date.month, _databaseContact.date.day).toJalali();
                                      var totalTime = _databaseContact.consoleData["totalTime"];
                                      var currentMoney = _databaseContact.consoleData["currentMoney"];
                                      var items = _databaseContact.consoleData["items"] ?? [];
                                      var isOnline = _databaseContact.consoleData["isOnline"];
                                      var playerLenght = _databaseContact.consoleData["playerLenght"];
                                      if (!currentMoneyList.contains(currentMoney)) {
                                        currentMoneyList.add(currentMoney);
                                      }
                                      return SizedBox(
                                        height: 90,
                                        child: Row(
                                          children: [
                                            //First for dateTime in each Console
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.center,
                                                      height: 89.5,
                                                      child: Text(
                                                        consoleDate.year.toString() +
                                                            "/" +
                                                            consoleDate.month.toString() +
                                                            "/" +
                                                            consoleDate.day.toString() +
                                                            "\n" +
                                                            _databaseContact.date.hour.toString() +
                                                            ":" +
                                                            _databaseContact.date.minute.toString() +
                                                            ":" +
                                                            _databaseContact.date.second.toString() +
                                                            "\n" +
                                                            _databaseContact.consoleName,
                                                        style: AppTheme.fontCreator(fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                                            //second for time play in each Console
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 89.5,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text(
                                                              (totalTime.toInt().round()) < 60
                                                                  ? (totalTime.toInt()).toString()
                                                                  : (totalTime.toInt() ~/ 60) > 60
                                                                      ? ((totalTime.toInt() / 60) ~/ 60).round().toString() +
                                                                          ":" +
                                                                          ((totalTime.toInt() / 60) % 60).round().toString()
                                                                      : (totalTime.toInt() / 60).round().toString(),
                                                              style: AppTheme.fontCreator(fontSize: 15),
                                                            ),
                                                            Text(
                                                              (totalTime.toInt().round()) < 60
                                                                  ? "sec".tr
                                                                  : (totalTime.toInt() ~/ 60) < 60
                                                                      ? "min".tr
                                                                      : "",
                                                              style: AppTheme.fontCreator(fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 89.5,
                                                      child: Center(
                                                        child: Text(
                                                          currentMoney.toInt().toString(),
                                                          style: AppTheme.fontCreator(fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                                            Expanded(
                                                flex: 6,
                                                child: SizedBox(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 89.5,
                                                        child: items.length < 1
                                                            ? Center(child: Text("empty".tr, style: AppTheme.fontCreator(fontSize: 12)))
                                                            : ListView.builder(
                                                                cacheExtent: 500000,
                                                                shrinkWrap: false,
                                                                itemCount: items.length,
                                                                itemBuilder: (context, index) {
                                                                  return Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      SizedBox(
                                                                          width: 50,
                                                                          child: Text(items[index]["itemCount"],
                                                                              style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                      SizedBox(
                                                                          width: 90,
                                                                          child: Text(items[index]["itemPrice"].toString(),
                                                                              style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                      SizedBox(
                                                                          width: 120,
                                                                          child: Text(items[index]["itemName"],
                                                                              style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                    ],
                                                                  );
                                                                }),
                                                      ),
                                                      Container(width: 1.sw, height: 0.5, color: Colors.white),
                                                    ],
                                                  ),
                                                )),
                                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 89.5,
                                                      child: Center(
                                                          child: Icon(
                                                        isOnline ? Icons.check : Icons.close,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )),
                                                    ),
                                                    Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 0.5, height: 1.sh, color: Colors.white),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 89.5,
                                                      child: Center(
                                                        child: Text(
                                                          playerLenght.toString(),
                                                          style: AppTheme.fontCreator(fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (_appController.isFiltered.isTrue) {
                                      var start = Jalali(
                                              int.parse(_startDate.value.substring(0, 4)),
                                              int.parse(_startDate.value.substring(5, _startDate.value.indexOf("/", 5))),
                                              int.parse(_startDate.value.substring(_startDate.value.indexOf("/", 5) + 1, _startDate.value.length)))
                                          .toGregorian();
                                      var end = Jalali(
                                              int.parse(_endDate.value.substring(0, 4)),
                                              int.parse(_endDate.value.substring(5, _endDate.value.indexOf("/", 5))),
                                              int.parse(_endDate.value.substring(_endDate.value.indexOf("/", 5) + 1, _endDate.value.length)))
                                          .toGregorian();
                                      if (_databaseContact.date.year >= start.year && _databaseContact.date.year <= end.year) {
                                        if (_databaseContact.date.month >= start.month && _databaseContact.date.month <= end.month) {
                                          if (_databaseContact.date.day >= start.day && _databaseContact.date.day <= end.day) {
                                            var consoleDate =
                                                Gregorian(_databaseContact.date.year, _databaseContact.date.month, _databaseContact.date.day)
                                                    .toJalali();
                                            var totalTime = _databaseContact.consoleData["totalTime"];
                                            var currentMoney = _databaseContact.consoleData["currentMoney"];
                                            var items = _databaseContact.consoleData["items"] ?? [];
                                            var isOnline = _databaseContact.consoleData["isOnline"];
                                            var playerLenght = _databaseContact.consoleData["playerLenght"];
                                            if (!currentMoneyList.contains(currentMoney)) {
                                              currentMoneyList.add(currentMoney);
                                            }
                                            return SizedBox(
                                              height: 89.5,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.center,
                                                            height: 89,
                                                            child: Text(
                                                              consoleDate.year.toString() +
                                                                  "/" +
                                                                  consoleDate.month.toString() +
                                                                  "/" +
                                                                  consoleDate.day.toString() +
                                                                  "\n" +
                                                                  _databaseContact.date.hour.toString() +
                                                                  ":" +
                                                                  _databaseContact.date.minute.toString() +
                                                                  ":" +
                                                                  _databaseContact.date.second.toString() +
                                                                  "\n" +
                                                                  _databaseContact.consoleName,
                                                              style: AppTheme.fontCreator(fontSize: 15),
                                                            ),
                                                          ),
                                                          Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                  //second for time play in each Console
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 89,
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    (totalTime.toInt().round()) < 60
                                                                        ? (totalTime.toInt()).toString()
                                                                        : (totalTime.toInt() ~/ 60) > 60
                                                                            ? ((totalTime.toInt() / 60) ~/ 60).round().toString() +
                                                                                ":" +
                                                                                ((totalTime.toInt() / 60) % 60).round().toString()
                                                                            : (totalTime.toInt() / 60).round().toString(),
                                                                    style: AppTheme.fontCreator(fontSize: 15),
                                                                  ),
                                                                  Text(
                                                                    (totalTime.toInt().round()) < 60
                                                                        ? "sec".tr
                                                                        : (totalTime.toInt() ~/ 60) < 60
                                                                            ? "min".tr
                                                                            : "",
                                                                    style: AppTheme.fontCreator(fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                  //third for total money each Console
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 89,
                                                            child: Center(
                                                              child: Text(
                                                                currentMoney.toInt().toString(),
                                                                style: AppTheme.fontCreator(fontSize: 15),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                  Expanded(
                                                      flex: 6,
                                                      child: SizedBox(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 89,
                                                              child: items.length < 1
                                                                  ? Center(child: Text("empty".tr, style: AppTheme.fontCreator(fontSize: 12)))
                                                                  : ListView.builder(
                                                                      cacheExtent: 500000,
                                                                      shrinkWrap: false,
                                                                      itemCount: items.length == 0 ? 0 : items.length,
                                                                      itemBuilder: (context, index) {
                                                                        return Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            SizedBox(
                                                                                width: 50,
                                                                                child: Text(items[index]["itemCount"],
                                                                                    style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                            SizedBox(
                                                                                width: 90,
                                                                                child: Text(items[index]["itemPrice"].toString(),
                                                                                    style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                            SizedBox(
                                                                                width: 120,
                                                                                child: Text(items[index]["itemName"],
                                                                                    style: AppTheme.fontCreator(), textAlign: TextAlign.center)),
                                                                          ],
                                                                        );
                                                                      }),
                                                            ),
                                                            Container(width: 1.sw, height: 0.5, color: Colors.white),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 89,
                                                            child: Center(
                                                                child: Icon(
                                                              isOnline ? Icons.check : Icons.close,
                                                              color: Colors.white,
                                                              size: 18,
                                                            )),
                                                          ),
                                                          Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(width: 0.5, height: 1.sh, color: Colors.white),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 89,
                                                            child: Center(
                                                              child: Text(
                                                                playerLenght.toString(),
                                                                style: AppTheme.fontCreator(fontSize: 15),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(width: 1.sw, height: 0.5, color: Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  }
                                }),
                          )),
                        ),
                      ),
                      Container(width: 1.sw, height: 0.5, color: Colors.white),
                      Container(
                        width: 1.sw,
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 27,
                              child: Text("total".tr, style: AppTheme.fontCreator(fontSize: 13)),
                            ),
                            SizedBox(
                              height: 27,
                              width: 0.5.sw,
                              child: Text("${_appController.totalSum.value.toInt()}" + " " + "client_moneyUnit".tr,
                                  style: AppTheme.fontCreator(fontSize: 13)),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 80,
                              child: MaterialButton(
                                onPressed: () {
                                  _appController.totalSum.value = 0;
                                  currentMoneyList.forEach((element) {
                                    _appController.totalSum.value += element;
                                  });
                                },
                                color: Colors.white.withOpacity(0.2),
                                child: Text(
                                  _appController.totalSum.value == 0 ? "calculate".tr : "calculate_again".tr,
                                  style: AppTheme.fontCreator(fontSize: 10),
                                ),
                              ),
                            ),
                            SizedBox(width: 40)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Drawer
          ClientDrawerDesktopWidget(),
        ],
      );
    });
  }

  Material _buildCalculateButton(AppController _appController, Color getColor(Set<MaterialState> states)) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color(0xFF383867),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        onTap: () async {
          if (_startDate.value != "choose_please".tr && _endDate.value != "choose_please".tr) {
            var startDate = Jalali(
                int.parse(_startDate.value.substring(0, 4)),
                int.parse(_startDate.value.substring(5, _startDate.value.indexOf("/", 5))),
                int.parse(_startDate.value.substring(_startDate.value.indexOf("/", 5) + 1, _startDate.value.length)));
            var endDate = Jalali(int.parse(_endDate.value.substring(0, 4)), int.parse(_endDate.value.substring(5, _endDate.value.indexOf("/", 5))),
                int.parse(_endDate.value.substring(_endDate.value.indexOf("/", 5) + 1, _endDate.value.length)));
            if (startDate.toDateTime().isAfter(endDate.toDateTime())) {
              Get.snackbar("invalid_date".tr, "invalid_choose_date".tr,
                  colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
            } else {
              _appController.isFiltered.value = !_appController.isFiltered.value;
            }
          } else {
            Get.snackbar("invalid_date".tr, "empety_date_field".tr,
                colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 130,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Apply_filter".tr, style: AppTheme.fontCreator(fontSize: 14), textAlign: TextAlign.center),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: _appController.isFiltered.value,
                onChanged: (bool? value) {
                  if (_startDate.value != "choose_please".tr && _endDate.value != "choose_please".tr) {
                    var startDate = Jalali(
                        int.parse(_startDate.value.substring(0, 4)),
                        int.parse(_startDate.value.substring(5, _startDate.value.indexOf("/", 5))),
                        int.parse(_startDate.value.substring(_startDate.value.indexOf("/", 5) + 1, _startDate.value.length)));
                    var endDate = Jalali(
                        int.parse(_endDate.value.substring(0, 4)),
                        int.parse(_endDate.value.substring(5, _endDate.value.indexOf("/", 5))),
                        int.parse(_endDate.value.substring(_endDate.value.indexOf("/", 5) + 1, _endDate.value.length)));
                    if (startDate.toDateTime().isAfter(endDate.toDateTime())) {
                      Get.snackbar("invalid_date".tr, "invalid_choose_date".tr,
                          colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
                    } else {
                      _appController.isFiltered.value = !_appController.isFiltered.value;
                    }
                  } else {
                    Get.snackbar("invalid_date".tr, "empety_date_field".tr,
                        colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context, String titleText, bool isStart) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: MaterialButton(
              onPressed: () async => _handleDatePicker(context, isStart),
              child: Text(
                titleText,
                style: AppTheme.fontCreator(fontColor: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.indigo.withOpacity(0.65),
            ),
            margin: sma(left: 10, top: 10, bottom: 10),
            width: 150,
            height: 65,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () async => _handleDatePicker(context, isStart),
              child: Text(
                isStart ? _startDate.value.toString() : _endDate.value.toString(),
                style: AppTheme.fontCreator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDatePicker(BuildContext context, bool isStart) async {
    Jalali shamsiDate = Jalali.fromDateTime(DateTime.now());
    String _date = '';
    showCustomAlertDialog(
      context,
      title: "choose_date".tr,
      contentWidget: SizedBox(
        child: LinearDatePicker(
          startDate: "1398/01/01",
          endDate: "1420/01/01",
          initialDate: "${shamsiDate.year}/${shamsiDate.month}/${shamsiDate.day}",
          dateChangeListener: (String selectedDate) {
            _date = selectedDate;
          },
          showMonthName: true,
          isJalaali: true,
        ),
      ),
      onPressAccept: () {
        if (isStart) {
          _startDate.value = _date;
        } else {
          _endDate.value = _date;
        }
        Get.back();
      },
    );
  }
}
