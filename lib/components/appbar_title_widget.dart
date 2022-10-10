import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:gamenet_manager/utils/helper_functions.dart';
import 'package:get/get.dart';

class WindowButtonHamid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CloseWindowButton(colors: WindowButtonColors(iconNormal: Color(0xffffffff))),
      MaximizeWindowButton(colors: WindowButtonColors(iconNormal: Color(0xffffffff))),
      MinimizeWindowButton(colors: WindowButtonColors(iconNormal: Color(0xffffffff))),
      SizedBox(
        width: 35,
        height: 25,
        child: InkWell(
          onTap: () async {
            dongleStatus();
          },
          child: Container(
            width: 35,
            height: 35,
            child: Icon(
              Icons.refresh_rounded,
              color: Colors.white60,
            ),
            color: Colors.transparent,
          ),
        ),
      ),
      SizedBox(width: 20),
      InkWell(
        onTap: () {
          Get.defaultDialog(
              title: "درباره ما",
              backgroundColor: Colors.blueGrey[900],
              titleStyle: AppTheme.fontCreator(),
              content: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(
                      color: Colors.white,
                      endIndent: 50,
                      indent: 50,
                    ),
                    SizedBox(height: 30),
                    Text("طراحی ساخت تولید انواع پروژه ها و نرم افزار های هوشمند", style: AppTheme.fontCreator(fontSize: 12)),
                    SizedBox(height: 5),
                    Text("گروه فنی مهندسی آساتیک وابسته به گروه جهادی شهید فخری زاده", style: AppTheme.fontCreator(fontSize: 12)),
                    SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      child: Image.asset("assets/images/shahid.png"),
                    ),
                    SizedBox(height: 15),
                    Text("شماره ثبت : 3997016514004", style: AppTheme.fontCreator(fontSize: 14)),
                    SizedBox(height: 5),
                    Text("تلفن : 09373463357", style: AppTheme.fontCreator(fontSize: 14)),
                    SizedBox(height: 5),
                    Text("مدت اعتبار نرم افزار : " + "${10 - DateTime.now().month}" + " ماه", style: AppTheme.fontCreator(fontSize: 14)),
                    SizedBox(height: 5),
                  ],
                ),
              ));
        },
        child: Container(
          width: 50,
          height: 20,
          child: Image.asset(
            "assets/images/logo_asatic.png",
            color: Color(0xffffffff),
          ),
        ),
      ),
    ]);
  }
}
