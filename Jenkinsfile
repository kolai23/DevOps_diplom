pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                dir('DevOps_diplom'){
                    sh 'rm -R *'
                    git branch: 'main', credentialsId: 'git_key', url: 'https://github.com/kolai23/DevOps_diplom.git'
                }
            }
        }
    }
}
