import java.util.Properties
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()
if (keyPropertiesFile.exists()) {
    keyProperties.load(keyPropertiesFile.inputStream())
} else {
    throw GradleException("'key.properties' not found in android directory. Please ensure the file exists and contains the required signing information.")
}

fun getKeyProperty(key: String): String {
    val property = keyProperties.getProperty(key)
    if (property.isNullOrBlank()) { // Check for null or empty string
        throw GradleException("Property '$key' is missing or empty in 'key.properties'.")
    }
    return property
}

android {
    namespace = "com.bsavasy.toplu_hesaplayici"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.bsavasy.toplu_hesaplayici"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            try {
                keyAlias = getKeyProperty("keyAlias")
                keyPassword = getKeyProperty("keyPassword")
                storeFile = file(getKeyProperty("storeFile"))
                storePassword = getKeyProperty("storePassword")
            } catch (e: Exception) {
                throw GradleException("Failed to read key properties: ${e.message}")
            }   
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
