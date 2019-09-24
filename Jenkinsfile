
pipeline {
    agent any
    stages {
        stage('Lint HTML'){
          steps{
            sh 'tidy -q -e static-html/*.html'
          }
        }

    }
}
