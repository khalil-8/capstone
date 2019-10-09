pipeline {
  environment {
      registry = "brea/udcty-capstone"
      registryCredential = 'dockerhub'
  }
     agent any
     stages {
     stage('Lint HTML check') {
         steps {
         sh 'tidy -q -e static-html/*.html'
         }
      }
   stage ('Cloning git repo') {
    steps{
      git 'https://github.com/khalil-8/capstone.git'
    }
   }
	 stage ('Build the image.'){
         steps {
             script {
                  dockerImage=docker.build registry + ":$BUILD_NUMBER"
             }
         }
     }

     stage ('Push image') {
	     steps {
		 script {
           docker.withRegistry('https://registry.hub.docker.com', 'docker-hub'){
               dockerImage.push()
           }
           echo "Trying to Push Docker Build to DockerHub"
          }
	     }
	   }

    stage('Deploy image to EKS cluster') {
      steps {
        withAWS(region:'us-west-2',credentials:'aws-static') {
            sh '''aws eks --region us-west-2 update-kubeconfig --name terraform-eks-demo'''
            sh '''kubectl get nodes'''
            sh '''kubectl rolling-update udacitycapstone --image=udacitycapstone=brea/udcty-capstone:"$BUILD_ID"'''
            sh '''kubectl rollout status -w deployment/udacitycapstone'''
            sh '''kubectl scale deployment/udacitycapstone --replicas=3'''
            sh '''kubectl get pods -o wide'''
            sh '''kubectl describe deployment udacitycapstone'''
            sh '''kubectl get pods'''
            sh '''kubectl get nodes'''
        }
      }
     }
}
}
