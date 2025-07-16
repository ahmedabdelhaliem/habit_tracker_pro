# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Keep Notification channels
-keep class android.app.NotificationChannel { *; }
-keep class android.app.NotificationManager { *; }
