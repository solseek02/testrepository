pipeline {
    agent any

    environment {
        KUBECONFIG = "/home/fedora/.kube/config"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/your-username/testrepository.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'eval export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.49.2:2376"
export DOCKER_CERT_PATH="/home/fedora/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"

# To point your shell to minikube's docker-daemon, run:
# eval $(minikube -p minikube docker-env)'
                    sh 'docker build -t myapp:latest .'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}
