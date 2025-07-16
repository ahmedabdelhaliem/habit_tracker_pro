import 'package:habit_tracker/features/notifications/domain/repo/notification_repo.dart';


class ShowNotificationUseCase {
  final NotificationRepository repository;

  ShowNotificationUseCase(this.repository);

  Future<void> call({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) {
    return repository.showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }
}
