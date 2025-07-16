import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/notifications/domain/use_case/cancel_all.dart';
import 'package:habit_tracker/features/notifications/domain/use_case/show_notification.dart';
import 'package:habit_tracker/features/notifications/domain/use_case/use_case_notification.dart';
import 'package:habit_tracker/features/notifications/domain/use_case/use_case_notification_daily.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final ShowNotificationUseCase _showNotification;
  final ScheduleDailyNotificationUseCase _scheduleDailyNotification;
  final CancelNotificationUseCase _cancelNotification;
  final CancelAllNotificationsUseCase _cancelAllNotifications;

  NotificationCubit(
    this._showNotification,
    this._scheduleDailyNotification,
    this._cancelNotification,
    this._cancelAllNotifications,
  ) : super(NotificationInitial());

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    emit(NotificationLoading());
    try {
      await _showNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    emit(NotificationLoading());
    try {
      await _scheduleDailyNotification(
        id: id,
        title: title,
        body: body,
        time: time,
        payload: payload,
      );
      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> cancel(int id) async {
    emit(NotificationLoading());
    try {
      await _cancelNotification(id);
      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> cancelAll() async {
    emit(NotificationLoading());
    try {
      await _cancelAllNotifications();
      emit(NotificationSuccess());
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }
}
