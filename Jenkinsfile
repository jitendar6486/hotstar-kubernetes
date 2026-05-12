pipeline{
    agent any

    tools{
        jdk 'jdk'
        nodejs 'node'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {

        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }

        stage('Checkout from Git'){
            steps{
                git branch: 'main',
                credentialsId: 'github-token',
                url: 'https://github.com/Aseemakram19/hotstar-kubernetes.git'
            }
        }

        stage("Sonarqube Analysis"){
            steps{
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=Hotstar \
                    -Dsonar.projectKey=Hotstar
                    '''
                }
            }
        }

        stage("Quality Gate"){
            steps {
                script {
                    waitForQualityGate abortPipeline: false,
                    credentialsId: 'Sonar-token'
                }
            }
        }

        stage('Install Dependencies'){
            steps{
                sh 'npm install'
            }
        }

        stage('OWASP FS SCAN'){
            steps{
                dependencyCheck(
                    additionalArguments: '''
                    --scan .
                    --disableYarnAudit
                    --disableNodeAudit
                    --noupdate
                    ''',
                    odcInstallation: 'DC'
                )

                dependencyCheckPublisher(
                    pattern: '**/dependency-check-report.xml'
                )
            }
        }

        stage('TRIVY FS SCAN'){
            steps{
                sh 'trivy fs . > trivyfs.txt'
            }
        }

        stage("Docker Build & Push"){
            steps{
                script{
                    withDockerRegistry(
                        credentialsId: 'docker',
                        toolName: 'docker'
                    ){

                        sh 'docker build -t hotstar .'

                        sh 'docker tag hotstar aseemakram19/hotstar:latest'

                        sh 'docker push aseemakram19/hotstar:latest'
                    }
                }
            }
        }

        stage("TRIVY IMAGE SCAN"){
            steps{
                sh 'trivy image aseemakram19/hotstar:latest > trivyimage.txt'
            }
        }

        stage('Deploy to container'){
            steps{
                sh '''
                docker rm -f hotstar || true
                docker run -d --name hotstar -p 3000:3000 aseemakram19/hotstar:latest
                '''
            }
        }
    }

    post {
        always {
            script {

                def buildStatus = currentBuild.currentResult

                def buildUser = currentBuild.getBuildCauses(
                    'hudson.model.Cause$UserIdCause'
                )[0]?.userId ?: 'Github User'

                emailext (
                    subject: "Pipeline ${buildStatus}: ${env.JOB_NAME} #${env.BUILD_NUMBER}",

                    body: """
                    <p>This is Jenkins HOTSTAR CICD pipeline status.</p>

                    <p><b>Project:</b> ${env.JOB_NAME}</p>

                    <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>

                    <p><b>Build Status:</b> ${buildStatus}</p>

                    <p><b>Started by:</b> ${buildUser}</p>

                    <p><b>Build URL:</b>
                    <a href="${env.BUILD_URL}">
                    ${env.BUILD_URL}
                    </a>
                    </p>
                    """,

                    to: 'mohdaseemakram19@gmail.com',

                    from: 'mohdaseemakram19@gmail.com',

                    replyTo: 'mohdaseemakram19@gmail.com',

                    mimeType: 'text/html',

                    attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
                )
            }
        }
    }
}
