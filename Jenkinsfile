@Library('shared-library-jenkins') _

pipeline {
    agent any

    environment {
        registry = "670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr"
        imagename = "springboot"
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
        stage('Unit Test Maven') {
            steps {
                script {
                    mvnTest()
                }
            }
        }
        stage('Integration Test Maven') {
            steps {
                script {
                    mvnIntegrationTest()
                }
            }
        }
        stage('Static Code Analysis: SonarQube') {
            steps {
                script {
                    def sonarQubeCredentialsId = 'sonar-token'
                    staticCodeAnalysis(sonarQubeCredentialsId)
                }
            }
        }
        stage('Quality Gate Status Check: SonarQube') {
            steps {
                script {
                    def sonarQubeCredentialsId = 'sonar-token'
                    qualityGateStatus(sonarQubeCredentialsId)
                }
            }
        }
        stage('Maven Build') {
            steps {
                script {
                    mvnBuild()
                }
            }
        }
        stage('Building Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${registry}/${imagename}:${tagname}")
                }
            }
        }
        stage('Docker Image Scan: Trivy') {
            steps {
                script {
                    def imageName = "${registry}/${imagename}:${tagname}"
                    sh "trivy image ${imageName}"
                }
            }
        }
        stage('Docker Image Cleanup: ECR') {
            steps {
                script {
                    dockerImageCleanup("${registry}/${imagename}:${tagname}")
                }
            }
        }
    }
}
