import 'package:habit_tracker/features/notifications/domain/repo/notification_repo.dart';


class CancelNotificationUseCase {
  final NotificationRepository repository;

  CancelNotificationUseCase(this.repository);

  Future<void> call(int id) {
    return repository.cancelNotification(id);
  }
}
