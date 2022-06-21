pipeline {
    agent {
        label any
    }
    stages {
        stage ('Checkout git'){
            steps {
                git changelog: false,
                    poll: false,
					          branch: 'main:latest',
                    credentialsId: 'ray-chunkit-chung',
                    url: 'git@github.com:ray-chunkit-chung/essential-jenkins.git'
                sh "ls -lat"
            }
        }
    }
