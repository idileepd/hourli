import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:hourli/global_module/utils/hl_notification_config.dart';

class LocalNotificationController extends GetxController {
  FlutterLocalNotificationsPlugin _notificationPlugin;

  LocalNotificationController() {
    print("init local notifs");

    var androidInitilize =
        AndroidInitializationSettings(HLNotificationConfiDetails.appIcon);
    var iOSinitilize = IOSInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(androidInitilize, iOSinitilize);
    _notificationPlugin = FlutterLocalNotificationsPlugin();
    _notificationPlugin.initialize(
      initilizationsSettings,
      onSelectNotification: onNotificationTapped,
    );
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future onNotificationTapped(String payload) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     content: Text("Notification Clicked $payload"),
    //   ),
    // );
    print("Tapped on notification: $payload");
  }

  void showTestNotification() {
    try {
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        HLNotificationConfiDetails.baseChannelId,
        HLNotificationConfiDetails.currentTaskNotificationChannelName,
        HLNotificationConfiDetails.baseChannelDescription,
        importance: Importance.Max,
      );
      IOSNotificationDetails iSODetails = IOSNotificationDetails();
      NotificationDetails generalNotificationDetails =
          NotificationDetails(androidDetails, iSODetails);
      // DateTime scheduledTime;
      // scheduledTime = DateTime.now().add(Duration(seconds: 5));
      _notificationPlugin.show(
        1,
        "test",
        "body",
        generalNotificationDetails,
      );
    } catch (e) {
      print(e);
    }
  }

  bool showNotificationAt({
    @required DateTime notificationDateTime,
    @required String title,
    @required body,
  }) {
    try {
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        HLNotificationConfiDetails.baseChannelId,
        HLNotificationConfiDetails.currentTaskNotificationChannelName,
        HLNotificationConfiDetails.baseChannelDescription,
        importance: Importance.Max,
      );
      IOSNotificationDetails iSODetails = IOSNotificationDetails();
      NotificationDetails generalNotificationDetails =
          NotificationDetails(androidDetails, iSODetails);

      if (notificationDateTime.isBefore(DateTime.now())) {
        return false;
      }

      _notificationPlugin.schedule(
        3,
        title,
        body,
        notificationDateTime,
        generalNotificationDetails,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool showNotificationAfter(
      {@required int minutes,
      @required String title,
      @required String body,
      @required int id}) {
    try {
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        HLNotificationConfiDetails.baseChannelId,
        HLNotificationConfiDetails.currentTaskNotificationChannelName,
        HLNotificationConfiDetails.baseChannelDescription,
        importance: Importance.Max,
      );
      IOSNotificationDetails iSODetails = IOSNotificationDetails();
      NotificationDetails generalNotificationDetails =
          NotificationDetails(androidDetails, iSODetails);

      DateTime scheduledTime;
      scheduledTime = DateTime.now().add(
        Duration(
          minutes: (minutes % 60).ceil(),
          hours: (minutes / 60).floor(),
        ),
      );
      // print("Notification Scheduled AT ${scheduledTime.toString()}");
      _notificationPlugin.schedule(
        id,
        title,
        body,
        scheduledTime,
        generalNotificationDetails,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void cancelAllNotifications() async {
    await _notificationPlugin.cancelAll();
  }
}
