@Library('shared-library-jenkins') _

pipeline {
    agent any

    environment {
        registry = "670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr"
        imagename = "sprintboot"
        tagname = "V1"
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
        stage('Building image') {
            steps {
               script {
                   dockerImage = docker.build("${registry}/${imagename}:${tagname}")
             }
          }
       }
       stage('Docker Image Scan: trivy') {
           steps {
              script {
            // Define the Docker image to be scanned
                  def imageName = "${registry}/${imagename}:${tagname}"
            
            // Execute Trivy scan on the Docker image
                  sh "trivy image ${imageName}"
            }
          }
       }
      stage('Docker Image Push : ECR '){
          steps{
              script{
                  dockerImagePush("${registry}/${imagename}:${tagname}")
              }
          }
      }
    }
}
