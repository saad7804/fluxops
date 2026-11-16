
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'saadmomin7804/fluxops'
        K8S_NAMESPACE = 'fluxops'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out FluxOps source code'
                checkout scm
            }
        }

        stage('Code Quality Checks') {
            steps {
                sh '''
                    docker run --rm \
                    -v "$WORKSPACE:/app" \
                    -w /app \
                    node:20-alpine \
                    sh -c "npm ci && npm run lint && npm run typecheck"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build \
                    -t $DOCKER_IMAGE:$BUILD_NUMBER \
                    -t $DOCKER_IMAGE:latest .
                '''
            }
        }

        stage('Docker Hub Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker_creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        set +x
                        echo "$DOCKER_PASS" | docker login \
                        -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                    docker push $DOCKER_IMAGE:$BUILD_NUMBER
                    docker push $DOCKER_IMAGE:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(
                    credentialsId: 'kubeconfig',
                    variable: 'KUBECONFIG_FILE'
                )]) {
                    sh '''
                        export KUBECONFIG="$KUBECONFIG_FILE"

                        kubectl create namespace $K8S_NAMESPACE \
                        --dry-run=client -o yaml | kubectl apply -f -

                        kubectl apply -f deployment.yml
                        kubectl apply -f service.yml

                        kubectl set image deployment/fluxops \
                        fluxops=$DOCKER_IMAGE:$BUILD_NUMBER \
                        -n $K8S_NAMESPACE

                        kubectl rollout status deployment/fluxops \
                        -n $K8S_NAMESPACE --timeout=180s
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withCredentials([file(
                    credentialsId: 'kubeconfig',
                    variable: 'KUBECONFIG_FILE'
                )]) {
                    sh '''
                        export KUBECONFIG="$KUBECONFIG_FILE"

                        echo "Deployment:"
                        kubectl get deployments -n $K8S_NAMESPACE

                        echo "Pods:"
                        kubectl get pods -n $K8S_NAMESPACE

                        echo "Service:"
                        kubectl get service -n $K8S_NAMESPACE
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'FluxOps CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'FluxOps CI/CD pipeline failed. Check Console Output.'
        }

        always {
            sh 'docker logout || true'
        }
    }
}
