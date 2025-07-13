# 🧠 Habit Tracker App

A simple and elegant Flutter app to help users track their daily habits and stay productive.

---

## 🚀 Features

- ✅ Add and edit habits with custom frequency (daily / weekly)
- ✅ Track progress with a visual progress indicator
- ✅ Store habits locally using Hive database
- ✅ Responsive UI with ScreenUtil
- ✅ Clean architecture using BLoC pattern
- ✅ Custom theming with Google Fonts (Cairo)
- ✅ Navigation with GoRouter
- ✅ Arabic language support 🇪🇬
- 📦 Ready for publishing on Google Play

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Hive** (Local storage)
- **BLoC** (State Management)
- **GoRouter** (Navigation)
- **ScreenUtil** (Responsive UI)
- **Google Fonts (Cairo)**
- **Material 3**

---

## 📱 Getting Started

```bash
git clone https://github.com/ahmedabdelhaliem/habit_tracker.git
cd habit_tracker
flutter pub get
flutter run
## 📂 Project Structure
lib/
├── core/
├── config/
├── features/
│   └── habits/
│       ├── data/
│       ├── presentation/
│       │   ├── screen/
│       │   └── widget/
├── main.dart
