pipeline {
    agent {
        label any

    }
    stages {
        stage ('Checkout'){
            steps {
                git changelog: false,
                    poll: false,
					branch: 'main',
    				credentialsId: 'user',
                    url: 'ssh://git@git.com/user.git'
            }
        }
        stage ('Test'){
            steps {
                sh 'python app/test.py'
            }
        }
    }
}
