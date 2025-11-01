import java.util.Properties
import java.io.FileInputStream

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven { url = uri("${System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"}/download.flutter.io") }
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(org.gradle.api.initialization.resolve.RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("${System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"}/download.flutter.io") }
    }
}

val localProperties = Properties()
val localPropertiesFile = File(rootDir, "local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

val flutterSdkPath = localProperties.getProperty("flutter.sdk")
    ?: throw GradleException("Flutter SDK not found. Define location in local.properties.")

rootProject.name = "toplu_hesaplayici"
include(":app")
