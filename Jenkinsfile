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




	}
}
