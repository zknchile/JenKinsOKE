pipeline {
    agent any
    
    environment {
        TOKEN = 'XeO2cZ:}yWjYK458ghMH'
        OCIUSER = 'idlhjo6dp3bd/oracleidentitycloudservice/felipe.basso@oracle.com'
        REGION = 'iad.ocir.io'
        REGISTRY_NAMESPACE = 'idlhjo6dp3bd'
        REGISTRY = 'iad.ocir.io/idlhjo6dp3bd/hello_oke:latest'
        IMAGE = 'hello_oke:latest'
        OCINAMESPACE = 'hello-oke'
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
          sh "docker login -u ${OCIUSER} -p ${TOKEN} ${REGION}"
          sh "docker tag localhost/${IMAGE} ${REGISTRY}"
          sh "docker push ${REGISTRY}" 
           }
        }
        
        stage('Deploy de Aplicacion en OKE') {

        steps {
            sh 'sudo runuser -l opc -c "kubectl create namespace ${OCINAMESPACE}"'
            sh 'sudo runuser -l opc -c "kubectl create secret docker-registry ocirsecret --docker-server=${REGION}/${REGISTRY_NAMESPACE} --docker-username=${OCIUSER} --docker-password="${TOKEN}" -n ${OCINAMESPACE}"'
            sh 'DIR=$(pwd) && sudo runuser -l opc -c "kubectl apply -f ${DIR}/deployment.yaml"'
            //sh 'sudo -u opc bash  -c "kubectl create namespace ${OCINAMESPACE}"'
            //sh 'sudo -u opc bash  -c "kubectl create secret docker-registry ocirsecret --docker-server=${REGION}/${REGISTRY_NAMESPACE} --docker-username=${OCIUSER} --docker-password="${TOKEN}" -n ${OCINAMESPACE}"'
            //sh 'sudo -u opc bash  -c "kubectl apply -f deployment.yaml"'
           }
         }
    }
}
