import 'package:hive/hive.dart';
import '../models/habit_model.dart';

class HabitLocalDataSource {
  final Box<HabitModel> habitBox = Hive.box<HabitModel>('habits');

  List<HabitModel> getAllHabits() => habitBox.values.toList();

  Future<void> addHabit(HabitModel habit) async {
    await habitBox.put(habit.id, habit);
  }

  Future<void> updateHabit(HabitModel habit) async {
    await habitBox.put(habit.id, habit);
  }

  Future<void> deleteHabit(String id) async {
    await habitBox.delete(id);
  }
}
