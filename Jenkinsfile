pipeline {
  agent {
    docker {
      image 'pandoc/core'
      args '-v $WORKSPACE:/data'
      registryCredentialsId 'dockerhub'
    }
  }
  stages {
    stage('epub') {
      steps{
        sh 'pandoc  --toc --epub-embed-font=\'fonts/*.ttf\' -o book.epub metadata.txt contents.md'
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}