pipeline {
  agent {
    docker {
      image 'davidcozens/booktools:4'
      registryCredentialsId 'dockerhub'
    }
  }
  stages {
    stage('epub') {
      steps{
        sh 'make -r epub'
      }
    }
  }
  post {
    success {
      archiveArtifacts artifacts: '*.epub', followSymlinks: false
    }
    cleanup {
      cleanWs()
    }
  }
}
