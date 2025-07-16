import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServicee {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// ✅ 1. Initialization
  static Future<void> init() async {
    debugPrint('🔧 Initializing NotificationService...');
    tz.initializeTimeZones();
    final locName = await tz.local.name; // ensure local loaded
    
    debugPrint('🌍 Timezone initialized: $locName');

    await _requestNotificationPermission();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        debugPrint('🔔 Notification clicked: ${response.payload}');
      },
    );

    // 🛠️ طلب صلاحية Exact Alarm (Android 12+)
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    debugPrint('✅ NotificationService initialized successfully!');
  }

  /// ✅ Request POST_NOTIFICATIONS (Android 13+)
  static Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      debugPrint('🔔 Requesting POST_NOTIFICATIONS permission...');
      await Permission.notification.request();
    } else {
      debugPrint('🔔 Notification permission already granted.');
    }
  }

  /// ✅ Show Immediate Notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('📢 Showing notification NOW: [$id] $title - $body');
    await _notificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: payload,
    );
    debugPrint('✅ Notification [$id] displayed immediately.');
  }

  /// ✅ Schedule Daily Notification at a specific time
  static Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    final location = tz.getLocation('Africa/Cairo'); // lock timezone
    final now = tz.TZDateTime.now(location);

    final scheduledDate = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final nextSchedule = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    debugPrint('📌 Current device time: ${DateTime.now()}');
    debugPrint('📌 Selected TZ date: $nextSchedule');

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      nextSchedule,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
     
      payload: payload,
    );

    debugPrint('✅ Daily notification [$id] scheduled at $nextSchedule');
  }

  /// ✅ Cancel one
  static Future<void> cancelNotification(int id) async {
    debugPrint('🗑️ Cancelling notification [$id]');
    await _notificationsPlugin.cancel(id);
    debugPrint('✅ Cancelled.');
  }

  /// ✅ Cancel all
  static Future<void> cancelAllNotifications() async {
    debugPrint('🗑️ Cancelling ALL notifications');
    await _notificationsPlugin.cancelAll();
    debugPrint('✅ All cancelled.');
  }

  static NotificationDetails _notificationDetails() => const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_tracker_channel',
          'Habit Tracker Notifications',
          channelDescription: 'Reminder notifications for habits',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      );
}
