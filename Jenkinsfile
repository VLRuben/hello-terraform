pipeline {
    agent any
    
    options {
        timestamps()
    }

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'ruben-aws-credentials') {
                sh 'terraform fmt'
                sh 'terraform apply -auto-approve'
                }                  
            }
        }
    }
    
}