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
              //withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']])
              {
                  dockerImage=docker.build registry + ":$BUILD_NUMBER"
                  sh 'docker run -d -p 80:80 brea/udcty-capstone:$BUILD_ID'
              }
             }
         }
     }

     stage ('Push image') {
	     steps {
		 script {
           //docker.withRegistry('',registryCredential ) {
           docker.withRegistry('https://registry.hub.docker.com', 'docker-hub'){
               dockerImage.push()
           }
           echo "Trying to Push Docker Build to DockerHub"
          }
	     }
	   }

//     stage('Deploy image to EKS cluster') {
//      steps {
//        withAWS(region:'us-west-2', credentials:'aws-static') {
//          withKubeConfig(credentialsId: 'eks-kubeconfig', serverUrl: 'https://F546C20FB5862EF69073FF0D40ACDB40.gr7.us-west-2.eks.amazonaws.com') {
//            sh '''kubectl get nodes'''
//            sh '''kubectl set image deployment/udacitycapstone  udacitycapstone=alex1311/udacitycapstone:""$BUILD_ID"'''
//            sh '''kubectl rollout status -w deployment/udacitycapstone'''
//            sh '''kubectl get nodes'''
//          }
//        }
//      }



     }
}
}
