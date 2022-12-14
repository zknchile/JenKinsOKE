pipeline {
    agent any
    
    environment {
        TOKEN = 'XeO2cZ:}yWjYK458ghMH'
        OCIUSER = 'idlhjo6dp3bd/oracleidentitycloudservice/felipe.basso@oracle.com'
        REGION = 'iad.ocir.io'
        REGISTRY_NAMESPACE = 'idlhjo6dp3bd'
        REGISTRY_TAG = 'iad.ocir.io/idlhjo6dp3bd/hello_oke:latest'
        IMAGE_TAG = 'latest'
        IMAGE = 'hello_oke:latest'
        OCINAMESPACE = 'hello-oke'
        DEP_YAML = 'hello-oke.yaml'
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
          sh "docker tag localhost/${IMAGE} ${REGISTRY_TAG}"
          sh "docker push ${REGISTRY_TAG}" 
           }
        }
        
        stage('Deploy de Aplicacion en OKE') {

        steps {
            sh 'sudo runuser -l opc -c "helm create hello-oke"'
            sh 'DIR=$(pwd) && sudo runuser -l opc -c "helm upgrade ${OCINAMESPACE} ${OCINAMESPACE}/ --install --wait --values ${DIR}/${OCINAMESPACE}/${DEP_YAML} --set image.tag=${IMAGE_TAG} --namespace ${OCINAMESPACE}"'
            sh 'sudo runuser -l opc -c "rm -vfr hello-oke"'
           }
         }
    }
}
