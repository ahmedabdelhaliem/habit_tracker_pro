import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/bloc_observer.dart';
import 'package:habit_tracker/config/route.dart';
import 'package:habit_tracker/core/theme/app_theme_color.dart';
import 'package:habit_tracker/core/utils/server_locater.dart';
import 'package:habit_tracker/features/habits/data/models/habit_model.dart';
import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // مراقبة Bloc للتصحيح
  Bloc.observer = AppBlocObserver();

  // تهيئة Hive
  await Hive.initFlutter();
  Hive.registerAdapter(HabitModelAdapter());
  await Hive.deleteBoxFromDisk('habits');

  await Hive.openBox<HabitModel>('habits');
  


  // تهيئة DI
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HabitCubit>(create: (_) => sl<HabitCubit>()..loadHabits())
          ],
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Cairo',
              useMaterial3: true,
              colorSchemeSeed: Colors.teal,
              brightness: Brightness.light,
              extensions: const [
                AppColorss(
                  cardBackground: Color(0xFFE0F2F1),
                  titleColor: Color(0xFF004D40),
                  subtitleColor: Color(0xFF00695C),
                  iconColor: Colors.teal,
                ),
              ],
            ),
            darkTheme: ThemeData(
              fontFamily: 'Cairo',
              useMaterial3: true,
              colorSchemeSeed: Colors.teal,
              brightness: Brightness.dark,
              extensions:  [
                AppColorss(
                  cardBackground: Color(0xFF263238),
                  titleColor: Colors.white,
                  subtitleColor: Color(0xFFB0BEC5),
                  iconColor: Colors.tealAccent,
                ),
              ],
            ),
            themeMode: ThemeMode.system,
          ),
        );
      },
    );
  }
}
