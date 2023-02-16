pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Build') {
            steps {
                echo 'Build'
		sh 'docker tag ghcr.io/vlruben/hello-2048/hello-2048:latest ghcr.io/vlruben/hello-2048/hello-2048:1.0${BUILD_NUMBER}'
		sh 'git tag 1.0${BUILD_NUMBER}'
            }
        }
        stage('Package') {
            steps {
                sh 'docker-compose build'
                withCredentials([string(credentialsId: 'lucatic github', variable: 'CR_PAT')]) {
                sh "echo $CR_PAT | docker login ghcr.io -u VLRuben --password-stdin"
				   
                }
                sh 'docker push ghcr.io/vlruben/hello-2048/hello-2048:1.0${BUILD_NUMBER}' 
		sshagent(['ssh-github']) {
		sh """ 
			git push --tags 
		   """
		}
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['amazon-ssh']) {
                    sh """
                        ssh -o "StrictHostKeyChecking no" ec2-user@ec2-52-210-71-14.eu-west-1.compute.amazonaws.com docker-compose pull
                        ssh ec2-user@ec2-52-210-71-14.eu-west-1.compute.amazonaws.com docker-compose up -d
                        
                    """
                    
                }
            }
        }
    
    }
}
