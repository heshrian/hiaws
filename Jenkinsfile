pipeline {
    environment {
      registry = 'heshrian/helloworld'
      registryCredential = 'dockerhub'
      dockerImage = ''
    }
    agent any
    stages {
        stage('Cloning Git Repo') {
            steps {
                git 'https://github.com/heshrian/hiaws.git'
            }
        }
        stage('Build the app') {
            steps {
                sh 'npm install'
            }
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry
                    }
                }	
            }
        stage ('Deploy image'){
            steps{
                script{
                    docker.withRegistry( '',registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to AWS'){
                when{
                    branch 'master'
                }
            steps {
                withAWS(region:'eu-west-2',credentials:'awsmalachite2'){
                    sh 'sh ./deploy.sh'
                }
            }
        }
    }
}

