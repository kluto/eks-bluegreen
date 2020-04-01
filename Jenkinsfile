pipeline {
	agent any
	stages {
		stage('Lint HTML') {
			steps {
				sh 'tidy -q -e *.html'
			}
		}
		stage('Lint Dockerfile') {
			steps {
				echo 'Test commit...'
				sh '/home/ubuntu/hadolint Dockerfile'
			}
		}				




	}
}
