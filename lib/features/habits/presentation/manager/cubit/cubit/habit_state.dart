part of 'habit_cubit.dart';

sealed class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object> get props => [];
}

final class HabitInitial extends HabitState {}

final class HabitLoading extends HabitState {}

final class HabitLoaded extends HabitState {
  final List<Habit> habits;

  const HabitLoaded(this.habits);

  @override
  List<Object> get props => [habits];
}

final class HabitError extends HabitState {
  final String message;

  const HabitError(this.message);

  @override
  List<Object> get props => [message];
}
