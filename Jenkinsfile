pipeline {
    agent any

    environment {
        // Minikube Docker 환경 설정
        KUBECONFIG = "/home/fedora/.kube/config"
    }

    triggers {
        // GitHub에서 push 이벤트 발생 시 트리거
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning Repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                script {
                    // Minikube Docker 환경 변수 설정
                    sh 'eval $(minikube docker-env)'
                    // Docker 이미지 빌드
                    sh 'docker build -t myapp:latest .'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                echo 'Deploying to Minikube...'
                script {
                    // Kubernetes 배포 적용
                    sh 'kubectl apply -f deployment.yaml'
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

