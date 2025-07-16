import 'package:flutter/material.dart';
import 'package:habit_tracker/features/notifications/domain/repo/notification_repo.dart';

class ScheduleDailyNotificationUseCase {
  final NotificationRepository _repo;

  ScheduleDailyNotificationUseCase(this._repo);

  Future<void> call({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) {
    return _repo.scheduleDailyNotification(
      id: id,
      title: title,
      body: body,
      time: time,
      payload: payload,
    );
  }
}
