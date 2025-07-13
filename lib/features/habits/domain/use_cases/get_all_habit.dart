import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';



class GetAllHabits {
  final HabitRepository repository;

  GetAllHabits(this.repository);

  List<Habit> call() {
    return repository.getAllHabits();
  }
}
