import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/components/custom_text_field.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/main.dart';
import 'package:gamenet_manager/screens/client/client_drawer_desktop.dart';
import 'package:gamenet_manager/utils/app_theme.dart';

class SettingDesktopWidget extends HookWidget {
  final AppController _appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = useTextEditingController(text: '');
    final TextEditingController _priceController = useTextEditingController(text: '0');
    final TextEditingController _moneyOnlineTextController = useTextEditingController(text: '0');
    final TextEditingController _pLTextController = useTextEditingController(text: '0');
    final TextEditingController _cPTextController = useTextEditingController(text: '0');
    final TextEditingController _usernameTextController = useTextEditingController(text: '');
    final TextEditingController _passwordTextController = useTextEditingController(text: '');
    FocusNode? _priceFocusNode;
    FocusNode? _pLFocusNode;
    FocusNode? _cPFocusNode;
    FocusNode? _unFocusNode;
    FocusNode? _pwFocusNode;
    FocusNode? _moneyOnlineFocusNode;
    ScreenUtil().uiSize = AppTheme.designSizeDesktop;
    _unFocusNode = FocusNode();
    _unFocusNode.addListener(() {
      if (_unFocusNode!.hasFocus) _usernameTextController.clear();
    });
    _pwFocusNode = FocusNode();
    _pwFocusNode.addListener(() {
      if (_pwFocusNode!.hasFocus) _passwordTextController.clear();
    });
    _priceFocusNode = FocusNode();
    _priceFocusNode.addListener(() {
      if (_priceFocusNode!.hasFocus) _priceController.clear();
    });
    _pLFocusNode = FocusNode();
    _pLFocusNode.addListener(() {
      if (_pLFocusNode!.hasFocus) _pLTextController.clear();
    });
    _moneyOnlineFocusNode = FocusNode();
    _moneyOnlineFocusNode.addListener(() {
      if (_moneyOnlineFocusNode!.hasFocus) _moneyOnlineTextController.clear();
    });
    _cPFocusNode = FocusNode();
    _cPFocusNode.addListener(() {
      if (_cPFocusNode!.hasFocus) _cPTextController.clear();
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 1.sh - 0.01.sh,
          width: 0.75.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        if (Get.locale != const Locale('en', 'US')) {
                          _appController.titlemenuItems.first = "Main Menu";
                          Get.locale = const Locale('en', 'US');
                        } else {
                          _appController.titlemenuItems.first = "صفحه اصلی";
                          Get.locale = const Locale('fa', 'IR');
                        }
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.translate,
                          color: Colors.white60,
                          size: 25,
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 25,
                    child: InkWell(
                      onTap: () async {
                        var i = 1;

                        while (i < titleBox.get("menuTitleSerial").length) {
                          // port.writeBytesFromString(
                          //     "on" + "*" + _appController.serialNumbers[i].substring(0, 4) + "F" + "10" + "T" + "0" + "Y" + "1" + "M" + "0" + "E");
                          port.write(Uint8List.fromList(
                              ("on" + "*" + _appController.serialNumbers[i].substring(0, 4) + "F" + "10" + "T" + "0" + "Y" + "1" + "M" + "0" + "E")
                                  .codeUnits));
                          _appController.consoleList.add(
                              "on" + "*" + _appController.serialNumbers[i].substring(0, 4) + "F" + "10" + "T" + "0" + "Y" + "1" + "M" + "0" + "E");
                          var v = 0;
                          // port.readBytesOnListen(30, (value) async {
                          var reader = port.read(20, timeout: 80);
                          print(String.fromCharCodes(reader));
                          while (v < 4) {
                            _appController.consoleList.add(reader);
                            if (String.fromCharCodes(reader).contains("ok")) {
                              datas[i - 1].connectionLoading.value = false;
                              if (datas[i - 1].isOn.value == false) {
                                datas[i - 1].money.value = 0;
                                datas[i - 1].time.value = 10;
                                datas[i - 1].totalTime.value = 1 * 60;
                                datas[i - 1].currentTime.value = 0;
                                datas[i - 1].setTime(_appController.serialNumbers[i]);
                              }
                            }
                            await Future.delayed(Duration(milliseconds: 70));
                            v++;
                          }
                          // });
                          await Future.delayed(Duration(milliseconds: 100));
                          i++;
                        }
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          "assets/images/check_list.png",
                          color: Colors.white54,
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.07.sh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
                      Get.defaultDialog(
                          title: "current_cast_online_games".tr + (settingBox.get("OnlinePrice") ?? "0").toString(),
                          titleStyle: AppTheme.fontCreator(fontColor: Colors.white60),
                          backgroundColor: Colors.blueGrey[300],
                          content: Column(children: [
                            SizedBox(
                              width: 180,
                              child: CustomTextField(
                                onTap: () => UnfocusDisposition,
                                inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                color: Color(0xff2f2f50).withOpacity(0.3),
                                maxLength: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty || !value.isNum) {
                                    return "client_inputError".tr;
                                  }
                                  return null;
                                },
                                controller: _moneyOnlineTextController,
                                focusNode: _moneyOnlineFocusNode,
                                style: AppTheme.fontCreator(),
                              ),
                            ),
                            SizedBox(height: 50),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[700],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(color: Colors.black26, offset: Offset.fromDirection(90), spreadRadius: 0, blurRadius: 5)]),
                              width: 180,
                              height: 60,
                              child: MaterialButton(
                                child: Text("accept".tr, style: AppTheme.fontCreator(fontColor: Color(0xffe4fcf9)), textAlign: TextAlign.center),
                                onPressed: () {
                                  settingBox.put("OnlinePrice", int.parse(_moneyOnlineTextController.text));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ]));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xff19202d).withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(12))),
                      alignment: Alignment.center,
                      width: 280,
                      height: 280,
                      child: SizedBox(height: 100, child: Image.asset("assets/images/online_price.png")),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
                      Get.defaultDialog(
                          title: "current_cast_more_player".tr + (settingBox.get("playerLength") ?? 0).toString(),
                          titleStyle: AppTheme.fontCreator(fontColor: Colors.white60),
                          backgroundColor: Colors.blueGrey[300],
                          content: Column(children: [
                            SizedBox(height: 50),
                            SizedBox(
                              width: 180,
                              child: CustomTextField(
                                onTap: () => UnfocusDisposition,
                                inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                color: Color(0xff2f2f50).withOpacity(0.3),
                                maxLength: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty || !value.isNum) {
                                    return "client_inputError".tr;
                                  }
                                  return null;
                                },
                                focusNode: _pLFocusNode,
                                controller: _pLTextController,
                                style: AppTheme.fontCreator(),
                              ),
                            ),
                            SizedBox(height: 50),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[700],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(color: Colors.black26, offset: Offset.fromDirection(90), spreadRadius: 0, blurRadius: 5)]),
                              width: 180,
                              height: 60,
                              child: MaterialButton(
                                child: Text("accept".tr, style: AppTheme.fontCreator(fontColor: Color(0xffe4fcf9)), textAlign: TextAlign.center),
                                onPressed: () {
                                  settingBox.put("playerLength", int.parse(_pLTextController.text));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ]));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xff19202d).withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(12))),
                      alignment: Alignment.center,
                      width: 280,
                      height: 280,
                      child: SizedBox(height: 100, child: Image.asset("assets/images/player_plus.png")),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.05.sh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
                      Get.defaultDialog(
                          title: "current_cast_console".tr + (settingBox.get("consolePrice") ?? 0).toInt().toString(),
                          titleStyle: AppTheme.fontCreator(fontColor: Colors.white60),
                          backgroundColor: Colors.blueGrey[300],
                          content: Column(children: [
                            SizedBox(
                              width: 180,
                              child: CustomTextField(
                                onTap: () => UnfocusDisposition,
                                inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                color: Color(0xff2f2f50).withOpacity(0.3),
                                maxLength: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty || !value.isNum) {
                                    return "client_inputError".tr;
                                  }
                                  return null;
                                },
                                controller: _cPTextController,
                                focusNode: _moneyOnlineFocusNode,
                                style: AppTheme.fontCreator(),
                              ),
                            ),
                            SizedBox(height: 50),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[700],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(color: Colors.black26, offset: Offset.fromDirection(90), spreadRadius: 0, blurRadius: 5)]),
                              width: 180,
                              height: 60,
                              child: MaterialButton(
                                child: Text("accept".tr, style: AppTheme.fontCreator(fontColor: Color(0xffe4fcf9)), textAlign: TextAlign.center),
                                onPressed: () {
                                  settingBox.put("consolePrice", double.parse(_cPTextController.text));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ]));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xff19202d).withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(12))),
                      alignment: Alignment.center,
                      width: 280,
                      height: 280,
                      child: SizedBox(height: 100, child: Image.asset("assets/images/dollar.png")),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    onTap: () {
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
                                        child: Center(child: Text("cast".tr, style: AppTheme.fontCreator())),
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
                                        itemCount: _appController.item.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index != _appController.item.length) {
                                            return Container(
                                              alignment: Alignment.topCenter,
                                              width: 1.sw,
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    child: Text(
                                                      _appController.item[index]["itemName"],
                                                      style: AppTheme.fontCreator(),
                                                    ),
                                                  ),
                                                  SizedBox(width: 0.05.sw),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    child: Text(
                                                      _appController.item[index]["itemPrice"],
                                                      style: AppTheme.fontCreator(),
                                                    ),
                                                  ),
                                                  Material(
                                                    type: MaterialType.transparency,
                                                    child: InkWell(
                                                      radius: 20,
                                                      borderRadius: BorderRadius.circular(50),
                                                      onTap: () {
                                                        _appController.item.removeAt(index);
                                                        settingBox.put("itemList", _appController.item);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        child: Image.asset("assets/images/close_icon.png"),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: SizedBox(
                                                      width: 110,
                                                      height: 42,
                                                      child: Center(
                                                        child: CustomTextField(
                                                          controller: _nameController,
                                                          color: Colors.blueGrey[500],
                                                          onTap: () => UnfocusDisposition,
                                                          maxLength: 13,
                                                          style: AppTheme.fontCreator(),
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(width: 40),
                                                Container(
                                                  child: SizedBox(
                                                      width: 110,
                                                      height: 42,
                                                      child: Center(
                                                        child: CustomTextField(
                                                          focusNode: _priceFocusNode,
                                                          controller: _priceController,
                                                          color: Colors.blueGrey[500],
                                                          onTap: () => UnfocusDisposition,
                                                          inputeFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))],
                                                          maxLength: 15,
                                                          style: AppTheme.fontCreator(),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          cancel: Material(
                            color: Colors.redAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
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
                          actions: [
                            Material(
                              color: Colors.cyanAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  if (_priceController.text != "" &&
                                      _nameController.text != "" &&
                                      _priceController.text != "0" &&
                                      _nameController.text != "0") {
                                    _appController.item.add({"itemName": _nameController.text, "itemPrice": _priceController.text});
                                    settingBox.put("itemList", _appController.item);
                                    _priceController.text = "";
                                    _nameController.text = "";
                                    Navigator.pop(context);
                                  } else {}
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 60,
                                  height: 40,
                                  child: Text("add".tr, style: AppTheme.fontCreator(fontSize: 10)),
                                ),
                              ),
                            ),
                          ]);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xff19202d).withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(12))),
                      alignment: Alignment.center,
                      width: 280,
                      height: 280,
                      child: SizedBox(height: 100, child: Image.asset("assets/images/foods_add.png")),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        //Drawer
        ClientDrawerDesktopWidget(),
      ],
    );
  }
}
