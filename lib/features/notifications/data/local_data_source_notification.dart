import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/widget/notifaction_service.dart';

abstract class NotificationLocalDataSource {
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

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await NotificationServicee.showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }

  @override
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    await NotificationServicee.scheduleDailyNotification(
      id: id,
      title: title,
      body: body,
      time: time,
      payload: payload,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await NotificationServicee.cancelNotification(id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await NotificationServicee.cancelAllNotifications();
  }
}
