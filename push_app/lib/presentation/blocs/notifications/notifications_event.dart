part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  const NotificationStatusChanged(this.status);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage notification;

  const NotificationReceived({required this.notification});
}

//TODO2 NotificationReceived #PushMessage
