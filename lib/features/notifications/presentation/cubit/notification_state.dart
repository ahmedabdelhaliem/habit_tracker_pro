abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {}

class NotificationFailure extends NotificationState {
  final String message;
  NotificationFailure(this.message);
}
