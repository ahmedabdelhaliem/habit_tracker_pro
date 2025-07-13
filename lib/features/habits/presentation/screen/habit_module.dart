// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:habit_tracker/config/route.dart';
// import 'package:habit_tracker/core/utils/widget/custom_appbar.dart';
// import 'package:habit_tracker/features/habits/presentation/screen/widget/home_screen_body.dart';

// class HabitModule extends StatelessWidget {
//   const HabitModule({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Habits Tracker' ,),
//       body: SafeArea(child: HomeScreenBody()),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () { GoRouter.of(context).push(AppRouter.kAddHabitScreen) ;},
//      child: Icon(Icons.add, size: 28.r),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }
