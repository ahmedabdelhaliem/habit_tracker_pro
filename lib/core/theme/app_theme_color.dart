import 'package:flutter/material.dart';

@immutable
class AppColorss extends ThemeExtension<AppColorss> {
  final Color cardBackground;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;

  const AppColorss({
    required this.cardBackground,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
  });

  @override
  AppColorss copyWith({
    Color? cardBackground,
    Color? titleColor,
    Color? subtitleColor,
    Color? iconColor,
  }) {
    return AppColorss(
      cardBackground: cardBackground ?? this.cardBackground,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  AppColorss lerp(AppColorss? other, double t) {
    if (other is! AppColorss) return this;
    return AppColorss(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }
}
