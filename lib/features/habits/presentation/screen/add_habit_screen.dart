import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_screen_body.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/habit_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary, // ✅ Dynamic Primary Color
        title: Text(
          'Habit Tracker Pro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary, // ✅ Dynamic Text Color
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onPrimary), // ✅ Dynamic Icon Color
            onPressed: () {
              context.read<HabitCubit>().loadHabits();
            },
          ),
        ],
      ),
      body: BlocBuilder<HabitCubit, HabitState>(
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitLoaded) {
            if (state.habits.isEmpty) {
              return const Center(child: Text("No habits yet!"));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16), // 👈 لو عايز مسافة خارجية
              itemCount: state.habits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12), // 👈 مسافة بين العناصر
              itemBuilder: (context, index) {
                final habit = state.habits[index];
                return HabitCard(
                  habit: habit,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddHabitScreen(habit: habit)),
                    );
                  },
                  onDelete: () {
                    context.read<HabitCubit>().removeHabit(habit.id);
                  },
                );
              },
            );
          } else if (state is HabitError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary, // ✅ Dynamic FAB Color
        foregroundColor: colorScheme.onPrimary, // ✅ Dynamic Text/Icon Color
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddHabitScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Habit'),
      ),
    );
  }
}
