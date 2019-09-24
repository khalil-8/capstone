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
                  //sh 'docker run -d -p 8000:80 brea/udcty-capstone:$BUILD_ID'
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

    stage('Deploy image to EKS cluster') {
      steps {
        withAWS(credentials:'aws-static', region:'us-west-2') {
          sh 'aws iam get-user'
        //  withKubeConfig(credentialsId: 'aws-static', serverUrl: 'https://86E92CDB703B677524FFCAEF59CAA16F.gr7.us-west-2.eks.amazonaws.com') {
          //  sh '''kubectl get nodes'''
            //sh '''kubectl set image deployment/udcty-capstone  udacitycapstone=brea/udcty-capstone:""$BUILD_ID"'''
            //sh '''kubectl rollout status -w deployment/udcty-capstone'''
            //sh '''kubectl get nodes'''
          }
        }
      }



     }
}
}
