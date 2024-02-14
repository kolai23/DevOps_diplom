pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                dir('java-login-app.'){
                    sh 'rm -R *'
                    git branch: 'main', credentialsId: 'git_key', url: 'https://github.com/kolai23/DevOps_diplom.git'
                }
            }
        }
    }

    stage('Publish') {
        steps {
            dir('spring-petclinic') {
                archiveArtifacts artifacts: 'target/*.war'
                junit 'target/surefire-reports/*.xml'
            }
        }
    }
}
