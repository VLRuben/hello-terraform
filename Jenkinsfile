pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'ruben-aws-credentials') {
                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform validate'
                    sh 'terraform apply -auto-approve'
                }                  
            }
        }
    }
    
}