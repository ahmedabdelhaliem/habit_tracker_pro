// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:habit_tracker/config/route.dart';
// import 'package:habit_tracker/features/habits/presentation/manager/cubit/cubit/habit_cubit.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _controller.forward(); // ✅ ابدأ Animation هنا
//     });
//     // ✅ Start Animation
//     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

//     _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
//     _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

//     _controller.forward();

//     // ✅ Load data in background before navigating
//     Future.microtask(() {
//       context.read<HabitCubit>().loadHabits();
//     });

//     // ✅ Navigate to HomeScreen after 3 seconds
//     Timer(const Duration(seconds: 3), () {
//       context.go(AppRouter.kHomeScreen);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       backgroundColor: colorScheme.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ScaleTransition(
//               scale: _scaleAnimation,
//               child: CircleAvatar(
//                 radius: 60.r,
//                 backgroundColor: colorScheme.onPrimary,
//                 child: Icon(Icons.track_changes, size: 50.sp, color: colorScheme.primary),
//               ),
//             ),
//             SizedBox(height: 20.h),
//             FadeTransition(
//               opacity: _fadeAnimation,
//               child: Text(
//                 "Habit Tracker Pro",
//                 style: TextStyle(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.onPrimary,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.h),
//             CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 3.w),
//           ],
//         ),
//       ),
//     );
//   }
// }
