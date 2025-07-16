import 'package:flutter/material.dart';

abstract class NotificationRepository {
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAllNotifications();
}
