// https://stackoverflow.com/questions/37800195/how-do-you-load-a-groovy-file-and-execute-it

pipeline {
    agent {
        label any

    }
    stages {
        stage ('script in pipeline') {
            steps {
                echo "===== script in pipeline ====="
                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser"
                    }
                }
                echo "===== load groovy functions ====="
                script {
                    def rootDir = pwd()
                    def exampleModule = load "${rootDir}/try/vars/variables.groovy"
                    exampleModule.exampleMethod()
                    exampleModule.otherExampleMethod()
                }
            }
        }
    }
}
