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
          steps {
            withAWS(region:'us-west-2', credentials:'capstone-user') {
              withKubeConfig(credentialsId: 'aws-static', serverUrl: 'https://86E92CDB703B677524FFCAEF59CAA16F.gr7.us-west-2.eks.amazonaws.com') {
                sh '''kubectl get nodes'''
                sh '''kubectl set image deployment/udctycapstone  udctycapstone=brea/udcty-capstone:""$BUILD_ID"'''
                sh '''kubectl rollout status -w deployment/udctycapstone'''
                sh '''kubectl get nodes'''
              }
            }
          }
    }
}
