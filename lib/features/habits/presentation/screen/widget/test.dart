// import 'package:flutter/material.dart';
// import 'package:habit_tracker/core/utils/notifaction_service.dart';
// import 'package:habit_tracker/core/utils/widget/test.dart';

// class NotificationTestScreen extends StatelessWidget {
//   const NotificationTestScreen({super.key});

//   void _showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(fontSize: 16)),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('🔔 Notification Debug'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.notifications, size: 80, color: Colors.blueAccent),
//             const SizedBox(height: 20),
//             const Text(
//               'Notification Actions',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 40),

//             // 🔘 Schedule Daily Notification
//             // 🔘 Schedule Notification After 10 Seconds
//             ElevatedButton.icon(
//               icon: const Icon(Icons.timer_10),
//               label: const Text('Schedule in 10 Seconds'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.teal,
//               ),
//               onPressed: () {
//                 Future.delayed(const Duration(seconds: 10), () {
//                   NotificationServicee.showNotification(
//                     id: 5,
//                     title: '🔔 Quick Reminder',
//                     body: 'This notification was delayed by 10 seconds!',
//                   );
//                 });
//               },
//             ),
//             const SizedBox(height: 15),

//             // 🔘 Schedule Notification After 1 Minute
//             ElevatedButton.icon(
//               icon: const Icon(Icons.alarm),
//               label: const Text('Set Daily Reminder Time'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.blueAccent,
//               ),
//               onPressed: () async {
//                 final TimeOfDay? pickedTime = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );

//                 if (pickedTime != null) {
//                   debugPrint('⏰ Time picked: ${pickedTime.format(context)}');

//                   NotificationServicee.scheduleDailyNotification(
//                     id: 10,
//                     title: '🌟 Daily Habit Reminder',
//                     body: '⏰ Don\'t forget to complete your habit today!',
//                     time: pickedTime,
//                   );

//                   _showSnackbar(
//                     context,
//                     '✅ Daily notification set for ${pickedTime.format(context)}',
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 15),

//             // 🔘 Show Immediate Notification
//             ElevatedButton.icon(
//               icon: const Icon(Icons.flash_on),
//               label: const Text('Show Notification Now'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.orange,
//               ),
//               onPressed: () {
//                 NotificationServicee.showNotification(
//                   id: 2,
//                   title: '✅ Test Notification',
//                   body: 'This is an instant notification!',
//                 );
//                 _showSnackbar(context, '✅ Notification shown immediately');
//               },
//             ),
//             const SizedBox(height: 15),

//             // 🔘 Cancel Specific Notification
//             ElevatedButton.icon(
//               icon: const Icon(Icons.cancel),
//               label: const Text('Cancel Notification (ID: 1)'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.redAccent,
//               ),
//               onPressed: () {
//                 NotificationService.cancelNotification(1);
//                 _showSnackbar(context, '🗑️ Cancelled notification with ID: 1');
//               },
//             ),
//             const SizedBox(height: 15),

//             // 🔘 Cancel All Notifications
//             ElevatedButton.icon(
//               icon: const Icon(Icons.delete_forever),
//               label: const Text('Cancel All Notifications'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Colors.red,
//               ),
//               onPressed: () {
//                 NotificationServicee.cancelAllNotifications();
//                 _showSnackbar(context, '🗑️ All notifications cancelled');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
