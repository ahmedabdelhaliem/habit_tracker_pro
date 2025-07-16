import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/habit_helper_save.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_from.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/progress_slider.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/save_button.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/streak_habit.dart';
import 'package:habit_tracker/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:habit_tracker/features/notifications/presentation/cubit/notification_state.dart';

class AddHabitScreen extends StatefulWidget {
  final Habit? habit;
  const AddHabitScreen({super.key, this.habit});
  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}
class _AddHabitScreenState extends State<AddHabitScreen> {
  double _progress = 0.0;
  int _streak = 0;
  final int _totalDays = 30;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  TimeOfDay? _reminderTime;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.habit?.title ?? '');
    _descController = TextEditingController(text: widget.habit?.description ?? '');
    _streak = widget.habit?.streak ?? 0;
    _progress = _calculateProgress(_streak);
    _reminderTime = widget.habit?.reminderTime;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.habit != null;
    final colorScheme = Theme.of(context).colorScheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<HabitCubit, HabitState>(
          listener: (context, state) {
            if (state is HabitLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isEditing ? 'Habit updated ✅' : 'Habit added ✅')),
              );
              Navigator.pop(context);
            } else if (state is HabitError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
            }
          },
        ),
        BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Notification updated ✅')));
            } else if (state is NotificationFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Notification error: ${state.message}')));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          title: Text(
            isEditing ? 'Edit Habit' : 'Add Habit',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          actions: [
            if (_reminderTime != null)
              IconButton(
                icon: const Icon(Icons.alarm_off),
                onPressed: () {
                  if (widget.habit != null) {
                    final id = int.tryParse(widget.habit!.id);
                    if (id != null) {
                      context.read<NotificationCubit>().cancel(id);
                    }
                  }
                  setState(() {
                    _reminderTime = null;
                  });
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Reminder cancelled ❌')));
                },
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AddHabitForm(titleController: _titleController, descController: _descController),
                SizedBox(height: 16.h),
                ElevatedButton.icon(
                  onPressed: _pickReminderTime,
                  icon: const Icon(Icons.alarm),
                  label: Text(
                    _reminderTime == null
                        ? "Set Reminder"
                        : "Reminder: ${_reminderTime!.format(context)}",
                  ),
                ),
                SizedBox(height: 16.h),
                StreakCounter(
                  streak: _streak,
                  onIncrement: () => _updateStreak(_streak + 1),
                  onDecrement: () => _updateStreak(_streak > 0 ? _streak - 1 : 0),
                ),
                ProgressSlider(
                  progress: _progress,
                  onChanged: (value) {
                    setState(() {
                      _progress = value;
                    });
                  },
                ),
                SizedBox(height: 40.h),
                SaveButton(onPressed: _saveHabit, label: isEditing ? 'Update Habit' : 'Add Habit'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateProgress(int streak) {
    final progress = (streak / _totalDays).clamp(0.0, 1.0);
    return progress;
  }

  void _updateStreak(int newStreak) {
    setState(() {
      _streak = newStreak;
      _progress = _calculateProgress(_streak);
    });
  }

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _reminderTime = picked;
      });
    } else {
    }
  }
  void _saveHabit() {
    HabitSaveHelper.saveHabit(
      context: context,
      formKey: _formKey,
      titleController: _titleController,
      descController: _descController,
      progress: _progress,
      streak: _streak,
      reminderTime: _reminderTime,
      existingHabit: widget.habit,
    );
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
