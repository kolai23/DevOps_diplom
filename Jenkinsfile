pipeline {
    agent any
    environment {
    CLOUDSDK_CORE_PROJECT='insights-api-localdev'
    CLIENT_EMAIL='jenkins@insights-api-localdev.iam.gserviceaccount.com'
    GCLOUD_CREDS=credentials('gcloud-creds')
  }
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
                sh "docker build -t diplom/tomcat:latest ."
            }
        }

        stage('Docker Pull') { 
            steps {
                sh "gcloud auth configure-docker us-central1-docker.pkg.dev"

                sh "docker tag diplom/tomcat:latest us-central1-docker.pkg.dev/seismic-vista-405108/diplom/tomcat:${env.BUILD_NUMBER}"

                sh "docker push us-central1-docker.pkg.dev/seismic-vista-405108/diplom/tomcat:${env.BUILD_NUMBER}"
            }
        }



    }
}
