pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                dir('DevOps_diplom'){
                    git branch: 'main', credentialsId: 'git_key', url: 'https://github.com/kolai23/DevOps_diplom.git'
                }
            }
        }

        stage('Build Artifacts') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }

        stage('Arcive Artifacts') { 
            steps {
                archiveArtifacts artifacts: 'target/*.war'
            }
        }

        stage('Docker Build') { 
            steps {
                sh '#!/bin/bash /n docker build -t diplom/tomcat:${env.BUILD_NUMBER} .'
            }
        }

        stage('Docker Pull') { 
            steps {
                sh 'docker push diplom/tomcat:${env.BUILD_NUMBER} '
            }
        }



    }
}
