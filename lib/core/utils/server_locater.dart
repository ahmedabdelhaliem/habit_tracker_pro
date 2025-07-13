import 'package:get_it/get_it.dart';
import 'package:habit_tracker/features/habits/data/data_source/habit_local_data_source.dart';
import 'package:habit_tracker/features/habits/data/repo/habit_repo_impl.dart';
import 'package:habit_tracker/features/habits/domain/repo/habit_repo.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/delete_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/edit_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/get_all_habit.dart';
import 'package:habit_tracker/features/habits/domain/use_cases/habit_use_case.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Data Source
  sl.registerLazySingleton<HabitLocalDataSource>(() => HabitLocalDataSource());

  // Repository
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(sl<HabitLocalDataSource>())
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAllHabits(sl()));
  sl.registerLazySingleton(() => AddHabit(sl()));
  sl.registerLazySingleton(() => UpdateHabit(sl()));
  sl.registerLazySingleton(() => DeleteHabit(sl()));

  // Cubit
  sl.registerFactory(() => HabitCubit(
        getAllHabits: sl(),
        addHabit: sl(),
        updateHabit: sl(),
        deleteHabit: sl(),
      ));
}
