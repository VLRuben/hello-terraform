pipeline {
    agent any
    
    options {
        timestamps()
        ansiColor("xterm")
    }

    stages {
            stage('Build and tag') {
                steps {
                    sh 'docker-compose build'
		            sh 'docker tag ghcr.io/vlruben/hello-terraform/hello-terraform:latest ghcr.io/vlruben/hello-terraform/hello-terraform:1.0${BUILD_NUMBER}'
		            sh 'git tag 1.0${BUILD_NUMBER}'
                }
            }

            stage('Package and push') {
                steps {
                    withCredentials([string(credentialsId: 'lucatic github', variable: 'CR_PAT')]) {
                        sh "echo $CR_PAT | docker login ghcr.io -u VLRuben --password-stdin"  
                        sh 'docker-compose push'
                        sh 'docker push ghcr.io/vlruben/hello-terraform/hello-terraform:1.0${BUILD_NUMBER}' 
                    }
		                sshagent(['ssh-github']) {
                            sh """ 
                                git push --tags 
                            """
                        }
                }
            }
            stage('Deploy') {
                steps {
                    withAWS(credentials: 'ruben-aws-credentials') {
                        sshagent(['amazon-ssh']) {
                            sh 'terraform init'
                            sh 'terraform fmt'
                            sh 'terraform validate'
                            withCredentials([string(credentialsId: 'lucatic github', variable: 'CR_PAT')]) {
                                sh "echo $CR_PAT | docker login ghcr.io -u VLRuben --password-stdin"  
                                sh 'terraform apply -auto-approve'
                            }
                        }                  
                    }
                }
            
            }
            stage ('Ansible playbook call') {
                steps{
                    withAWS(credentials: 'ruben-aws-credentials') {
                        ansiblePlaybook credentialsId: 'amazon-ssh', inventory: 'aws_ec2.yml', playbook: 'hello-2048.yml', vaultCredentialsId: 'lucatic github'
                    }
                }
            }
    }
}