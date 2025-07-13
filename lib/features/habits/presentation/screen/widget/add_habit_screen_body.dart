import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_from.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/progress_slider.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/save_button.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/streak_habit.dart';

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

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habit?.title ?? '');
    _descController = TextEditingController(text: widget.habit?.description ?? '');
    _streak = widget.habit?.streak ?? 0;
    _progress = _calculateProgress(_streak);
  }

  double _calculateProgress(int streak) {
    return (streak / _totalDays).clamp(0.0, 1.0);
  }

  void _updateStreak(int newStreak) {
    setState(() {
      _streak = newStreak;
      _progress = _calculateProgress(_streak);
    });
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      final habit = Habit(
        id: widget.habit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descController.text,
        isCompleted: widget.habit?.isCompleted ?? false,
        progress: _progress,
        streak: _streak,
      );

      if (widget.habit == null) {
        context.read<HabitCubit>().addNewHabit(habit);
      } else {
        context.read<HabitCubit>().editHabit(habit);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.habit != null;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AddHabitForm(titleController: _titleController, descController: _descController),
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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
