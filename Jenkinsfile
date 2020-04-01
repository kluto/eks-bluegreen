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
        sh 'tidy -q -e */*.html'
        echo 'Linting Dockerfile(s)'
        sh '/home/ubuntu/hadolint blue/Dockerfile'
        sh '/home/ubuntu/hadolint green/Dockerfile'
      }
    }				

    stage('Docker') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', 
          credentialsId: 'dockerhub', 
          usernameVariable: 'DOCKER_USERNAME', 
          passwordVariable: 'DOCKER_PASSWORD']]){
          echo 'Build image'
          sh 'docker build -f blue/Dockerfile -t revtec/blueimage:$BUILD_ID .'    
          echo 'Push to dockerhub'
          sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'	
          sh 'docker push revtec/blueimage:$BUILD_ID'
          echo 'Clean up...'
          sh 'docker rmi revtec/blueimage:$BUILD_ID'
        }         
      }
    }	
    
    stage('Set current kubectl context') {
      steps {
        withAWS(region:'us-west-2', credentials:'aws_pipeline') {
          sh 'kubectl config view'
          sh 'sudo kubectl config use-context arn:aws:eks:us-west-2:966717982209:cluster/big-cheese'
          
  }
      }
    }    
    


  }
}
