import 'package:habit_tracker/features/notifications/domain/repo/notification_repo.dart';


class CancelAllNotificationsUseCase {
  final NotificationRepository repository;

  CancelAllNotificationsUseCase(this.repository);

  Future<void> call() {
    return repository.cancelAllNotifications();
  }
}
