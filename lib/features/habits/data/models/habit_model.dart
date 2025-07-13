import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:hive/hive.dart';

part 'habit_model.g.dart';
@HiveType(typeId: 1)
class HabitModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4) // ✅ نسبة الإنجاز
  final double progress;

  @HiveField(5) // ✅ الأيام المتتالية
  final int streak;

  HabitModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.progress = 0.0, // ✅ قيمة افتراضية
    this.streak = 0,     // ✅ قيمة افتراضية
  });

  Habit toEntity() => Habit(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted,
        progress: progress,
        streak: streak,
      );

  static HabitModel fromEntity(Habit habit) => HabitModel(
        id: habit.id,
        title: habit.title,
      
        description: habit.description,
        isCompleted: habit.isCompleted,
        progress: habit.progress,
        streak: habit.streak,
      );
}
