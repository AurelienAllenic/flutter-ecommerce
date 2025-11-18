// 🔹 Configuration pour Firebase et Gradle Android
buildscript {
    repositories {
        google()       // Nécessaire pour télécharger les plugins Google
        mavenCentral() // Nécessaire pour d'autres dépendances
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.1") // Version Gradle Android
        classpath("com.google.gms:google-services:4.3.15") // Plugin Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 🔹 Réorganisation des dossiers build
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
