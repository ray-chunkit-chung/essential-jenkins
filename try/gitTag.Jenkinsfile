pipeline {
    agent {
        label any
    }
    environment {
        NEW_TAG = "${BUILD_NUMBER}"
        GIT_URL = "ssh://git@git.com/user.git"
    }
    stages {

        stage ('git checkout') {
            steps {
                echo "===== git checkout ====="
                git branch: 'main',
                    credentialsId: 'user',
                    url: '${GIT_URL}'
                sh 'ls -lat'
                sh 'git tag ${NEW_TAG}'
                sh 'git push origin ${NEW_TAG}'
            }
        }
    }
}
