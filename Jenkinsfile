pipeline {
    agent any
    
    environment {
        TOKEN = 'XXXXXXXXXXXXXX'
        REGISTRY_NAMESPACE = 'XXXXXXXXXXXXXX'
        OCIUSER = "${REGISTRY_NAMESPACE}/oracleidentitycloudservice/XXXXXXXXXXXXXX"
        REGION = 'XXX'
        IMAGE = 'hello_oke'
        IMAGE_TAG = 'latest'
        REGISTRY_TAG = "${REGION}.ocir.io/${REGISTRY_NAMESPACE}/${IMAGE}:${IMAGE_TAG}"
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
          sh "docker login -u ${OCIUSER} -p ${TOKEN} ${REGION}.ocir.io"
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
