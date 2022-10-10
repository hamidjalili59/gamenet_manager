import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamenet_manager/main.dart';
import 'package:gamenet_manager/utils/helper_functions.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/components/CircleProgress.dart';
import 'package:gamenet_manager/components/custom_text_field.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/models/hive_database.dart';
import 'package:gamenet_manager/screens/client/client_drawer_desktop.dart';
import 'package:gamenet_manager/screens/client/client_report_console.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:date_format/date_format.dart';

final _formKey = GlobalKey<FormState>();

class ClientDesktopWidget extends HookWidget {
  final AppController _appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> _selectedItemOG = ValueNotifier<String>("no".tr);
    ValueNotifier<String> _selectedItemNOP = ValueNotifier<String>("1");
    ValueNotifier<List> _listItems = ValueNotifier<List>([]);
    List<TextEditingController> _controllers = new List.empty(growable: true);
    ScreenUtil().uiSize = AppTheme.designSizeDesktop;
    var _currencies = ["yes".tr, "no".tr];
    var _nop = ["1", "2", "3", "4"];
    _selectedItemOG = useState(_currencies[1]);
    _selectedItemNOP = useState(_nop[0]);
    _listItems = useState(List.empty(growable: true));
    final TextEditingController _timeTextController = useTextEditingController(text: '0');
    final TextEditingController _moneyTextController = useTextEditingController(text: '0');
    final TextEditingController _nameTextController = useTextEditingController(text: '');
    FocusNode? _timeTextFN;
    FocusNode? _moneyTextFN;
    FocusNode? _nameTextFN;
    _appController.totalSum.value = 0;

    _timeTextFN = FocusNode();
    _timeTextFN.addListener(() {
      if (_timeTextFN!.hasFocus) _timeTextController.clear();
    });
    _moneyTextFN = FocusNode();
    _moneyTextFN.addListener(() {
      if (_moneyTextFN!.hasFocus) _moneyTextController.clear();
    });
    _nameTextFN = FocusNode();
    _nameTextFN.addListener(() {
      if (_nameTextFN!.hasFocus) _nameTextController.clear();
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //Main Body
        Container(
          child: Obx(() {
            AppController dataPageLists = _appController.page.value == 1
                ? dataPageList1
                : _appController.page.value == 2
                    ? dataPageList2
                    : _appController.page.value == 3
                        ? dataPageList3
                        : _appController.page.value == 4
                            ? dataPageList4
                            : _appController.page.value == 5
                                ? dataPageList5
                                : _appController.page.value == 6
                                    ? dataPageList6
                                    : _appController.page.value == 7
                                        ? dataPageList7
                                        : _appController.page.value == 8
                                            ? dataPageList8
                                            : _appController.page.value == 9
                                                ? dataPageList9
                                                : _appController.page.value == 10
                                                    ? dataPageList10
                                                    : _appController.page.value == 11
                                                        ? dataPageList11
                                                        : _appController.page.value == 12
                                                            ? dataPageList12
                                                            : _appController.page.value == 13
                                                                ? dataPageList13
                                                                : _appController.page.value == 14
                                                                    ? dataPageList14
                                                                    : _appController.page.value == 15
                                                                        ? dataPageList15
                                                                        : _appController.page.value == 16
                                                                            ? dataPageList16
                                                                            : _appController.page.value == 17
                                                                                ? dataPageList17
                                                                                : _appController.page.value == 18
                                                                                    ? dataPageList18
                                                                                    : _appController.page.value == 19
                                                                                        ? dataPageList19
                                                                                        : dataPageList20;

            String _isOnline = dataPageLists.isOnline.value ? "yes".tr : "no".tr;
            String _playerLenght = dataPageLists.playerLenght.value;
            try {
              if (dataPageLists.isOn.isFalse && !(int.parse(_moneyTextController.text) > 0)) {
                _moneyTextController.text = (settingBox.get("consolePrice").toInt() ?? "0").toString();
              }
            } catch (e) {
              print(e.toString() + " poll kam ast");
            }
            // if (dataPageLists.isOn.isTrue && settingBox.get("console${_appController.screenPage.value}Price").length > 0) {
            //   _moneyTextController.text = (int.parse((settingBox.get("console${_appController.screenPage.value}Price") ?? "0"))).toString();
            //   _timeTextController.text = (int.parse((settingBox.get("console${_appController.screenPage.value}time") ?? "0"))).toString();
            // }
            String _serialId = _appController.page.value > 0 && _appController.page.value < 21
                ? _appController.serialNumbers[int.parse(dataPageLists.screenPage.value)].substring(0, 4)
                : "";
            return Container(
              width: 0.76.sw,
              height: 1.sh,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.12.sh),
                    Container(
                      height: 0.06.sh,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          // width: 100,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       SizedBox(width: 16),
                          //       InkWell(
                          //         borderRadius: BorderRadius.all(Radius.circular(50)),
                          //         onTap: () {
                          //           if (dataPageLists.consoleMute.value) {
                          //             dataPageLists.consoleMute.value = !dataPageLists.consoleMute.value;
                          //           } else {
                          //             dataPageLists.consoleMute.value = !dataPageLists.consoleMute.value;
                          //           }
                          //         },
                          //         child: Container(
                          //           alignment: Alignment.center,
                          //           padding: EdgeInsets.all(4),
                          //           width: 40,
                          //           height: 40,
                          //           child: Icon(
                          //               // dataPageLists.consoleMute.value == false ? "assets/images/speaker_on.png" : "assets/images/speaker_off.png"),
                          //               dataPageLists.consoleMute.value == false ? Icons.alarm : Icons.alarm_off,
                          //               color: Colors.white,
                          //               size: 35),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                InkWell(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  onTap: () {
                                    if (dataPageLists.screenTurnOff.value) {
                                      dataPageLists.screenTurnOff.value = !dataPageLists.screenTurnOff.value;
                                    } else {
                                      dataPageLists.screenTurnOff.value = !dataPageLists.screenTurnOff.value;
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        dataPageLists.screenTurnOff.value == false ? "assets/images/screen_on.png" : "assets/images/screen_off.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IgnorePointer(
                            ignoring: dataPageLists.isOn.value ? true : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 0.05.sw),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "playerLenght".tr,
                                    style: AppTheme.fontCreator(fontColor: Colors.white70, fontSize: 14),
                                  ),
                                ),
                                SizedBox(width: 0.01.sw),
                                Container(
                                    padding: EdgeInsets.only(right: 30),
                                    decoration: BoxDecoration(color: Color(0xff3d4b6b), borderRadius: BorderRadius.circular(8)),
                                    width: 90,
                                    height: 42,
                                    child: DropdownButton<String>(
                                      icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white30, size: 20),
                                      value: _playerLenght,
                                      underline: Container(),
                                      style: AppTheme.fontCreator(),
                                      dropdownColor: Color(0xff3d4b6b),
                                      isExpanded: true,
                                      items: _nop.map((t) {
                                        return DropdownMenuItem<String>(
                                          value: t,
                                          child: Text(
                                            t,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? x) {
                                        _selectedItemNOP.value = x ?? _nop[0];
                                        dataPageLists.playerLenght.value = x ?? "1";
                                      },
                                    )),
                                SizedBox(width: 0.083.sw),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "moneyPerSecand".tr,
                                    style: AppTheme.fontCreator(fontColor: Colors.white70),
                                  ),
                                ),
                                SizedBox(width: 0.025.sw),
                                dataPageLists.isOn.isFalse
                                    ? SizedBox(
                                        width: 135,
                                        height: 42,
                                        child: CustomTextField(
                                          onTap: () => UnfocusDisposition,
                                          inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                          maxLength: 6,
                                          validator: (value) {
                                            if (value == null || value.isEmpty || !value.isNum) {}
                                            return null;
                                          },
                                          focusNode: _moneyTextFN,
                                          controller: _moneyTextController,
                                          style: AppTheme.fontCreator(),
                                          prefixText: "client_moneyUnit".tr,
                                          keyboardType: TextInputType.number,
                                        ))
                                    : Container(
                                        padding: EdgeInsets.only(bottom: 2),
                                        width: 135,
                                        height: 42,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Color(0xff3D4B6B), borderRadius: BorderRadius.all(Radius.circular(8))),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 3),
                                            SizedBox(
                                              width: 40,
                                              child: Text("client_moneyUnit".tr, textAlign: TextAlign.center, style: AppTheme.fontCreator()),
                                            ),
                                            SizedBox(
                                                width: 89,
                                                child: Text(
                                                  "${dataPageLists.moneyPerhour.value.toInt()}",
                                                  style: AppTheme.fontCreator(),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.08.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       SizedBox(width: 20),
                          //       InkWell(
                          //         borderRadius: BorderRadius.all(Radius.circular(50)),
                          //         onTap: () {
                          //           if (dataPageLists.screenTurnOff.value) {
                          //             dataPageLists.screenTurnOff.value = !dataPageLists.screenTurnOff.value;
                          //           } else {
                          //             dataPageLists.screenTurnOff.value = !dataPageLists.screenTurnOff.value;
                          //           }
                          //         },
                          //         child: Container(
                          //           padding: EdgeInsets.all(4),
                          //           width: 40,
                          //           height: 40,
                          //           child: Image.asset(
                          //               dataPageLists.screenTurnOff.value == false ? "assets/images/screen_on.png" : "assets/images/screen_off.png"),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                        ),
                        IgnorePointer(
                          ignoring: dataPageLists.isOn.value ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 0.05.sw),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "client_isOnlineGame".tr,
                                  style: AppTheme.fontCreator(fontColor: Colors.white70, fontSize: 14),
                                ),
                              ),
                              SizedBox(width: 0.01.sw),
                              Container(
                                  padding: EdgeInsets.only(right: 30),
                                  decoration: BoxDecoration(color: Color(0xff3d4b6b), borderRadius: BorderRadius.circular(8)),
                                  width: 90,
                                  height: 42,
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white30, size: 20),
                                    value: _isOnline,
                                    underline: Container(),
                                    style: AppTheme.fontCreator(),
                                    dropdownColor: Color(0xff3d4b6b),
                                    isExpanded: true,
                                    items: _currencies.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(
                                          dropDownStringItem,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? b) {
                                      _selectedItemOG.value = b ?? _currencies[0];
                                      if (b == _currencies[0]) {
                                        dataPageLists.isOnline.value = true;
                                      } else {
                                        dataPageLists.isOnline.value = false;
                                      }
                                    },
                                  )),
                              SizedBox(width: 0.083.sw),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "client_timePlay".tr,
                                  style: AppTheme.fontCreator(fontColor: Colors.white70),
                                ),
                              ),
                              SizedBox(width: 0.0095.sw),
                              dataPageLists.isOn.isFalse
                                  ? SizedBox(
                                      width: 135,
                                      height: 42,
                                      child: CustomTextField(
                                        onTap: () => UnfocusDisposition,
                                        inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                        maxLength: 4,
                                        validator: (value) {
                                          if (value == null || value.isEmpty || !value.isNum) {}
                                          return null;
                                        },
                                        focusNode: _timeTextFN,
                                        controller: _timeTextController,
                                        style: AppTheme.fontCreator(),
                                        prefixText: "client_timeUnit".tr,
                                      ))
                                  : Container(
                                      padding: EdgeInsets.only(bottom: 2),
                                      width: 135,
                                      height: 42,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Color(0xff3D4B6B), borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 2),
                                          SizedBox(
                                            width: 40,
                                            child: Text("client_timeUnit".tr, textAlign: TextAlign.center, style: AppTheme.fontCreator()),
                                          ),
                                          SizedBox(
                                              width: 90,
                                              child: Text(
                                                "${dataPageLists.time.value.toInt()}",
                                                style: AppTheme.fontCreator(),
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.08.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 0.23.sw,
                          child: Column(
                            children: [
                              SizedBox(height: 0.07.sh),
                              _buildCircleProcess(dataPageLists),
                              SizedBox(height: 0.08.sh),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    type: MaterialType.transparency,
                                    borderRadius: (BorderRadius.circular(15)),
                                    child: InkWell(
                                      radius: 22,
                                      splashColor: Colors.white,
                                      borderRadius: (BorderRadius.circular(15)),
                                      onTap: () async {
                                        pageNum = dataPageLists.screenPage.value;
                                        if (_appController.page.value != 23) {
                                          _appController.page.value = 23;
                                        }
                                      },
                                      child: Container(
                                          width: 48,
                                          height: 48,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                                          child: Image.asset(
                                            'assets/images/cash.png',
                                            color: Color(0xff175E62),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Material(
                                    color: Color(0xff175E62),
                                    borderRadius: (BorderRadius.circular(6)),
                                    child: InkWell(
                                      borderRadius: (BorderRadius.circular(6)),
                                      onTap: () async {
                                        if (dataPageLists.currentMoney.value != 0) {
                                          offDongle(_serialId);
                                          if (_formKey.currentState!.validate()) {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("client_payment".tr),
                                              duration: Duration(milliseconds: 500),
                                              backgroundColor: Colors.greenAccent.withOpacity(0.35),
                                            ));
                                          }
                                          HiveDatabase dataConsole = HiveDatabase(
                                              date: DateTime.now(),
                                              consoleName: _appController.titlemenuItems[_appController.page.value],
                                              consoleData: {
                                                "totalTime": dataPageLists.currentTime.value,
                                                "currentMoney": dataPageLists.currentMoney.value,
                                                "isOnline": dataPageLists.isOnline.value,
                                                "playerLenght": int.parse(_selectedItemNOP.value),
                                                "items": realBox.get(_appController.page.value.toString()),
                                              });
                                          await box.put((DateTime.now()).toString(), dataConsole);
                                          _listItems.value = [];
                                          realBox.put(dataPageLists.screenPage.value, []);
                                          dataPageLists.resetControllerData();
                                        } else {
                                          HiveDatabase dataConsole = HiveDatabase(
                                              date: DateTime.now(),
                                              consoleName: _appController.titlemenuItems[_appController.page.value],
                                              consoleData: {
                                                "totalTime": dataPageLists.currentTime.value,
                                                "currentMoney": dataPageLists.currentMoney.value,
                                                "isOnline": dataPageLists.isOnline.value,
                                                "playerLenght": int.parse(_selectedItemNOP.value),
                                                "items": realBox.get(_appController.page.value.toString()),
                                              });
                                          await box.put((DateTime.now()).toString(), dataConsole);
                                          _listItems.value = [];
                                          realBox.put(dataPageLists.screenPage.value, []);
                                          offDongle(_serialId);
                                          dataPageLists.resetControllerData();
                                          _appController.consoleList.clear();
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 45,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                                        child: Text("client_checkout".tr, style: AppTheme.fontCreator(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 0.01.sw),
                        Container(
                          width: 180,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                    color: Colors.lightBlue.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                    child: InkWell(
                                      onTap: () {
                                        // try {
                                        //   for (var i = 0; i < (realBox.get(dataPageLists.screenPage.value) ?? []).length; i++) {
                                        //     if (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]) > 0) {
                                        //       dataPageLists.currentMoney.value -=
                                        //           (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemPrice"]) *
                                        //               int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]));
                                        //     }
                                        //   }
                                        // } catch (e) {

                                        // }
                                        _controllers.forEach((element) {
                                          element.clear();
                                        });

                                        Get.defaultDialog(
                                          title: "choose_please".tr,
                                          titleStyle: AppTheme.fontCreator(),
                                          backgroundColor: Colors.blueGrey.withOpacity(0.85),
                                          content: SizedBox(
                                            width: 0.35.sw,
                                            height: 0.65.sh,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        child: Center(child: Text("items".tr, style: AppTheme.fontCreator())),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        child: Center(child: Text("number".tr, style: AppTheme.fontCreator())),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 30,
                                                        child: Center(
                                                            child: Text("cast".tr + " " + "client_moneyUnit".tr, style: AppTheme.fontCreator())),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Divider(
                                                      color: Colors.white,
                                                      endIndent: 30,
                                                      indent: 30,
                                                    )),
                                                Expanded(
                                                  flex: 15,
                                                  child: SizedBox(
                                                    width: 1.sw,
                                                    height: 1.sh,
                                                    child: ListView.builder(
                                                        itemCount: _appController.item.length,
                                                        itemBuilder: (context, index) {
                                                          if (_controllers.length <= _appController.item.length) {
                                                            _controllers.add(new TextEditingController());
                                                          }
                                                          return Container(
                                                            alignment: Alignment.topLeft,
                                                            width: 1.sw,
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  width: 80,
                                                                  child: Text(
                                                                    _appController.item[index]["itemName"],
                                                                    style: AppTheme.fontCreator(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 95,
                                                                    height: 42,
                                                                    child: CustomTextField(
                                                                      controller: _controllers[index],
                                                                      color: Colors.blueGrey[500],
                                                                      onTap: () => UnfocusDisposition,
                                                                      inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                                                      maxLength: 5,
                                                                      style: AppTheme.fontCreator(),
                                                                    )),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blueGrey[300],
                                                                    borderRadius: BorderRadius.circular(5),
                                                                  ),
                                                                  padding: EdgeInsets.only(left: 12),
                                                                  alignment: Alignment.centerLeft,
                                                                  width: 95,
                                                                  height: 40,
                                                                  child: Text(_appController.item[index]["itemPrice"],
                                                                      style: AppTheme.fontCreator(), textAlign: TextAlign.center),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          confirm: Material(
                                            color: Colors.lightBlue.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(12),
                                            child: InkWell(
                                              onTap: () async {
                                                try {
                                                  for (var i = 0; i < (realBox.get(dataPageLists.screenPage.value) ?? []).length; i++) {
                                                    if (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]) > 0) {
                                                      dataPageLists.currentMoney.value -=
                                                          (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemPrice"]) *
                                                              int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]));
                                                    }
                                                  }
                                                } catch (e) {
                                                  await Future.delayed(Duration(seconds: 3));
                                                  print(e.toString() + " d esk 3 ");
                                                }
                                                _listItems.value = (realBox.get(dataPageLists.screenPage.value) ?? []);

                                                _controllers.asMap().forEach((index, element) {
                                                  if (element.text == "") {
                                                    element.text = "0";
                                                  }
                                                  var c = 0;
                                                  if (int.parse(element.text) > 0) {
                                                    if (_listItems.value.isNotEmpty) {
                                                      while (c < _listItems.value.length + 1) {
                                                        if (c == _listItems.value.length) {
                                                          _listItems.value.add({
                                                            "itemCount": element.text,
                                                            "itemName": _appController.item[index]["itemName"],
                                                            "itemPrice": _appController.item[index]["itemPrice"],
                                                          });
                                                          break;
                                                        }
                                                        if ((realBox.get(dataPageLists.screenPage.value) ?? [])[c]["itemName"] ==
                                                            _appController.item[index]["itemName"]) {
                                                          (realBox.get(dataPageLists.screenPage.value) ?? [])[c]["itemCount"] =
                                                              (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[c]["itemCount"]) +
                                                                      int.parse(element.text))
                                                                  .toString();
                                                          break;
                                                        }

                                                        c++;
                                                      }
                                                    } else {
                                                      _listItems.value.add({
                                                        "itemCount": int.parse(element.text).toString(),
                                                        "itemName": _appController.item[index]["itemName"],
                                                        "itemPrice": _appController.item[index]["itemPrice"],
                                                      });
                                                    }
                                                    realBox.put(dataPageLists.screenPage.value, _listItems.value);
                                                  }
                                                });

                                                try {
                                                  for (var i = 0; i < (realBox.get(dataPageLists.screenPage.value) ?? []).length; i++) {
                                                    if (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]) > 0) {
                                                      dataPageLists.currentMoney.value +=
                                                          (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemPrice"]) *
                                                              int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]));
                                                    }
                                                  }
                                                } catch (e) {
                                                  await Future.delayed(Duration(seconds: 3));
                                                  print(e.toString() + " desk 4 ");
                                                }

                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 60,
                                                height: 40,
                                                child: Text("accept".tr, style: AppTheme.fontCreator(fontSize: 10)),
                                              ),
                                            ),
                                          ),
                                          cancel: Material(
                                            color: Colors.redAccent.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(12),
                                            child: InkWell(
                                              onTap: () async {
                                                _controllers.clear();
                                                try {
                                                  for (var i = 0; i < (realBox.get(dataPageLists.screenPage.value) ?? []).length; i++) {
                                                    if (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]) > 0) {
                                                      dataPageLists.currentMoney.value +=
                                                          (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemPrice"]) *
                                                              int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[i]["itemCount"]));
                                                    }
                                                  }
                                                } catch (e) {
                                                  await Future.delayed(Duration(seconds: 3));
                                                  print(e.toString() + " desk 5");
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 60,
                                                height: 40,
                                                child: Text("cancel".tr, style: AppTheme.fontCreator(fontSize: 10)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 0.5.sw,
                                        height: 1.sh,
                                        child: Text("Edible".tr, style: AppTheme.fontCreator()),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    height: 1.sh,
                                    width: 1.sw,
                                    child: ListView.builder(
                                        itemCount: _appController.page.value < 21 && _appController.page.value > 0
                                            ? (realBox.get(dataPageLists.screenPage.value) ?? []).length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          return Material(
                                            type: MaterialType.transparency,
                                            child: InkWell(
                                              onTap: () {},
                                              child: SizedBox(
                                                width: 1.sw,
                                                height: 45,
                                                child: Container(
                                                  width: 1.sw,
                                                  height: 100,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(50))),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                if (int.parse(
                                                                        (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"]) >
                                                                    0) {
                                                                  dataPageLists.currentMoney.value += int.parse(
                                                                      (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemPrice"]);
                                                                  (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"] =
                                                                      (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[index]
                                                                                  ["itemCount"]) +
                                                                              1)
                                                                          .toString();
                                                                }
                                                                _listItems.value = (realBox.get(dataPageLists.screenPage.value) ?? []);
                                                                realBox.put(dataPageLists.screenPage.value, _listItems.value);
                                                              },
                                                              icon: SizedBox(width: 12, height: 12, child: Image.asset("assets/images/plus.png"))),
                                                        ),
                                                        SizedBox(
                                                          width: 80,
                                                          height: 45,
                                                          child: Center(
                                                            child: Text(
                                                              (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemName"] +
                                                                  " X" +
                                                                  ((realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"])
                                                                      .toString(),
                                                              style: AppTheme.fontCreator(),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(50))),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                if (int.parse(
                                                                        (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"]) >
                                                                    0) {
                                                                  dataPageLists.currentMoney.value -= int.parse(
                                                                      (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemPrice"]);
                                                                  (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"] =
                                                                      (int.parse((realBox.get(dataPageLists.screenPage.value) ?? [])[index]
                                                                                  ["itemCount"]) -
                                                                              1)
                                                                          .toString();
                                                                  if (int.parse(
                                                                          (realBox.get(dataPageLists.screenPage.value) ?? [])[index]["itemCount"]) ==
                                                                      0) {
                                                                    (realBox.get(dataPageLists.screenPage.value) ?? []).removeAt(index);
                                                                  }
                                                                }
                                                                _listItems.value = (realBox.get(dataPageLists.screenPage.value) ?? []);
                                                                realBox.put(dataPageLists.screenPage.value, _listItems.value);
                                                              },
                                                              icon:
                                                                  SizedBox(width: 15, height: 15, child: Image.asset("assets/images/minimize.png"))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 0.3.sw,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Color(0xff175E62),
                                    borderRadius: (BorderRadius.circular(6)),
                                    child: InkWell(
                                      onTap: dataPageLists.connectionLoading.value == true
                                          ? () {}
                                          : () async {
                                              if (dataPageLists.isOn.value == false &&
                                                  int.parse(_moneyTextController.text) >= 1 &&
                                                  int.parse(_timeTextController.text) >= 1) {
                                                settingBox.put("console${_appController.screenPage.value}Price", _moneyTextController.text);
                                                settingBox.put("console${_appController.screenPage.value}time", _timeTextController.text);
                                                await onDongle(
                                                    serial: _serialId,
                                                    data: dataPageLists,
                                                    money: double.parse(_moneyTextController.value.text),
                                                    time: int.parse(_timeTextController.value.text),
                                                    isOnline: dataPageLists.isOnline.value ? 1 : 0,
                                                    pL: int.parse(_selectedItemNOP.value),
                                                    context: context);
                                              } else {}
                                            },
                                      borderRadius: (BorderRadius.circular(6)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 110,
                                        height: 40,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                                        child: dataPageLists.connectionLoading.value == true
                                            ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                                            : Text("client_startTime".tr, style: AppTheme.fontCreator(fontSize: 12)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 0.027.sw),
                                  Material(
                                    color: Color(0xFFAC6052),
                                    borderRadius: (BorderRadius.circular(6)),
                                    child: InkWell(
                                      onTap: dataPageLists.isOn.value == false
                                          ? () {}
                                          : () {
                                              if (dataPageLists.isOn.value) dataPageLists.stopTimer();
                                              offDongle(_serialId);
                                            },
                                      borderRadius: (BorderRadius.circular(6)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 110,
                                        height: 40,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                                        child: Text("client_stopTime".tr, style: AppTheme.fontCreator(fontSize: 12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.06.sh),
                              Container(
                                width: 255,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Color(0x50503d4b6b),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _buildInfo(
                                        info: formatDate(DateTime(1989, 02, 1, (dataPageLists.time.value ~/ 60), (dataPageLists.time.value) % 60),
                                            [HH, ':', nn, ':', ss]).toString(),
                                        quest: "client_totalTime".tr,
                                        first: 20),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.025.sh),
                              Container(
                                width: 255,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Color(0x50503d4b6b),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _buildInfo(
                                        info: formatDate(
                                            DateTime(1989, 02, 1, dataPageLists.hour.value, dataPageLists.min.value, dataPageLists.sec.value),
                                            [HH, ':', nn, ':', ss]).toString(),
                                        quest: "client_remainingTime".tr,
                                        first: 20),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.065.sh),
                              Container(
                                width: 255,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Color(0x50503d4b6b),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("client_moneyUnit".tr, style: AppTheme.fontCreator(fontColor: Colors.white70)),
                                    _buildInfo(info: dataPageLists.currentMoney.value.toInt().toString(), quest: "client_currentCost".tr)
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.025.sh),
                              Container(
                                width: 255,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Color(0x50503d4b6b),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("client_moneyUnit".tr, style: AppTheme.fontCreator(fontColor: Colors.white70)),
                                    _buildInfo(info: dataPageLists.totalMoney.value.toInt().toString(), quest: "client_totalCost".tr)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      _appController.usbIsConnected.value == true ? "assets/images/connected.png" : "assets/images/disconnect.png")),
                              SizedBox(width: 8),
                              Text(
                                _appController.usbIsConnected.value == true ? "Connected".tr : "Disconnect".tr,
                                style: AppTheme.fontCreator(),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            onTap: () {
                              Get.defaultDialog(
                                  title: "change_nameConsole".tr,
                                  titleStyle: AppTheme.fontCreator(fontColor: Colors.white60),
                                  backgroundColor: Colors.blueGrey[300],
                                  content: Column(children: [
                                    SizedBox(
                                      width: 180,
                                      child: CustomTextField(
                                        controller: _nameTextController,
                                        focusNode: _nameTextFN,
                                        onTap: () => UnfocusDisposition,
                                        color: Color(0xff2f2f50).withOpacity(0.3),
                                        maxLength: 20,
                                        style: AppTheme.fontCreator(),
                                      ),
                                    ),
                                    SizedBox(height: 50),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[700],
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.black26, offset: Offset.fromDirection(90), spreadRadius: 0, blurRadius: 5)
                                          ]),
                                      width: 180,
                                      height: 60,
                                      child: MaterialButton(
                                        child:
                                            Text("accept".tr, style: AppTheme.fontCreator(fontColor: Color(0xffe4fcf9)), textAlign: TextAlign.center),
                                        onPressed: () async {
                                          try {
                                            if (_nameTextController.text.length > 1) {
                                              if (!_appController.titlemenuItems.contains(_nameTextController.text)) {
                                                _appController.titlemenuItems[_appController.page.value] = _nameTextController.text;
                                                await titleBox.put("menuTitleName", _appController.titlemenuItems);
                                              }
                                            } else {}
                                          } catch (e) {
                                            await Future.delayed(Duration(seconds: 3));
                                            print("Ri");
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ]));
                            },
                            child: Container(
                              child: Icon(Icons.drive_file_rename_outline_rounded, color: Colors.white60),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            // width: 100,
                            child: Text(
                                _appController.page.value > 0 && _appController.page.value < 21
                                    ? _appController.titlemenuItems[_appController.page.value]
                                    : "",
                                style: AppTheme.fontCreator()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        //Drawer
        ClientDrawerDesktopWidget(),
      ],
    );
  }

  Row _buildInfo({String info = "", String quest = "", double first = 0, double sacond = 0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 80, child: Text(info, style: AppTheme.fontCreator(fontSize: 16, fontColor: Colors.white70), textAlign: TextAlign.center)),
        SizedBox(width: first),
        SizedBox(width: 130, child: Text(quest, style: AppTheme.fontCreator(fontSize: 14, fontColor: Colors.white70), textAlign: TextAlign.center)),
        SizedBox(width: sacond),
      ],
    );
  }

  Widget _buildCircleProcess(var dataPage) {
    double persent = ((dataPage.currentTime.value) / (dataPage.totalTime.value)) * 100;

    return CustomPaint(
      foregroundPainter: CircleProgress(dataPage.time.value == 0 ? 0 : persent),
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text("${dataPage.time.value == 0 ? "0" : persent.toInt()}" + "%", style: AppTheme.fontCreator(fontSize: 30, fontColor: Colors.blue)),
        ),
      ),
    );
  }
}
