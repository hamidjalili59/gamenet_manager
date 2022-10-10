import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamenet_manager/main.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/components/CircleProgress.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/screens/Client/client_drawer_desktop.dart';
import 'package:gamenet_manager/utils/app_theme.dart';

final AppController _appController = Get.put(AppController());

class ClientDashboardDesktopWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().uiSize = AppTheme.designSizeDesktop;

    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Main Body
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 0.7.sw,
              height: 0.95.sh,
              child: SingleChildScrollView(
                child: Obx(
                  () {
                    List<Widget> hamid = [
                      _buildQuickViewItem(dataPageList1, page: 1),
                      _buildQuickViewItem(dataPageList2, page: 2),
                      _buildQuickViewItem(dataPageList3, page: 3),
                      _buildQuickViewItem(dataPageList4, page: 4),
                      _buildQuickViewItem(dataPageList5, page: 5),
                      _buildQuickViewItem(dataPageList6, page: 6),
                      _buildQuickViewItem(dataPageList7, page: 7),
                      _buildQuickViewItem(dataPageList8, page: 8),
                      _buildQuickViewItem(dataPageList9, page: 9),
                      _buildQuickViewItem(dataPageList10, page: 10),
                      _buildQuickViewItem(dataPageList11, page: 11),
                      _buildQuickViewItem(dataPageList12, page: 12),
                      _buildQuickViewItem(dataPageList13, page: 13),
                      _buildQuickViewItem(dataPageList14, page: 14),
                      _buildQuickViewItem(dataPageList15, page: 15),
                      _buildQuickViewItem(dataPageList16, page: 16),
                      _buildQuickViewItem(dataPageList17, page: 17),
                      _buildQuickViewItem(dataPageList18, page: 18),
                      _buildQuickViewItem(dataPageList19, page: 19),
                      _buildQuickViewItem(dataPageList20, page: 20),
                    ];
                    return _appController.titlemenuItems.length > 1
                        ? SizedBox(
                            width: 1.sw,
                            height: 1.sh,
                            child: GridView.count(
                              mainAxisSpacing: 30,
                              crossAxisSpacing: 50,
                              padding: EdgeInsets.only(top: 30, left: 45, bottom: 20),
                              crossAxisCount: MediaQuery.of(context).size.width < 1280
                                  ? 3
                                  : MediaQuery.of(context).size.width < 1600
                                      ? 4
                                      : 5,
                              children: [
                                _appController.titlemenuItems.length > 1 ? hamid[0] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 2 ? hamid[1] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 3 ? hamid[2] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 4 ? hamid[3] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 5 ? hamid[4] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 6 ? hamid[5] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 7 ? hamid[6] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 8 ? hamid[7] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 9 ? hamid[8] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 10 ? hamid[9] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 11 ? hamid[10] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 12 ? hamid[11] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 13 ? hamid[12] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 14 ? hamid[13] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 15 ? hamid[14] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 16 ? hamid[15] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 17 ? hamid[16] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 18 ? hamid[17] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 19 ? hamid[18] : SizedBox(width: 200, height: 200),
                                _appController.titlemenuItems.length > 20 ? hamid[19] : SizedBox(width: 200, height: 200),
                              ],
                            ),
                          )
                        : Center(
                            child: Container(
                            alignment: Alignment.bottomCenter,
                            width: 500.w,
                            height: 420.w,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/connection_lost.png"))),
                            child: Text("client_warningMakeConsole".tr, style: AppTheme.fontCreator(fontSize: 25)),
                          ));
                  },
                ),
              ),
            ),
          ),

          //Drawer
          ClientDrawerDesktopWidget(),
        ],
      ),
    );
  }

  Widget _buildQuickViewItem(AppController dataPageList, {int page = 1}) {
    double persent = ((dataPageList.currentTime.value * 60) / (dataPageList.totalTime.value * 60)) * 100;
    return Material(
      type: MaterialType.transparency,
      // color: Color(0xFF4F4F94).withOpacity(0.4),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: InkWell(
        splashColor: Colors.blue.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(100)),
        onTap: () {
          _appController.page.value = page;
        },
        child: CustomPaint(
          foregroundPainter: CircleProgress(dataPageList.time.value == 0 ? 0 : persent),
          child: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0.035.sh),
                  Text(
                      dataPageList.isOn.value
                          ? formatDate(
                              DateTime(1989, 02, 1, dataPageList.hour.value, dataPageList.min.value, dataPageList.sec.value), [HH, ':', nn, ':', ss])
                          : "client_Off".tr,
                      style: AppTheme.fontCreator(fontSize: 20, fontColor: Colors.blue)),
                  SizedBox(height: 0.01.sh),
                  _appController.titlemenuItems.length > page
                      ? Text(datas[page - 1].connectionLoading.value == false ? _appController.titlemenuItems[page] : "loading",
                          style: AppTheme.fontCreator(fontSize: 15, fontColor: Colors.blue))
                      : Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
