import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';


abstract class HabitRepository {
  List<Habit> getAllHabits();
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(String id);
}
