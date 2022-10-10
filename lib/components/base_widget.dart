import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gamenet_manager/utils/app_theme.dart';

import 'appbar_title_widget.dart';

class BaseWidget extends HookWidget {
  final Widget? child;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Key? scaffoldKey;
  final Color? backgroundColor;

  const BaseWidget({
    Key? key,
    @required this.child,
    this.appbar,
    this.bottomNavigationBar,
    this.drawer,
    this.scaffoldKey,
    this.backgroundColor = AppTheme.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor ?? Colors.white,
        drawerEnableOpenDragGesture: false,
        appBar: appbar,
        drawer: drawer,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              child ?? Container(),
              WindowTitleBarBox(
                child: Row(
                  children: [
                    WindowButtonHamid(),
                    Expanded(child: MoveWindow()),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
