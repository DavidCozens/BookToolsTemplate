pipeline {
  agent {
    docker {
      image 'pandoc/core'
      args '--entrypoint=\'\''
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
