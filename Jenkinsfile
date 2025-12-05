pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mujaheed00/mynginximage"
    }

    stages {
        stage('Clone Repo') {
            steps {
                    sh '''
                    git clone https://$GIT_USER:$GIT_TOKEN@github.com/mujaheed00/docker-nginx-app.git
                    '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd docker-nginx-app
                docker build -t $DOCKER_IMAGE .
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                docker push $DOCKER_IMAGE
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker run -d --name mynginx -p 80:80 $DOCKER_IMAGE
                '''
            }
        }
    }
}
