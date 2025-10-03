pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'docker-hub-pass' // Your Jenkins Docker Hub credential ID
        IMAGE_NAME = 'leeshalulu01/webapp'
        IMAGE_TAG = '1.0'
        DEPLOY_HOST = 'ec2-user@<EC2-PUBLIC-IP>'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/leeshalulu01/webapp-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS,
                        passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sh "ansible-playbook deploy.yml -i ${DEPLOY_HOST}, --private-key /path/to/your/key.pem"
            }
        }
    }
}
