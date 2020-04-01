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

		stage('Build Docker Image') {
   			steps {
    			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
      			        sudo docker build -t revtec/cloudcap:$BUILD_ID .
     			    '''    
                }
            }
  		}	


	}
}
