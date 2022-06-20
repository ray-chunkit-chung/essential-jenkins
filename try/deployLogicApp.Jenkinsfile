pipeline {
    agent {
        // label '("Machine 1 (10.0.0.0)" || "Machine 2 (10.0.0.1)")'
        label "linux"
    }
    options {
        timestamps()
        timeout(time: 4, unit: 'HOURS')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: "30", artifactNumToKeepStr: "3"))
    }
    stages {
        stage ('Checkout'){
            steps {
                git changelog: false,
                    poll: false,
					branch: 'master:latest',
    				credentialsId: 'user',
                    url: 'ssh://git@git.git'
            }
        }

        // stage('Build & test') {
        //     steps {
        //         sh 'docker run --rm -it $(docker build -q .)'
        //     }
        // }

        stage ('Deploy'){
            steps {
                sh 'az login'
                sh 'az deployment group create --subscription ${params.SUBSCRIPTION_NAME} \
                           --resource-group ${params.RESOURCEGROUP_NAME} \
                           --template-file ArmTemplate/logicApp/template.json \
                           --parameters ArmTemplate/logicApp/parameters.json'
            }
        }
    }

    post {
        always {
            echo "=====Post Notification====="

            script {
                emailext(
                        recipientProviders: [
                            [$class: 'DevelopersRecipientProvider'],
                            [$class: 'RequesterRecipientProvider']
                        ],
                        to: "",
                        subject: '${BUILD_NUMBER} - ${BUILD_STATUS}',
                        body: "${BUILD_URL}",
                        attachLog: true
                        )
            }
        }
    }
}
