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

    stage('Docker blue container') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', 
          credentialsId: 'dockerhub', 
          usernameVariable: 'DOCKER_USERNAME', 
          passwordVariable: 'DOCKER_PASSWORD']]){
          echo 'Build image'
          sh 'docker build -f blue/Dockerfile -t revtec/blueimage:latest .'    
          echo 'Push to dockerhub'
          sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'	
          sh 'docker push revtec/blueimage:latest'
          echo 'Clean up...'
          sh 'docker rmi revtec/blueimage:latest'
        }         
      }
    }	

    stage('Docker green container') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', 
          credentialsId: 'dockerhub', 
          usernameVariable: 'DOCKER_USERNAME', 
          passwordVariable: 'DOCKER_PASSWORD']]){
          echo 'Build image'
          sh 'docker build -f green/Dockerfile -t revtec/greenimage:latest .'    
          echo 'Push to dockerhub'
          sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'	
          sh 'docker push revtec/greenimage:latest'
          echo 'Clean up...'
          sh 'docker rmi revtec/greenimage:latest'
        }         
      }
    }

    stage('Set kubectl context') {
      steps {
        withAWS(region:'us-west-2', credentials:'aws_pipeline') {
          sh 'kubectl config view'
          sh 'kubectl config use-context arn:aws:eks:us-west-2:966717982209:cluster/big-cheese'
        }
      }
    }    

    stage('Blue deployment') {
      steps {
        withAWS(region:'us-west-2', credentials:'aws_pipeline') {
          sh 'kubectl apply -f blue/deploy-blue.yml'
        }
      }
    }

    stage('Green deployment') {
      steps {
        withAWS(region:'us-west-2', credentials:'aws_pipeline') {
          sh 'kubectl apply -f green/deploy-green.yml'
        }
      }
    }     


    stage('Direct to colour') {
      steps {
        withAWS(region:'us-west-2', credentials:'aws_pipeline') {
          sh 'kubectl apply -f bluegreen-service.yml'
        }
      }
    }   



  }
}
