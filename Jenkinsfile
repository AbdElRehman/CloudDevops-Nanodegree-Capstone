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
                withAWS(credentials:'aws-static') {
                    script {
                        def login = ecrLogin()
                        sh "${login}"
                    }
                }
            }
        }
        
        stage("Push Docker AWS ECR") {
            steps {
                sh "docker push ${aws_registry}"
            }
        }
      
        stage('K8S Deploy') {
            steps {
				withAWS(credentials: 'jenkins', region: 'us-west-2') {
				    //Configures kubectl so that you can connect to an Amazon EKS cluster
					
					sh "aws eks --region us-west-2 update-kubeconfig --name EKS_Cluster"
					// Configure deployment
					
					sh "kubectl apply -f KES_Deployment/Deployment.yml"
					// Configure service
					
					sh "kubectl apply -f KES_Deployment/Service.yml"
					
				}
          }
        }
    }
}
