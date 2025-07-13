import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/core/theme/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.title, this.showBack = false, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [BoxShadow(color: AppColors.textPrimary, blurRadius: 4.r, offset: Offset(0, 2))],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),

          Text(
            title,
            style: TextStyle(fontSize: 20.sp, color: AppColors.card, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
