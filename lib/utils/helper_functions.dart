import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gamenet_manager/controllers/app_controller.dart';
import 'package:gamenet_manager/utils/app_theme.dart';
import 'package:gamenet_manager/utils/enums.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:win32/win32.dart';

import '../main.dart';

final AppController _appController = Get.put(AppController());
openPortSerial() {
  SerialPort(_appController.portSerial.value).openReadWrite();
}

findPort() async {
  try {
    // port.removeReadListener();
    // port.close();
  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    print("port close bode ehtemalan");
  }
  try {
    SerialPort.availablePorts.forEach((element) {
      // if (SerialPort(element).description!.startsWith("USB-SERIAL CH340") || SerialPort(element).description!.startsWith("Silicon Labs CP210x")) {
      if (SerialPort(element).description!.startsWith("Silicon Labs CP210x")) {
        _appController.portSerial.value = element;
        _appController.usbIsConnected.value = true;
      } else {
        _appController.usbIsConnected.value = false;
      }
    });

    // configPort();

  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    print("dakhel loop find port");
    findPort();
  }
}

Future<void> configPort() async {
  print("Config");
  SerialPort.availablePorts;
  try {
    await findPort();
    if (SerialPort.availablePorts.length > 0) {
      if (_appController.portSerial.value != "") {
        port.config.baudRate = CBR_115200;
        port.config.parity = NOPARITY;
        port.open(mode: SerialPortMode.readWrite);
        if (!port.isOpen) {
          await Future.delayed(Duration(milliseconds: 100)).then((value) {
            port.close();
            configPort();
          });
        }
      }
    }
  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    print(e.toString() + " Config Port");
  }
}

EdgeInsets ama(double number) {
  return EdgeInsets.all(number);
}

EdgeInsets sma({double top = 0, double right = 0, double bottom = 0, double left = 0}) {
  return EdgeInsets.only(top: top, right: right, bottom: bottom, left: left);
}

EdgeInsets syma({double horizontal = 0, double vertical = 0}) {
  return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;

bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 650;

bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

extension E on String {
  String lastChars(int n) => substring(length - n);
}

void showCustomAlertDialog(
  BuildContext context, {
  String title = '',
  Widget contentWidget = const SizedBox(),
  String? cancelBtnText,
  String? acceptBtnText,
  bool showCancelBtn = true,
  Function()? onPressAccept,
  Function()? onPressCancel,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTheme.fontCreator(
            fontWeights: FontWeights.medium,
            fontColor: Colors.black,
          ),
        ),
        content: contentWidget,
        contentPadding: ama(16),
        actions: <Widget>[
          Visibility(
            visible: showCancelBtn,
            child: TextButton(
              onPressed: onPressCancel ??
                  () {
                    Get.back();
                  },
              child: Text(
                cancelBtnText ?? "cancel".tr,
                style: AppTheme.fontCreator(
                  fontSize: 14,
                  fontWeights: FontWeights.light,
                  fontColor: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: onPressAccept ??
                () {
                  Get.back();
                },
            child: Text(
              acceptBtnText ?? "accept".tr,
              style: AppTheme.fontCreator(
                fontSize: 14,
                fontWeights: FontWeights.light,
                fontColor: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> offDongle(String serial) async {
  try {
    var i = 0;
    while (i <= 2) {
      try {
        i++;
        if (i == 2) {
          i += 12;
          break;
        }
        port.write(Uint8List.fromList(("off*" + serial).codeUnits));
        _appController.consoleList.add("off*" + serial);
        var reader = port.read(12, timeout: 15);
        _appController.consoleList.add(String.fromCharCodes(reader));
        if (String.fromCharCodes(reader).startsWith("ok")) {
          print(String.fromCharCodes(reader));
          i = 4;
        }
        // port.readBytesOnListen(30, (value) {
        //   _appController.consoleList.add(String.fromCharCodes(value));
        //   if (String.fromCharCodes(value).contains("ok")) {
        //     i = 4;
        //   }
        // });

      } catch (e) {
        await Future.delayed(Duration(seconds: 3));
        print(e);
        print("داخل لوپ");
        _appController.consoleList.add("داخل لوپ");
      }
    }
  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    _appController.consoleList.add("خاموشی دستگاه");
    print(e);
    print("قسمت خاموشی دستگاه");
  }
}

Future<void> onDongle({String? serial, AppController? data, double? money, int? time, int? pL, int? isOnline, BuildContext? context}) async {
  try {
    var i = 0;
    data!.connectionLoading.value = true;
    while (i <= 3) {
      try {
        if (i == 3) {
          Get.defaultDialog(
              backgroundColor: Colors.blueGrey[800],
              title: "connection_lost".tr,
              titleStyle: AppTheme.fontCreator(fontSize: 15, fontColor: Colors.white54),
              actions: [
                MaterialButton(
                  onPressed: () {
                    if (data.isOn.value == false) {
                      data.money.value = money!;
                      data.time.value = time!;
                      data.setTime(serial!);
                    }
                    Navigator.pop(context!);
                  },
                  child: Text("accept".tr, style: AppTheme.fontCreator()),
                ),
                MaterialButton(
                  onPressed: () async {
                    try {
                      onDongle(serial: serial, data: data, money: money, time: time, pL: pL, isOnline: isOnline, context: context);
                    } catch (e) {
                      await Future.delayed(Duration(seconds: 3));
                      print("RI");
                    }
                    Navigator.pop(context!);
                  },
                  child: Text("again".tr, style: AppTheme.fontCreator()),
                ),
                MaterialButton(
                  onPressed: () {
                    port.write(Uint8List.fromList(("off*" + serial.toString()).codeUnits));
                    _appController.consoleList.add("off*" + serial.toString());
                    // port.writeBytesFromString(({"name": "node${_appController.serialNumbers.indexOf(serial)}", "status": "off"}).toString());
                    Navigator.pop(context!);
                  },
                  child: Text("cancel".tr, style: AppTheme.fontCreator()),
                ),
              ],
              content: Column(
                children: [
                  Icon(Icons.warning, color: Colors.yellow[50], size: 50),
                  SizedBox(
                    width: 315,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "connection_lost_des".tr,
                        style: AppTheme.fontCreator(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 315,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "connection_lost_q".tr,
                        style: AppTheme.fontCreator(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ));

          data.connectionLoading.value = false;
          i += 25;
          break;
        }

        // port.writeBytesFromString("on" + "*" + serial! + "F" + "$time" + "T" + "$pL" + "Y" + "$isOnline" + "M" + "${money!.toInt()}");
        port.write(
            Uint8List.fromList(("on" + "*" + serial! + "F" + "$time" + "T" + "$pL" + "Y" + "$isOnline" + "M" + "${money!.toInt()}").codeUnits));
        _appController.consoleList.add("on" + "*" + serial + "F" + "$time" + "T" + "$pL" + "Y" + "$isOnline" + "M" + "${money.toInt()}");
        var reader = port.read(12, timeout: 50);
        print(String.fromCharCodes(reader));
        _appController.consoleList.add(String.fromCharCodes(reader));
        if (String.fromCharCodes(reader).substring(0).startsWith("ok*$serial") ||
            String.fromCharCodes(reader).substring(0).contains("ok*$serial") ||
            String.fromCharCodes(reader).substring(0).endsWith("ok*$serial")) {
          data.connectionLoading.value = false;
          if (data.isOn.value == false) {
            data.money.value = money;
            data.time.value = time!;
            data.totalTime.value = time * 60;
            data.currentTime.value = 0;
            data.setTime(serial);
          }
          i += 25;
        } else {
          print("RI  :  " + String.fromCharCodes(reader).substring(0));
        }
        // port.readBytesOnListen(8, (value) async {
        //   print(String.fromCharCodes(value));
        //   _appController.consoleList.add(String.fromCharCodes(value));
        //   if (String.fromCharCodes(value).substring(0).startsWith("ok*$serial") ||
        //       String.fromCharCodes(value).substring(0).contains("ok*$serial") ||
        //       String.fromCharCodes(value).substring(0).endsWith("ok*$serial")) {
        //     data.connectionLoading.value = false;
        //     if (data.isOn.value == false) {
        //       data.money.value = money;
        //       data.time.value = time!;
        //       data.totalTime.value = time * 60;
        //       data.currentTime.value = 0;
        //       data.setTime(serial);
        //     }
        //     i += 25;
        //   } else {
        //     print("RI  :  " + String.fromCharCodes(value).substring(0));
        //   }
        // });
      } catch (e) {
        await Future.delayed(Duration(seconds: 3));
        _appController.consoleList.add("داخل لوپ");
        print("داخل لوپ");
      }
      await Future.delayed(Duration(milliseconds: 75));
      i++;
    }
  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    print("قسمت روشن کردن دستگاه");
    _appController.consoleList.add("روشن کردن مورد دار");
  }
}

// void httpRequestFunc() async {
//   try {
//     var url = Uri.parse("http://192.168.1.101");
//     var response = await http.get(url);
//     print("Response status: ${response.statusCode}");
//     print("Response body: ${response.body}");
//     if (response.statusCode == 200) {
//       var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
//       var consoleName = jsonResponse["dongle"];
//       var totalTime = jsonResponse["totalTime"];
//       var isOnline = jsonResponse["isOnline"];
//       var playerLength = jsonResponse["playersLength"];
//       print("اسم کنسول : $consoleName");
//       print("تایم کلی : $totalTime");
//       print("ّبازی آنلاین : " + (isOnline == true ? "بله" : "خیر"));
//       print("تعداد بازیکن : $playerLength");
//     }
//   } catch (e) {
//     print(e);
//   }
// }

// Stream checkConnection() async* {
//   while (true) {
//     try {
//       if (SerialPort.availablePorts.length > 0) {
//         yield port.isOpen;
//         // await Future.delayed(Duration(seconds: 7));
//       }
//     } catch (e) {
//       print("Port Ri  " + e.toString());
//       await Future.delayed(Duration(seconds: 3));
//       try {
//         configPort();
//       } catch (e) {
//         await Future.delayed(Duration(seconds: 3));
//         print("config port nashod");
//       }
//       await Future.delayed(Duration(seconds: 5));
//     }
//   }
// }

void dongleStatus({bool isFirst = false}) async {
  try {
    if (_appController.usbIsConnected.value == true) {
      if (_appController.serialNumbers.length > 1) {
        var i = 1;
        while (i < titleBox.get("menuTitleSerial").length) {
          try {
            datas[i - 1].connectionLoading.value = true;
            var v = 0;
            while (v < 4) {
              try {
                // port.writeBytesFromString("status*" + _appController.serialNumbers[i].toString().substring(0, 4));
                port.write(Uint8List.fromList(("status*" + _appController.serialNumbers[i].toString().substring(0, 4)).codeUnits));
                _appController.consoleList.add("status*" + _appController.serialNumbers[i].toString().substring(0, 4));
                var reader = String.fromCharCodes(port.read(50, timeout: 80));
                // print(reader);
                // print("marhale 0");
                _appController.consoleList.add(reader.toString());
                if (reader.length > 0) {
                  // print("marhale 1");
                  if (reader.startsWith("${_appController.serialNumbers[i].substring(0, 4)}*off")) {
                    v = 3;
                    break;
                  } else {
                    try {
                      print("marhale 2" + "  $reader");
                      if (reader.substring(reader.indexOf(_appController.serialNumbers[i].substring(0, 4)),
                              reader.indexOf(_appController.serialNumbers[i].substring(0, 4)) + 4) ==
                          _appController.serialNumbers[i].substring(0, 4)) {
                        // print("marhale 3");
                        // print(reader.substring(reader.indexOf("*") + 1, reader.indexOf("F")));
                        String currentTime = reader.substring(reader.indexOf("*") + 1, reader.indexOf("F"));
                        // print(reader.substring(reader.indexOf("F") + 1, reader.indexOf("T")));
                        String times = reader.substring(reader.indexOf("F") + 1, reader.indexOf("T"));
                        // print(reader.substring(reader.indexOf("T") + 1, reader.indexOf("Y")));
                        String playerLength = reader.substring(reader.indexOf("T") + 1, reader.indexOf("Y"));
                        // print(reader.substring(reader.indexOf("Y") + 1, reader.indexOf("M")));
                        String isOnline = reader.substring(reader.indexOf("Y") + 1, reader.indexOf("M"));
                        // print(reader.substring(reader.indexOf("M") + 1, reader.indexOf("E")));
                        String money = reader.substring(reader.indexOf("M") + 1, reader.indexOf("E"));
                        try {
                          if (datas[i - 1].isOn.value == false) {
                            datas[i - 1].time.value = int.parse(times);
                            datas[i - 1].isOnline.value = isOnline == "0" ? false : true;
                            datas[i - 1].playerLenght.value = playerLength == "0" ? "1" : playerLength;
                            datas[i - 1].money.value = double.parse(money);
                            datas[i - 1].currentTime.value = double.parse(currentTime);
                            datas[i - 1].sec.value = (int.parse(currentTime) % 3600) % 60;
                            datas[i - 1].min.value = (int.parse(currentTime) % 3600) ~/ 60;
                            datas[i - 1].hour.value = int.parse(currentTime) ~/ 3600;
                            datas[i - 1].currentMoney.value = (double.parse(money) / 3600) * double.parse(currentTime);
                            datas[i - 1].setTime(_appController.serialNumbers[i]);
                            v = 3;
                            break;
                          } else {}
                        } catch (e) {
                          await Future.delayed(Duration(milliseconds: 50));
                          print(e.toString() + " func 5 az akhar ");
                        }
                      }
                    } catch (e) {
                      await Future.delayed(Duration(milliseconds: 100));
                      print(e.toString() + " func 4 az akhar ");
                    }
                  }
                } else {}
                // port.readBytesOnListen(30, (value) async {
                //   print(String.fromCharCodes(value));
                //   _appController.consoleList.add(String.fromCharCodes(value).toString());
                //   if (String.fromCharCodes(value).startsWith("off") ||
                //       String.fromCharCodes(value).contains("off") ||
                //       String.fromCharCodes(value).endsWith("off")) {
                //     v = 2;
                //   } else {
                //     // if (String.fromCharCodes(value).length > 8 &&
                //     if (String.fromCharCodes(value).substring(String.fromCharCodes(value).indexOf("1"), String.fromCharCodes(value).indexOf("*")) ==
                //         _appController.serialNumbers[i].substring(0, 4)) {
                //       String currentTime = String.fromCharCodes(value)
                //           .substring(String.fromCharCodes(value).indexOf("*") + 1, String.fromCharCodes(value).indexOf("F"));
                //       String times = String.fromCharCodes(value)
                //           .substring(String.fromCharCodes(value).indexOf("F") + 1, String.fromCharCodes(value).indexOf("T"));
                //       String playerLength = String.fromCharCodes(value)
                //           .substring(String.fromCharCodes(value).indexOf("T") + 1, String.fromCharCodes(value).indexOf("Y"));
                //       String isOnline = String.fromCharCodes(value)
                //           .substring(String.fromCharCodes(value).indexOf("Y") + 1, String.fromCharCodes(value).indexOf("M"));
                //       String money = String.fromCharCodes(value)
                //           .substring(String.fromCharCodes(value).indexOf("M") + 1, String.fromCharCodes(value).indexOf("E"));
                //       if (datas[i - 1].isOn.value == false) {
                //         datas[i - 1].time.value = int.parse(times);
                //         datas[i - 1].isOnline.value = isOnline == "0" ? false : true;
                //         datas[i - 1].playerLenght.value = playerLength == "0" ? "1" : playerLength;
                //         datas[i - 1].money.value = double.parse(money);
                //         datas[i - 1].currentTime.value = double.parse(currentTime);
                //         datas[i - 1].sec.value = (int.parse(currentTime) % 3600) % 60;
                //         datas[i - 1].min.value = (int.parse(currentTime) % 3600) ~/ 60;
                //         datas[i - 1].hour.value = int.parse(currentTime) ~/ 3600;
                //         datas[i - 1].currentMoney.value = (double.parse(money) / 3600) * double.parse(currentTime);
                //         datas[i - 1].setTime(_appController.serialNumbers[i]);
                //         v = 2;
                //       } else {}
                //     }
                //   }
                // });
                // await Future.delayed(Duration(milliseconds: 700));
                v++;
              } catch (e) {
                await Future.delayed(Duration(milliseconds: 250));
                print(e.toString() + " func 3 az akhar ");
                v++;
              }
            }
            if (isFirst == true) {
              if (datas[i - 1].isOn.isTrue && realBox.get("$i").length > 0) {
                realBox.get("$i").asMap().forEach((index, element) {
                  datas[i - 1].currentMoney.value += (double.parse(element["itemPrice"]) * double.parse(element["itemCount"]));
                });
                datas[i].currentMoney.value;
              }
            }
            datas[i - 1].connectionLoading.value = false;
            await Future.delayed(Duration(milliseconds: 100));
            i++;
          } catch (e) {
            print(e.toString() + " func 2 az akhar ");
            datas[i - 1].connectionLoading.value = false;
            await Future.delayed(Duration(milliseconds: 500));
            i++;
          }
        }
      }
    } else {
      print("Re ID");
      _appController.consoleList.add("moshkel toye bazyabi etelaeat");
    }
  } catch (e) {
    await Future.delayed(Duration(seconds: 3));
    print("قسمت استاتوس گیری");
    _appController.consoleList.add("قسمت استاتوس گیری");
  }
}
