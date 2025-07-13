import 'package:habit_tracker/features/habits/data/data_source/habit_local_data_source.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';

import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource localDataSource;

  HabitRepositoryImpl(this.localDataSource);

  @override
  List<Habit> getAllHabits() {
    return localDataSource.getAllHabits()
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> addHabit(Habit habit) {
    return localDataSource.addHabit(HabitModel.fromEntity(habit));
  }

  @override
  Future<void> updateHabit(Habit habit) {
    return localDataSource.updateHabit(HabitModel.fromEntity(habit));
  }

  @override
  Future<void> deleteHabit(String id) {
    return localDataSource.deleteHabit(id);
  }
}
