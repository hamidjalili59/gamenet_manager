import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientDrawerDesktopWidget extends HookWidget {
  final AppController _appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil().uiSize = AppTheme.designSizeDesktop;

    return Container(
        height: 1.sh,
        width: 0.24.sw,
        decoration: BoxDecoration(
          color: Color(0xff2F2F50),
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                height: 30,
                width: 1.sw,
                child: Image.asset('assets/images/playstation.png'),
              ),
              SizedBox(height: 0.04.sh),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        width: 1.sw,
                        height: 0.75.sh,
                        child: ListView.builder(
                          itemCount: _appController.titlemenuItems.length,
                          itemBuilder: (context, position) {
                            // if (position == (_appController.titlemenuItems.length - 1)) {
                            //   return Column(
                            //     children: [
                            //       _buildMenuItem(position, title: _appController.titlemenuItems[position]),
                            //       _buildMenuItem(21, haveIcon: true, icon: Icons.add_circle_outline),
                            //     ],
                            //   );
                            // }
                            return _buildMenuItem(position, title: _appController.titlemenuItems[position]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              // SizedBox(height: 0.1.sh),
              // Container(
              //   color: Colors.white,
              //   width: 1.sw,
              //   height: 0.45.sh,
              //   child: ListView.builder(
              //       itemCount: _appController.consoleList.length,
              //       itemBuilder: (context, index) {
              //         return Center(
              //             child: Text(_appController.consoleList[index].toString() + "\n",
              //                 style: AppTheme.fontCreator(fontColor: Colors.black), textAlign: TextAlign.center));
              //       }),
              // ),
              _buildMenuItem(22, title: "settings".tr, haveIcon: true, icon: Icons.settings),
              SizedBox(
                height: 0.022.sh,
              )
            ],
          );
        }));
  }

  Widget _buildMenuItem(int menuPosition, {String? title = "", Function()? onTap, bool haveIcon = false, IconData? icon}) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
        child: Material(
          color: Colors.white12,
          type: _appController.page.value == menuPosition ? MaterialType.card : MaterialType.transparency,
          borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          child: InkWell(
            borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            onTap: onTap ??
                () {
                  if (_appController.page.value != menuPosition) {
                    _appController.page.value = menuPosition;
                    _appController.isFiltered.value = false;
                  }
                },
            child: haveIcon
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 1.sw,
                    height: 40,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(
                        title!,
                        style: AppTheme.fontCreator(fontSize: 14),
                      ),
                      SizedBox(width: 5),
                      SizedBox(width: 15, child: Icon(icon, color: Colors.white70, size: 25)),
                      SizedBox(width: 32),
                    ]))
                : Container(
                    margin: EdgeInsets.only(left: 35),
                    alignment: Alignment.centerLeft,
                    width: 1.sw,
                    height: 50,
                    child: Text(
                      title!,
                      style: AppTheme.fontCreator(fontColor: Colors.white, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    )),
          ),
        ),
      );
    });
  }
}
