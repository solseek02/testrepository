pipeline {
    agent any

    tools {
    git 'Default' 
    }

    environment {
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
    }

    triggers {
        githubPush()  // GitHub Push 이벤트가 발생하면 자동으로 트리거
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning Repository...'
                checkout scm  // GitHub 리포지토리를 체크아웃
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                script {
                    sh 'eval $(minikube -p minikube docker-env)'  // Minikube Docker 환경 설정
                    sh 'docker build -t myapp:latest .'  // Docker 이미지 빌드
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                echo 'Deploying to Minikube...'
                script {
                    sh 'kubectl apply -f deployment.yaml'  // Kubernetes 리소스 배포
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
