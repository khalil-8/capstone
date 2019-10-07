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
        withAWS(region:'us-west-2',credentials:'aws-static') {
          //sh 'aws iam get-user'
          //withKubeConfig(credentialsId: 'eks-auth', serverUrl: 'https://6908C89A2FD44AD7FEDA4EC93B383D8A.gr7.us-west-2.eks.amazonaws.com') {
            sh '''aws eks --region us-west-2 update-kubeconfig --name terraform-eks-demo'''
            sh '''kubectl get nodes'''
            sh '''kubectl -n  get pods'''
            sh '''kubectl run udacitycapstone --image=brea/udcty-capstone:"$BUILD_ID" --port=80 --expose=true'''
            //sh '''kubectl set image deployments/udacitycapstone udacitycapstone=brea/udcty-capstone:"$BUILD_ID"'''
            //sh '''kubectl rollout status -w deployment/udacitycapstone'''
            //sh '''kubectl get pods'''
            //sh '''kubectl describe deployment udacitycapstone'''
            //sh '''kubectl set image deployment/udcty-capstone  udacitycapstone=brea/udcty-capstone:""$BUILD_ID"'''
            //sh '''kubectl rollout status -w deployment/udcty-capstone'''
            //sh '''kubectl get nodes'''
          //}
        }
      }



     }
}
}
