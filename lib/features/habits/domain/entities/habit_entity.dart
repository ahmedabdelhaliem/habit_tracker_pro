import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final double progress;
  final int streak;
  final TimeOfDay? reminderTime; // ✅ أضفنا التذكير اليومي

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.progress,
    required this.streak,
    this.reminderTime, // ✅ اختياري
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    double? progress,
    int? streak,
    TimeOfDay? reminderTime,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      streak: streak ?? this.streak,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        progress,
        streak,
        reminderTime,
      ];
}
