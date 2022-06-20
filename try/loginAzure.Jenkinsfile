pipeline {
    agent {
        label "linux"
    }
    stages {
        stage ('Checkout git'){
            steps {
                git changelog: false,
                    poll: false,
					branch: 'main:latest',
    				credentialsId: 'user',
                    url: 'ssh://git@git.com/user.git'
            }
        }

         stage('docker') {
             steps {
                 sh 'docker run --rm -it $(docker build -q .)'
             }
         }

        stage ('azure'){
            steps {
                sh 'az login -u ${params.user} -p ${params.password}'
                sh 'az deployment group create --subscription ${params.SUBSCRIPTION_NAME} \
                           --resource-group ${params.RESOURCEGROUP_NAME} \
                           --template-file template.json \
                           --parameters parameters.json'
            }
        }
    }
}
