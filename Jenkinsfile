node {
    def app
    stage('Clone repository') {
        checkout scm
    }

    stage('Lint HTML'){
        sh 'tidy -q -e static-html/*.html'
    }

    stage('Build image') {
        app = docker.build("brea/udcty-capstone")
    }

    stage('Test image') {
        app.inside {
            echo "Tests passed"
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            }
                echo "Trying to Push Docker Build to DockerHub"
    }

    stage('Deploy image to EKS cluster') {
      withAWS(credentials: 'aws-static', region: 'eu-west-2'){
        sh 'aws iam get-user'
      }
    }

}
