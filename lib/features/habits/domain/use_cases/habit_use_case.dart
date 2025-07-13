import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';

class AddHabit {
  final HabitRepository repository;

  AddHabit(this.repository);

  Future<void> call(Habit habit) async {
    return await repository.addHabit(habit);
  }
}
