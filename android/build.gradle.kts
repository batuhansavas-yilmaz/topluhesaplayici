allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 📁 Ortak build klasörü konumu
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

// 📁 Alt projeler için build klasörü ayarı
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 📱 ":app" modülünü bağımlılık olarak değerlendir
subprojects {
    project.evaluationDependsOn(":app")
}

// 🧹 Temizlik görevi
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 🔧 Firebase ve benzeri modüller için buildConfig fix (afterEvaluate yerine güvenli yöntem)
subprojects {
    plugins.withId("com.android.application") {
        extensions.configure<com.android.build.gradle.BaseExtension> {
            buildFeatures.buildConfig = true
        }
    }
    plugins.withId("com.android.library") {
        extensions.configure<com.android.build.gradle.BaseExtension> {
            buildFeatures.buildConfig = true
        }
    }
}
