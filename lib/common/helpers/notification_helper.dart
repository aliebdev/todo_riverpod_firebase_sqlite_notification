import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/common/models/task_model.dart';
import 'package:todo/features/todo/pages/view_notification_page.dart';

class NotificationsHelper {
  final WidgetRef ref;

  NotificationsHelper(this.ref);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectedNotificationPayload;

  final BehaviorSubject<String?> selectedNotificationSubject =
      BehaviorSubject<String?>();

  init() async {
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("calendar");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("details.payload = ${details.payload}");
        selectedNotificationSubject.add(details.payload);
      },
    );
  }

  void requestPermission() {}

  void requestIOSPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String timeZoneName = "Asia/Tehran";
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    showDialog(
      context: ref.context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("View"),
          ),
        ],
      ),
    );
  }

  scheduleNotification(
    int days,
    int hours,
    int minutes,
    int seconds,
    TaskModel task,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id ?? 0,
      task.title,
      task.desc,
      tz.TZDateTime.now(tz.local).add(
        Duration(
          days: days,
          hours: hours,
          minutes: minutes,
          seconds: seconds,
        ),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload:
          "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}",
    );
  }

  void _configureSelectNotificationSubject() {
    selectedNotificationSubject.stream.listen(
      (String? payload) {
        final title = payload!.split('|')[0];
        final body = payload.split('|')[1];
        showDialog(
          context: ref.context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewNotificationPage(
                        payload: payload,
                      ),
                    ),
                  );
                },
                child: const Text("View"),
              ),
            ],
          ),
        );
      },
    );
  }
}
