pipeline {
  agent {
    docker {
      image 'davidcozens/booktools:12'
      registryCredentialsId 'dockerhub'
    }
  }
  stages {
    stage('build') {
      steps{
        sh 'make -j'
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
