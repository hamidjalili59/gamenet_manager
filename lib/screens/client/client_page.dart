import 'package:flutter/material.dart';
import 'package:gamenet_manager/main.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/components/base_widget.dart';
import 'package:gamenet_manager/components/responsive.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/screens/client/client_add_console_widget.dart';
import 'package:gamenet_manager/screens/client/client_dashboard_desktop_widget.dart';
import 'package:gamenet_manager/screens/client/client_desktop_widget.dart';
import 'package:gamenet_manager/screens/client/client_report_console.dart';
import 'package:gamenet_manager/screens/client/client_setting_desktop.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final AppController _appController = Get.put(AppController());
AppController dataPageList = _appController.page.value == 1
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

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dataPageList1.screenPage.value = "1";
    dataPageList2.screenPage.value = "2";
    dataPageList3.screenPage.value = "3";
    dataPageList4.screenPage.value = "4";
    dataPageList5.screenPage.value = "5";
    dataPageList6.screenPage.value = "6";
    dataPageList7.screenPage.value = "7";
    dataPageList8.screenPage.value = "8";
    dataPageList9.screenPage.value = "9";
    dataPageList10.screenPage.value = "10";
    dataPageList11.screenPage.value = "11";
    dataPageList12.screenPage.value = "12";
    dataPageList13.screenPage.value = "13";
    dataPageList14.screenPage.value = "14";
    dataPageList15.screenPage.value = "15";
    dataPageList16.screenPage.value = "16";
    dataPageList17.screenPage.value = "17";
    dataPageList18.screenPage.value = "18";
    dataPageList19.screenPage.value = "19";
    dataPageList20.screenPage.value = "20";
    List<Widget> pageList = [
      ClientDashboardDesktopWidget(),
      ClientDesktopWidget(),
      ClientAddConsoleWidget(),
      SettingDesktopWidget(),
      DatePicker(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BaseWidget(
          backgroundColor: Color(0xff2D2D43),
          child: DateTime.now().month < 10
              ? Obx(() {
                  Widget _currentWidget = pageList[0];
                  if (_appController.page.value == 0) {
                    _currentWidget = pageList[0];
                  } else if (_appController.page.value > 0 && _appController.page.value < 21) {
                    _currentWidget = pageList[1];
                  } else if (_appController.page.value == 21) {
                    _currentWidget = pageList[2];
                  } else if (_appController.page.value == 22) {
                    _currentWidget = pageList[3];
                  } else if (_appController.page.value == 23) {
                    _currentWidget = pageList[4];
                  }
                  return Responsive(
                    mobile: _currentWidget,
                    tablet: _currentWidget,
                    desktop: _currentWidget,
                  );
                })
              : SizedBox(
                  width: 1.sw,
                  height: 1.sh,
                  child: Center(
                    child: Text(
                      "Your Lisence is Dead" + "\n" + "Call With : 09373463357",
                      style: AppTheme.fontCreator(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
    );
  }
}
