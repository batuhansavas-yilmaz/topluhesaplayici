pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
    }
}

plugins {
    id("com.android.application") version "8.5.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.23" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
    id("com.google.firebase.crashlytics") version "3.0.2" apply false
}

// 🧹 "buildscript" bloğu Flutter 3.35 ile artık kaldırıldı
// Tüm plugin sürümleri yukarıdaki plugins bloğunda belirtiliyor

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
