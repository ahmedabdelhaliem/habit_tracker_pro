import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';


class UpdateHabit {
  final HabitRepository repository;

  UpdateHabit(this.repository);

  Future<void> call(Habit habit) async {
    return await repository.updateHabit(habit);
  }
}
