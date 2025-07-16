import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/notifications/presentation/cubit/notification_cubit.dart';

class HabitSaveHelper {
  static void saveHabit({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController descController,
    required double progress,
    required int streak,
    required TimeOfDay? reminderTime,
    Habit? existingHabit,
  }) {
    print('💾 Save Button Pressed');
    if (!context.mounted) {
      print('⚠️ Context not mounted, aborting save');
      return;
    }

    if (formKey.currentState!.validate()) {
      print('✅ Form validated successfully');

      final habit = Habit(
        id: existingHabit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        description: descController.text,
        isCompleted: existingHabit?.isCompleted ?? false,
        progress: progress,
        streak: streak,
        reminderTime: reminderTime,
      );

      print('📦 Habit Data: ${habit.toString()}');

      final habitCubit = context.read<HabitCubit>();
      final notificationCubit = context.read<NotificationCubit>();

      if (existingHabit == null) {
        print('🆕 Adding new habit');
        habitCubit.addNewHabit(habit);
      } else {
        print('✏️ Editing existing habit');
        habitCubit.editHabit(habit);
      }

      final habitId = int.tryParse(habit.id) ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      final safeId = habitId % 2147483647; // ✅ حل مشكلة 32-bit

      print('🔔 Reminder Handling -> ID: $safeId');

      if (reminderTime != null) {
        print('📅 Scheduling Notification at ${reminderTime.format(context)}');
        notificationCubit.scheduleDaily(
          id: safeId,
          title: habit.title,
          body: habit.description,
          time: reminderTime,
        );
      } else {
        print('🚫 Cancelling Notification for ID: $safeId');
        notificationCubit.cancel(safeId);
      }
    } else {
      print('❌ Form validation failed');
    }
  }
}
