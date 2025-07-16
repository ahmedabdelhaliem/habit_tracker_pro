import 'package:flutter/material.dart';
import 'package:habit_tracker/features/notifications/data/local_data_source_notification.dart';
import 'package:habit_tracker/features/notifications/domain/repo/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource _localDataSource;

  NotificationRepositoryImpl(this._localDataSource);

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _localDataSource.showNotification(
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
    await _localDataSource.scheduleDailyNotification(
      id: id,
      title: title,
      body: body,
      time: time,
      payload: payload,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _localDataSource.cancelNotification(id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _localDataSource.cancelAllNotifications();
  }
}
