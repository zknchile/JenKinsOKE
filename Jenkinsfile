pipeline {
    agent any
    
    environment {
        TOKEN = 'XeO2cZ:}yWjYK458ghMH'
        USER = 'idlhjo6dp3bd/oracleidentitycloudservice/felipe.basso@oracle.com'
        REGION = 'iad.ocir.io'
        REGISTRY_NAMESPACE = 'idlhjo6dp3bd'
        REGISTRY = 'iad.ocir.io/idlhjo6dp3bd/hello_oke:latest'
        IMAGE = 'hello_oke:latest'
    }
    
    stages {
        stage('Build Imagen en Docker') {
            steps {
              sh "docker build . -t ${IMAGE}"
            }    
        }
        stage('Test Imagen') {
            steps {
                sh 'echo "Aquí deberíamos definir pruebas de QA, pero no tengo"'
            }
        }
        stage('Push Imagen en OCIR') {
        steps {
          sh "docker login -u ${USER} -p ${TOKEN} ${REGION}"
          sh "docker tag localhost/${IMAGE} ${REGISTRY}"
          sh "docker push ${REGISTRY}" 
           }
        }
        
        stage('Deploy de Aplicacion en OKE') {

        steps {
            sh "sh deploy.sh"
           }
         }
    }
}
