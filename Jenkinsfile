@Library('shared-library-jenkins') _

pipeline {
    agent any

    parameters{

        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')        
        string(name: 'aws_account_id', description: " AWS Account ID", defaultValue: '670855725719')
        string(name: 'Region', description: "Region of ECR", defaultValue: 'ap-south-1')
        string(name: 'ECR_REPO_NAME', description: "name of the ECR", defaultValue: 'testecr')
        
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                script {
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/Anjanmurthyv/java-springboot.git"
                    )
                }
            }
        }
        stage('Unit Test maven') {
            steps {
                script {
                    mvnTest()
                }
            }
        }
        stage('Integration Test maven') {
            
            steps {
                script {
                    mvnIntegrationTest()
                }
            }
        }
        stage('Static code analysis: Sonarqube'){
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonar-token'
                   statiCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }
        stage('Quality Gate Status Check : Sonarqube'){
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonar-token'
                   QualityGateStatus(SonarQubecredentialsId)
               }
            }
        }
        stage('Maven Build : maven'){
            steps{
               script{
                   
                   mvnBuild()
               }
            }
        }
        stage('Docker Image Build : ECR'){
             steps{
                script{
                   
                    dockerBuild("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}","${params.ImageName}","${params.ImageTag}")
                }
             }
         }
    }
}
