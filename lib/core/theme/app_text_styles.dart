import 'package:flutter/material.dart';
import 'package:habit_tracker/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle headline1 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle body = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle caption = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle button = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle error = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    color: AppColors.error,
    fontWeight: FontWeight.w500,
  );
}
