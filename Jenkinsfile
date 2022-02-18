pipeline {
  agent {
    docker {
      image 'davidcozens/booktools:5'
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
      archiveArtifacts artifacts: '*.epub,*.pdf', followSymlinks: false
    }
    cleanup {
      cleanWs()
    }
  }
}
