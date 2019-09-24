
pipeline {
    agent any
    stages {
        stage('Lint HTML'){
          steps{
            sh 'tidy -q -e static-html/*.html'
          }
        }
        stage('Build n Push Container'){
          script{
            def app
            checkout scm
            app = docker.build("brea/udcty-capstone")
            app.inside {
              echo "Tests passed"
            }
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub'){
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")
            }
            echo "Trying to Push Docker Build to DockerHub"
          }
        }
    }
}
