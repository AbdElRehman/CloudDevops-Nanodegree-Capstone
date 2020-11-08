pipeline {
    agent any
    environment {
        aws_registry = '664117675373.dkr.ecr.us-east-1.amazonaws.com/udacity:latest'
    }
    stages {
    
        stage("lint HTML") {
           steps {
                 sh 'tidy -q -e *.html'
            }
        }
        stage("Lint Dockerfile") {
			steps {
				sh "hadolint Dockerfile"
			}
		}
		
		stage("Build Docker Image") {
            steps {
                sh "docker build -t helloworldapp ."
                sh "docker tag helloworldapp:latest ${aws_registry}"
            }
        }
        
        stage("Login to AWS ECR") {
            steps {
                sh "eval \$(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 664117675373.dkr.ecr.us-east-1.amazonaws.com)"
            }
        }
        
        stage("Push Docker AWS ECR") {
            steps {
                sh "docker push ${aws_registry}"
            }
        }
    }
}
