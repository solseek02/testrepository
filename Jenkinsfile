pipeline {
    agent any

    environment {
        // Minikube 환경 변수 설정
        DOCKER_TLS_VERIFY = '1'
        DOCKER_HOST = 'tcp://192.168.58.2:2376'
        DOCKER_CERT_PATH = '/var/lib/jenkins/.minikube/certs'
        MINIKUBE_ACTIVE_DOCKERD = 'minikube'
        KUBECONFIG = '/home/fedora/.kube/config'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/solseek02/testrepository.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t myapp:latest .
                '''
            }
        }

        stage('Push Docker Image to Minikube') {
            steps {
                sh '''
                minikube image load myapp:latest
                '''
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml
                '''
            }
        }

        stage('Expose Service via Ngrok') {
            steps {
                sh '''
                nohup ngrok http 8080 > /dev/null 2>&1 &
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline completed!"
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}

