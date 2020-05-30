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
        stage('Security Testing with Aqua') {
            steps { 
                aquaMicroscanner imageName: 'esteve55/cloudcapstone', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
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
        stage('Create a configuration file for kubectl cluster') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        aws eks --region us-west-2 update-kubeconfig --name capstonecluster
                    '''
                }
            }
        }
        stage('Set current kubctl context to the cluster') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        kubectl config use-context arn:aws:eks:us-west-2:609124127185:cluster/capstonecluster
                    '''
                }
            }
        }
        stage('Create the blue replication controller with its docker image') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        kubectl apply -f ./blue-controller.json
                    '''
                }
            }
        }
        stage('Create the green replication controller with its docker image') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        kubectl apply -f ./green-controller.json
                    '''
                }
            }
        }
        stage('Create the service in kubernetes cluster to the blue replication controller') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        # Create the service in kubernetes cluster in charge of routing traffic
                        # to the blue replication controller and exposing it to the outside
                        # world by setting the selector to app=blue
                        kubectl apply -f ./blue-service.json
                    '''
                }
            }
        }
        stage('Wait until the user gives the instruction to continue') {
            steps {
                input('Do you want to redirect to green?')
            }
        }
        stage('Update the service to redirect to green by changing the selector to app=green') {
            steps {
                withAWS(region:'us-west-2',credentials:'aws-static') {
                    sh '''
                        kubectl apply -f ./green-service.json
                    '''
                }
            }
        }
    }
}
