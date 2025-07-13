class Habit {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final double progress; // نسبة الإنجاز
  final int streak; // الأيام المتتالية

  Habit({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.progress = 0.0,
    this.streak = 0,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    double? progress,
    int? streak,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      streak: streak ?? this.streak,
    );
  }
}
