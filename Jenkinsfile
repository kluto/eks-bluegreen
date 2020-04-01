pipeline {
	agent any
	
  stages {

		stage('Start build') {
			steps {
		    		echo "Check out from version control"
			}
	  }
		
		stage('Lint') {
			steps {
				echo 'Linting HTML'
				sh 'tidy -q -e *.html'
				echo 'Linting Dockerfile'
				sh '/home/ubuntu/hadolint Dockerfile'
			}
		}				

		stage('Docker') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', 
          credentialsId: 'dockerhub', 
          usernameVariable: 'DOCKER_USERNAME', 
          passwordVariable: 'DOCKER_PASSWORD']]){
          echo 'Build image'
          sh 'docker build -t revtec/cloudcap:$BUILD_ID .'    
          echo 'Push to dockerhub'
          sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'	
          sh 'docker push revtec/cloudcap:$BUILD_ID'
          echo 'Clean up...'
          sh 'docker rmi revtec/cloudcap:$BUILD_ID'
        }         
      }
  	}	
    
    stage('Set current kubectl context') {
      steps {
        withAWS(region:'us-east-1', credentials:'AWSCredentials') {
          sh 'kubectl config view'
          sh 'kubectl config use-context arn:aws:eks:us-east-1:124880580859:cluster/duckhunt'
      }
    }    
    


	}
}
