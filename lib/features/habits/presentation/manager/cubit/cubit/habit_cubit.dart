import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/delete_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/edit_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/get_all_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/habit_use_case.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  final GetAllHabits getAllHabits;
  final AddHabit addHabit;
  final UpdateHabit updateHabit;
  final DeleteHabit deleteHabit;

  HabitCubit({
    required this.getAllHabits,
    required this.addHabit,
    required this.updateHabit,
    required this.deleteHabit,
  }) : super(HabitInitial());

  Future<void> loadHabits() async {
    emit(HabitLoading());
    try {
      final habits = getAllHabits();
      emit(HabitLoaded(habits));
    } catch (e) {
      emit(HabitError('Failed to load habits: $e'));
    }
  }

  Future<void> addNewHabit(Habit habit) async {
    try {
      await addHabit(habit);
      loadHabits();
    } catch (e) {
      emit(HabitError('Failed to add habit: $e'));
    }
  }

  Future<void> editHabit(Habit habit) async {
    try {
      await updateHabit(habit);
      loadHabits();
    } catch (e) {
      emit(HabitError('Failed to edit habit: $e'));
    }
  }

  Future<void> removeHabit(String id) async {
    try {
      await deleteHabit(id);
      loadHabits();
    } catch (e) {
      emit(HabitError('Failed to delete habit: $e'));
    }
  }
  void updateProgress(String habitId, double progress, int streak) {
  if (state is HabitLoaded) {
    final currentHabits = (state as HabitLoaded).habits;
    final updatedHabits = currentHabits.map((habit) {
      if (habit.id == habitId) {
        return habit.copyWith(progress: progress, streak: streak);
      }
      return habit;
    }).toList();
    emit(HabitLoaded(updatedHabits));
  }
}

}
