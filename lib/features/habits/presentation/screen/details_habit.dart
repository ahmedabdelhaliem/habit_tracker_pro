// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:habit_tracker/core/theme/app_color.dart';
// import 'package:habit_tracker/core/theme/app_text_styles.dart';
// import 'package:habit_tracker/features/habits/data/models/habit_model.dart';

// class HabitDetailsScreen extends StatelessWidget {
//   final HabitModel habit;

//   const HabitDetailsScreen({super.key, required this.habit});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.accent,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         title: Text('تفاصيل العادة', style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.r),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // اسم العادة
//             Container(
//               padding: EdgeInsets.all(20.r),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('📌 اسم العادة', style: AppTextStyles.headline1),
//                   SizedBox(height: 8.h),
//                   Text(
//                     habit.name,
//                     style: AppTextStyles.body.copyWith(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 16.h),

//             // عدد التكرارات
//             Container(
//               padding: EdgeInsets.all(20.r),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.repeat, color: AppColors.primary),
//                   SizedBox(width: 12.w),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('عدد التكرارات', style: AppTextStyles.headline1),
//                       SizedBox(height: 4.h),
//                       Text('${habit.repetitions} مرة يومياً', style: AppTextStyles.body),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 16.h),

//             // التكرار
//             Container(
//               padding: EdgeInsets.all(20.r),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.calendar_today_outlined, color: AppColors.primary),
//                   SizedBox(width: 12.w),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('نوع التكرار', style: AppTextStyles.headline1),
//                       SizedBox(height: 4.h),
//                       Text(habit.frequency, style: AppTextStyles.body),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
