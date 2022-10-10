import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamenet_manager/components/base_widget.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:get/get.dart';

class ClientError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: Color(0xff2f2f50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Container(
            width: 1.sw,
            height: 1.sh - 50,
            color: Color(0xff2f2f50),
            child: Center(child: Text("client_error_dongel".tr, style: AppTheme.fontCreator())),
          ),
        ],
      ),
    );
  }
}
