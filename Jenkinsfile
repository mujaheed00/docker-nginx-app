pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mujaheed00/mynginximage"
    }

    stages {
        stage('Clone Repo') {
            steps {
                // Clone private repo using GitHub PAT
                withCredentials([usernamePassword(credentialsId: 'GITHUB_CRED', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                    sh '''
                    git clone https://$GIT_USER:$GIT_TOKEN@github.com/mujaheed00/docker-build-pipeline.git
                    ls -l docker-build-pipeline
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd docker-build-pipeline
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
                docker rm -f mynginx || true
                docker run -d --name mynginx -p 80:80 $DOCKER_IMAGE
                '''
            }
        }
    }
}
