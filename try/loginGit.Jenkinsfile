pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage ('Checkout git'){
            steps {
                echo '===== Checkout git ====='
                git branch: 'main',
                    credentialsId: 'ray-chunkit-chung',
                    url: 'git@github.com:ray-chunkit-chung/essential-jenkins.git'
                sh "ls -lat"
            }
        }
    }

}

// pipeline {
//     agent any
//     stages {
//         stage ('Checkout git'){
//             steps {
//                 echo '===== Checkout git ====='
//                 git changelog: false,
//                     poll: false,
// 		       branch: 'main:latest',
//                     credentialsId: 'ray-chunkit-chung',
//                     url: 'git@github.com:ray-chunkit-chung/essential-jenkins.git'
//                 sh "ls -lat"
//             }
//         }
//     }
// }
