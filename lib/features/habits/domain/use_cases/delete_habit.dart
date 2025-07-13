import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';


class DeleteHabit {
  final HabitRepository repository;

  DeleteHabit(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteHabit(id);
  }
}
