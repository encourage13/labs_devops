pipeline {
    agent any

    environment {
        PYTHON = 'python3'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Service Checks') {
            parallel {
                // Ветка для FastAPI-service
                stage('Python Service') {
                    stages {
                        stage('Python: Setup Environment') {
                            when {
                                changeset "FastAPI-service/**"
                            }
                            steps {
                                dir('python-service') {
                                    sh '${PYTHON} -m pip install -r requirements.txt'
                                    sh '${PYTHON} -m pip install -r requirements-dev.txt'
                                }
                            }
                        }
                        stage('Python: Compilation Check') {
                            when {
                                changeset "python-service/**"
                            }
                            steps {
                                dir('python-service') {
                                    sh """
                                        ${PYTHON} -m py_compile server.py
                                        ${PYTHON} -m py_compile voicegen.py
                                        ${PYTHON} -m py_compile model_loader.py
                                    """
                                }
                            }
                        }
                        stage('Python: Linting') {
                            when {
                                changeset "python-service/**"
                            }
                            steps {
                                dir('python-service') {
                                    sh 'ruff check .'
                                }
                            }
                        }
                        stage('Python: TODO Check') {
                            when {
                                changeset "python-service/**"
                            }
                            steps {
                                dir('python-service') {
                                    sh 'bash ci-check.sh'
                                }
                            }
                        }
                        stage('Python: Tests') {
                            when {
                                changeset "python-service/**"
                            }
                            steps {
                                dir('python-service') {
                                    sh 'pytest tests/ -v --tb=short'
                                }
                            }
                        }
                    }
                }

                // Ветка для node-service
                stage('Node.js Service') {
                    stages {
                        stage('Node: Setup Environment') {
                            when {
                                changeset "node-service/**"
                            }
                            steps {
                                dir('node-service') {
                                    sh 'npm install'
                                }
                            }
                        }
                        stage('Node: Linting') {
                            when {
                                changeset "node-service/**"
                            }
                            steps {
                                dir('node-service') {
                                    sh 'npm run lint'
                                }
                            }
                        }
                        stage('Node: Tests') {
                            when {
                                changeset "node-service/**"
                            }
                            steps {
                                dir('node-service') {
                                    sh 'npm test'
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'Build failed. Check the console output for details.'
        }
        success {
            echo 'Build completed successfully.'
        }
    }
}