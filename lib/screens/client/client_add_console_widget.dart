import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/components/custom_text_field.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/screens/client/client_drawer_desktop.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import '../../main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ClientAddConsoleWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final AppController _appController = Get.put(AppController());
    ScreenUtil().uiSize = AppTheme.designSizeDesktop;
    FocusNode? _titleTextFocusNode;
    final TextEditingController _titleTextController = useTextEditingController(text: '');

    final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
    List<String>? titleMenuNames = List.empty(growable: true);
    List<String>? titleMenuNumber = List.empty(growable: true);

    void _doSomething() async {
      var i = 0;

      while (i < 10) {
        i++;
        if (i == 10) {
          _btnController.error();
          return Navigator.pop(context);
        }
        if (_titleTextController.text == '') {
          Get.snackbar("client_addConsole_EmptyFieldEr".tr, "client_addConsole_EmptyFieldEr_description".tr,
              colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
          _btnController.error();
          i = 10;
          return Navigator.pop(context);
        } else {
          if (await titleBox.get("menuTitleName")!.contains(_titleTextController.text)) {
            Get.snackbar("client_addConsole_DublicatedNameEr".tr, "client_addConsole_DublicatedNameEr_description".tr,
                colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
            _btnController.error();
            i = 10;
            Navigator.pop(context);
          } else if (_appController.titlemenuItems.length > 20) {
            Get.snackbar("client_addConsole_LimitedAddEr".tr, "client_addConsole_LimitedAddEr_description".tr,
                colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
            _btnController.error();
            i = 10;
            return Navigator.pop(context);
          }
        }
        //taeid code serial daryaft shode
        // var dongelSerial = await port.readBytesOnce(18);
        var reader = port.read(15, timeout: 5);
        // var dongelSerial = readPort;
        try {
          if (String.fromCharCodes(reader).startsWith("id=")) {
            if (await titleBox.get("menuTitleSerial")!.contains(String.fromCharCodes(reader).substring(3, 8))) {
              Get.snackbar("client_addConsole_DublicatedSerialEr".tr, "client_addConsole_DublicatedSerialEr_description".tr,
                  colorText: Colors.white, backgroundColor: Color(0xff2f2f50).withOpacity(0.1), barBlur: 2.0);
              _btnController.error();
              i = 10;
              return Navigator.pop(context);
            } else {
              _appController.titlemenuItems.add(_titleTextController.text);
              _appController.serialNumbers.add(String.fromCharCodes(reader).substring(3, 8));
              titleMenuNames = _appController.titlemenuItems;
              titleMenuNumber = _appController.serialNumbers;
              await titleBox.put("menuTitleName", titleMenuNames);
              await titleBox.put("menuTitleSerial", titleMenuNumber);
              _btnController.success();
              i = 10;
              return Navigator.pop(context);
            }
          }
        } catch (e) {
          await Future.delayed(Duration(seconds: 3));
          print("re inja");
        }

        await Future.delayed(Duration(milliseconds: 400));
      }
    }

    _titleTextFocusNode = FocusNode();
    _titleTextFocusNode.addListener(() {
      if (_titleTextFocusNode!.hasFocus) _titleTextController.clear();
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 0.76.sw,
          height: 0.85.sh,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/connection.png"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 0.15.sh),
              Material(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF5462DC),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    Get.defaultDialog(
                        title: "console_name_insert".tr,
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
                                      child: Center(child: Text("console_name".tr, style: AppTheme.fontCreator())),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 30,
                                      child: Center(child: Text("console_serial".tr, style: AppTheme.fontCreator())),
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
                                      itemCount: _appController.titlemenuItems.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index != 0) {
                                          if (index != _appController.titlemenuItems.length) {
                                            return Container(
                                              alignment: Alignment.topCenter,
                                              width: 1.sw,
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Material(
                                                    type: MaterialType.transparency,
                                                    child: InkWell(
                                                      radius: 20,
                                                      borderRadius: BorderRadius.circular(50),
                                                      onTap: () async {
                                                        _appController.titlemenuItems.removeAt(index);
                                                        _appController.serialNumbers.removeAt(index);
                                                        titleMenuNames = _appController.titlemenuItems;
                                                        titleMenuNumber = _appController.serialNumbers;
                                                        await titleBox.put("menuTitleName", titleMenuNames);
                                                        await titleBox.put("menuTitleSerial", titleMenuNumber);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        child: Image.asset("assets/images/close_icon.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 105,
                                                    height: 22,
                                                    child: Text(
                                                      _appController.titlemenuItems[index],
                                                      style: AppTheme.fontCreator(),
                                                    ),
                                                  ),
                                                  SizedBox(width: 0.05.sw),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 115,
                                                    height: 22,
                                                    child: Text(
                                                      _appController.serialNumbers[index],
                                                      style: AppTheme.fontCreator(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Container(
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: 135,
                                                      child: CustomTextField(
                                                        focusNode: _titleTextFocusNode,
                                                        controller: _titleTextController,
                                                        hintText: "console_name".tr,
                                                        textAlign: TextAlign.center,
                                                        hasFloatingPlaceholder: true,
                                                        color: Colors.blueGrey[500],
                                                        onTap: () => UnfocusDisposition,
                                                        maxLength: 13,
                                                        style: AppTheme.fontCreator(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        } else {
                                          return Container();
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
                              child: Text("exit".tr, style: AppTheme.fontCreator(fontSize: 10)),
                            ),
                          ),
                        ),
                        actions: [
                          SizedBox(
                            width: 60,
                            height: 40,
                            child: RoundedLoadingButton(
                              child: Text("add".tr, style: AppTheme.fontCreator(fontSize: 10)),
                              borderRadius: 10,
                              controller: _btnController,
                              onPressed: _doSomething,
                            ),
                          ),
                        ]);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 50,
                      child: Text("client_addConsole_SubmitButton".tr, style: AppTheme.fontCreator())),
                ),
              ),
            ],
          ),
        ),

        //Drawer
        ClientDrawerDesktopWidget(),
      ],
    );
  }
}
