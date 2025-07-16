plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.habit_tracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13599879"

    defaultConfig {
        applicationId = "com.example.habit_tracker"
        minSdk = 21 // ✅ مطلوب للـ notifications
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // ✅ دعم Desugaring
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
    create("releaseDebug") { // ✅ اسم جديد لتفادي التعارض
        storeFile = file(System.getProperty("user.home") + "/.android/debug.keystore")
        storePassword = "android"
        keyAlias = "androiddebugkey"
        keyPassword = "android"
    }
}

buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("releaseDebug") // ✅ استخدام الاسم الجديد
        isMinifyEnabled = false
        isShrinkResources = false
    }
}

}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5") // ✅ أحدث نسخة
}
