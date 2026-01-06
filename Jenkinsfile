pipeline {
    agent any
    
    environment {
        DOCKER_REPO = "ganesamoorthir"
        IMAGE_NAME = "devops-project03"
        IMAGE_TAG = "v1"
        K8S_NAMESPACE = "default"
    }

    triggers {
        githubPush()
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: "master",
                url: "https://github.com/GanesamoorthiR/beginner-html-site-styled.git"
            }
        }
        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh '''
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        '''
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh """
                    docker push ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
                """      
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    kubectl apply -n ${K8S_NAMESPACE} -f k8s/deployment.yaml
                    kubectl apply -n ${K8S_NAMESPACE} -f k8s/service.yaml
                """
            }
        }
    }
    post {
        success {
            echo 'Build and Deployment Successful!'
        }
        failure {
            echo 'Build or Deployment Failed!'
        }
    }
}
