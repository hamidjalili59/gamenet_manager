import 'dart:async';
import 'package:gamenet_manager/utils/helper_functions.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:gamenet_manager/main.dart';
import 'package:win32/win32.dart';

class AppController extends GetxController {
  RxString screenPage = "0".obs;
  RxInt minMoney = 1.obs;
  RxBool isOn = false.obs;
  RxInt page = 0.obs;
  RxInt lengthOfPages = 0.obs;
  Timer? _timer;
  RxList<String> titlemenuItems = List<String>.empty(growable: true).obs;
  RxInt time = 0.obs;
  RxDouble totalTime = 0.0.obs;
  RxDouble currentTime = 0.0.obs;
  RxInt sec = 0.obs;
  RxInt min = 0.obs;
  RxInt hour = 0.obs;
  RxDouble totalMoney = 0.0.obs;
  RxDouble currentMoney = 0.0.obs;
  RxDouble moneyPerSec = 0.0.obs;
  RxDouble moneyPerhour = 0.0.obs;
  RxList<String> checkoutList = List<String>.empty(growable: true).obs;
  RxBool isOnline = false.obs;
  RxString playerLenght = "1".obs;
  RxDouble money = 0.0.obs;
  RxBool usbIsConnected = false.obs;
  RxString portSerial = "".obs;
  RxList<dynamic> item = List<dynamic>.empty(growable: true).obs;
  RxBool isStop = false.obs;
  RxBool isFiltered = false.obs;
  RxList<String> serialNumbers = List<String>.empty(growable: true).obs;
  RxBool isLoading = false.obs;
  RxList listItems = List.empty(growable: true).obs;
  RxList listItemCounter = List.empty(growable: true).obs;
  RxBool consoleMute = false.obs;
  RxBool screenTurnOff = true.obs;
  RxString dongleSerial = "".obs;
  RxDouble totalSum = 0.0.obs;
  RxBool connectionLoading = false.obs;
  RxList consoleList = List.empty(growable: true).obs;
  RxBool showing = false.obs;

  @override
  void onInit() async {
    try {
      // Stream connectionStream = checkConnection();
      // connectionStream.listen((event) {
      //   portSerial.value = "";
      //   port.config.baudRate = -1;
      //   port.close();
      //   Future.delayed(Duration(milliseconds: 300)).then((value) async {
      //     await configPort();
      //   });
      // port.close();
      // usbIsConnected.value = false;
      // findPort();
      // });
      item.value = settingBox.get("itemList") ?? [];
      consoleList.add("Starting...");
    } catch (e) {
      await Future.delayed(Duration(seconds: 3));
      print("hamid $e");
    }
    super.onInit();
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void resetControllerData() {
    time.value = 0;
    totalTime.value = 0;
    currentTime.value = 0;
    min.value = 0;
    hour.value = 0;
    sec.value = 0;
    totalMoney.value = 0;
    currentMoney.value = 0;
    moneyPerSec.value = 0;
    if (isOn.value) {
      _timer!.cancel();
      isOn.value = false;
    }
  }

  void setTime(String serial) {
    if (isOn.isTrue) {
      _timer!.cancel();
    }
    isOn.value = true;

    if (int.parse(playerLenght.value) > 1) {
      if (int.parse(playerLenght.value) == 2) {
        money.value += settingBox.get("playerLength") ?? 0;
      } else if (int.parse(playerLenght.value) == 3) {
        money.value += (settingBox.get("playerLength") ?? 0 * 2);
      } else if (int.parse(playerLenght.value) == 4) {
        money.value += (settingBox.get("playerLength") ?? 0 * 3);
      }
    }
    if (isOnline.isTrue) {
      money.value += (settingBox.get("OnlinePrice")) ?? 0;
    }
    totalMoney.value = (money * (time.value / 60));
    moneyPerSec.value = (money / 3600);
    totalTime.value = time.value * 60;
    moneyPerhour.value = money.value;
    if (int.parse(playerLenght.value) > 1) {
      if (int.parse(playerLenght.value) == 2) {
        moneyPerhour.value -= settingBox.get("playerLength") ?? 0;
      } else if (int.parse(playerLenght.value) == 3) {
        moneyPerhour.value -= (settingBox.get("playerLength") ?? 0 * 2);
      } else if (int.parse(playerLenght.value) == 4) {
        moneyPerhour.value -= (settingBox.get("playerLength") ?? 0 * 3);
      }
    }
    if (isOnline.isTrue) {
      moneyPerhour.value -= (settingBox.get("OnlinePrice")) ?? 0;
    }
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (sec.value < 60) {
        sec.value = sec.value + 1;
        currentTime.value = currentTime.value + 1;
        currentMoney.value = (currentMoney.value + moneyPerSec.value);
      } else if (sec.value == 60 && currentTime.value != totalTime.value || sec.value == 60 && screenTurnOff.value == false) {
        min.value = min.value + 1;
        sec.value = 00;
      } else if (min.value == 60) {
        hour.value = hour.value + 1;
        min.value = 00;
      } else {
        if (currentTime.value >= totalTime.value) {
          if (!file) {
          } else {
            PlaySound(TEXT(endTimeSound!), NULL, SND_FILENAME | SND_ASYNC);
          }

          _timer!.cancel();
          isOn.value = false;
          if (screenTurnOff.value == true) {
            offDongle(serial);
          }
        }
      }
    });
  }

  void stopTimer() {
    _timer!.cancel();
    isOn.value = false;
    min.value = 0;
    hour.value = 0;
    sec.value = 0;
    time.value = 0;
    totalTime.value = 0;
    currentTime.value = 0;
  }
}
