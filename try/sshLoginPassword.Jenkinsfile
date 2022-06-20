pipeline {
    agent {
        label "linux"
    }
    stages {
        stage('ssh login password') {
            steps {
                echo "===== ssh login password ====="
                withCredentials([
                    usernamePassword(credentialsId: "${params.user}", usernameVariable: "user", passwordVariable: "pwd")
                ]) {
                    sh "sshpass -p ${pwd} ssh -o StrictHostKeyChecking=no '${user}@example.com' 'echo hello'"
                }
            }
        }
    }
}
