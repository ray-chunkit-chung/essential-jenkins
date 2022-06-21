pipeline {
    agent any
    stages {
        stage('ssh key login') {
            steps {
                echo "===== ssh key login ====="
                withCredentials([
                    sshUserPrivateKey(credentialsId: "user", keyFileVariable: "keyfile")
                ]) {
                    sh "chmod 600 ${keyfile}"
                    sh "ssh -o StrictHostKeyChecking=no -i ${keyfile} user@example.com 'echo hello'"
                }
            }
        }
    }
}
