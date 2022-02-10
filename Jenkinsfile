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
        sh 'pandoc  --toc --epub-embed-font=\'fonts/*.ttf\' -o book.epub metadata.txt contents.md'
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
