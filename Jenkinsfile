pipeline {
  agent {
    docker {
      image 'pandoc/core'
      args '-it --entrypoint=/bin/sh'
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
}
