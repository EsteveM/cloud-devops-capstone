pipeline {
    agent any
    stages {
        stage('Linting') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build the Docker image') {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
                    sh '''
                        docker build -t esteve55/cloudcapstone .
                    '''
                }
            }
        }
        stage('Upload image to Docker') {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
                    sh '''
                        dockerpath="$DOCKER_USERNAME/cloudcapstone"
                        echo "Docker ID and Image: $dockerpath"
                        my_password="$DOCKER_PASSWORD"
                        echo "$my_password" | docker login --username $DOCKER_USERNAME --password-stdin
                        docker push $dockerpath
                    '''
                }
            }
        }
    }
}
