pipeline {
    agent any
    environment {
        registry = '768362009725.dkr.ecr.us-east-1.amazonaws.com/capstone_udacity_project:latest'
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
    }
}