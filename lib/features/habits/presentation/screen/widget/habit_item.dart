import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit_entity.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HabitCard({super.key, required this.habit, required this.onEdit, required this.onDelete});

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.habit.progress ?? 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final habit = widget.habit;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // 👇 Open Details Screen instead of Edit directly
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('View ${habit.title} Details!')));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer.withOpacity(0.7),
                  colorScheme.surfaceContainerHighest.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 12.r, offset: Offset(0, 6.h)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🎯 Circular Progress with Gradient
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 35.r,
                        lineWidth: 6.w,
                        percent: widget.habit.progress ?? 0.0,
                        center: Text(
                          "${((widget.habit.progress ?? 0.0) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        progressColor: colorScheme.primary,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        animation: true,
                        animationDuration: 700,
                      ),

                      Text(
                        "${((_progressAnimation.value) * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (habit.streak >= 3)
                        Positioned(
                          top: 0.h,
                          right: 0.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(color: Colors.orange.withOpacity(0.6), blurRadius: 8.r),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.local_fire_department, size: 14.sp, color: Colors.white),
                                SizedBox(width: 2.w),
                                Text(
                                  "${habit.streak}🔥",
                                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),

                  // 📝 Title & Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          habit.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // ✏️ More Options Menu
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        widget.onEdit();
                      } else if (value == 'delete') {
                        widget.onDelete();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                    icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
