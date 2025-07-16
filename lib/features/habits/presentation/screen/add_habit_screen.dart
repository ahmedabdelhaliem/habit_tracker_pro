import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/config/route.dart';
import 'package:habit_tracker/core/utils/widget/notifaction_service.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_screen_body.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/habit_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _notificationInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeNotificationService();
  }

  Future<void> _initializeNotificationService() async {
    try {
      await NotificationServicee.init();
      setState(() {
        _notificationInitialized = true;
      });
    } catch (e) {
      debugPrint('⚠️ Failed to initialize notifications: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notifications failed to initialize 🚨')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          'Habit Tracker Pro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onPrimary),
            onPressed: () {
              context.read<HabitCubit>().loadHabits();
            },
          ),
        ],
      ),
      body: _notificationInitialized
          ? BlocBuilder<HabitCubit, HabitState>(
              builder: (context, state) {
                if (state is HabitLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HabitLoaded) {
                  if (state.habits.isEmpty) {
                    return const Center(child: Text("No habits yet!"));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.habits.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final habit = state.habits[index];
                      return HabitCard(
                        habit: habit,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddHabitScreen(habit: habit),
                            ),
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
            )
          : const Center(child: CircularProgressIndicator()), // ⏳ انتظر تهيئة الإشعارات
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        onPressed: () {
          if (_notificationInitialized) {
            GoRouter.of(context).push(AppRouter.kAddHabitScreen);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please wait, notifications initializing...')),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Habit'),
      ),
    );
  }
}
