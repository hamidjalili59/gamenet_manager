import 'dart:async';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/screens/client/client_page.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:gamenet_manager/utils/helper_functions.dart';
import 'package:gamenet_manager/utils/translations.dart';
import 'models/hive_database.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

// Stream find = findPort();
final port = SerialPort(_appController.portSerial.value);
String? endTimeSound;
var box;
var itemBox;
var titleBox;
var settingBox;
var realBox;
// var readPort;

final file = File(endTimeSound!).existsSync();

var delegate;
AppController dataPageList1 = AppController();
AppController dataPageList2 = AppController();
AppController dataPageList3 = AppController();
AppController dataPageList4 = AppController();
AppController dataPageList5 = AppController();
AppController dataPageList6 = AppController();
AppController dataPageList7 = AppController();
AppController dataPageList8 = AppController();
AppController dataPageList9 = AppController();
AppController dataPageList10 = AppController();
AppController dataPageList11 = AppController();
AppController dataPageList12 = AppController();
AppController dataPageList13 = AppController();
AppController dataPageList14 = AppController();
AppController dataPageList15 = AppController();
AppController dataPageList16 = AppController();
AppController dataPageList17 = AppController();
AppController dataPageList18 = AppController();
AppController dataPageList19 = AppController();
AppController dataPageList20 = AppController();

List<AppController> datas = [
  dataPageList1,
  dataPageList2,
  dataPageList3,
  dataPageList4,
  dataPageList5,
  dataPageList6,
  dataPageList7,
  dataPageList8,
  dataPageList9,
  dataPageList10,
  dataPageList11,
  dataPageList12,
  dataPageList13,
  dataPageList14,
  dataPageList15,
  dataPageList16,
  dataPageList17,
  dataPageList18,
  dataPageList19,
  dataPageList20,
];
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
Future<void> main() async {
  var appDocumentDirectory = await pathProvider.getApplicationSupportDirectory();
  endTimeSound = r'C:\Windows\Media\Alarm03.wav';

  Hive
    ..initFlutter(appDocumentDirectory.path)
    ..registerAdapter(HiveDatabaseAdapter());
  await Future.delayed(Duration(milliseconds: 150)).then((value) async {
    box = await Hive.openBox('dataBase');
    titleBox = await Hive.openBox('titelNames');
    settingBox = await Hive.openBox('SBox');
    itemBox = await Hive.openBox('itemsBox');
    realBox = await Hive.openBox('realBox');
    // in function baraye baz kardan port hast

    try {
      await configPort();
    } catch (e) {
      await Future.delayed(Duration(seconds: 3));
      print("ConfigPort $e");
    }

    await startupSetup();
    runApp(MyApp());
    doWhenWindowReady(() {
      final initialSize = Size(1020, 750);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "gamenet_manager";
      appWindow.show();
    });
    try {
      dongleStatus(isFirst: true);
    } catch (e) {
      await Future.delayed(Duration(seconds: 3));
      print("inja");
    }
  });
}

Future<void> startupSetup() async {
  if (await titleBox.get("menuTitleSerial") == null || await titleBox.get("menuTitleSerial") == []) {
    await titleBox.put("menuTitleSerial", [
      "1000",
      "1001",
      "1002",
      "1003",
      "1004",
      "1005",
      "1006",
      "1007",
      "1008",
      "1009",
      "1010",
      "1011",
      "1012",
      "1013",
      "1014",
      "1015",
      "1016",
      "1017",
      "1018",
      "1019",
      "1020",
    ]);
    _appController.serialNumbers.value = await titleBox.get("menuTitleSerial")!;
  } else {
    _appController.serialNumbers.value = await titleBox.get("menuTitleSerial")!;
  }
  if (await titleBox.get("menuTitleName") == null || await titleBox.get("menuTitleName") == []) {
    await titleBox.put("menuTitleName", [
      "client_mainMenu".tr,
      "Console_01",
      "Console_02",
      "Console_03",
      "Console_04",
      "Console_05",
      "Console_06",
      "Console_07",
      "Console_08",
      "Console_09",
      "Console_10",
      "Console_11",
      "Console_12",
      "Console_13",
      "Console_14",
      "Console_15",
      "Console_16",
      "Console_17",
      "Console_18",
      "Console_19",
      "Console_20",
    ]);
    _appController.titlemenuItems.value = await titleBox.get("menuTitleName")!;
  } else {
    _appController.titlemenuItems.value = await titleBox.get("menuTitleName")!;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appController.titlemenuItems.first = "صفحه اصلی";
    _appController.serialNumbers.first = "1000";
    return ScreenUtilInit(
      designSize: AppTheme.designSizeDesktop,
      builder: () => GetMaterialApp(
        fallbackLocale: const Locale('fa', 'IR'),
        translations: MyTranslations(),
        locale: const Locale('fa', 'IR'),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/clientPage', page: () => ClientPage()),
        ],
        initialRoute: '/clientPage',
      ),
    );
  }
}
