pipeline {
  agent {
    docker {
      image 'davidcozens/booktools:2'
      registryCredentialsId 'dockerhub'
    }
  }
  stages {
    stage('epub') {
      steps{
        sh 'pandoc  --from markdown+emoji --toc -o book.epub metadata.yaml contents.md'
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
