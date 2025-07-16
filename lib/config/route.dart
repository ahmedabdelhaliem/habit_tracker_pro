import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/presentation/screen/add_habit_screen.dart';
import 'package:habit_tracker/features/habits/presentation/screen/widget/add_habit_screen_body.dart';

class AppRouter {
  static const kHomeScreen = '/';
  static const kAddHabitScreen = '/add-habit';
  static const kNotificationTestScreen = '/notification-test';

  static final GoRouter router = GoRouter(
    initialLocation: kHomeScreen,
    routes: [
      GoRoute(path: kHomeScreen, builder: (context, state) => const HomeScreen()),
      GoRoute(path: kAddHabitScreen, builder: (context, state) => const AddHabitScreen()),
      // GoRoute(path: kNotificationTestScreen, builder: (context, state) => const NotificationTestScreen ()),
    ],
  );
}
