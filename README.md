## CI/CD desde Github Actions hacia Oracle OKE

La finalidad de este demo es configurar Github Actions para realizar deploymente de una aplicaicón en Oracle Kubernetes Engine (OKE)


### Requerimientos:

- Cuenta de Oracle Cloud Infrastructure(test gratuito https://www.oracle.com/cloud/free/)
- Cuenta de Github (https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)

### ¿Qué vamos a hacer?

- Clonar repositorio Github
- Configurar OKE
- Configurar Github Actions
- Despliegue de aplicación
	- Descargar imágen desde dockerhub
	- Crear imágen personalizada de contenedor (compilar)
	- Subirla a OCI registry
	- Instalar app desde Helm
	- Despliegue en Kubernetes
- Modificar aplicación
- Despliegue automático 

### Paso a Paso

1. Crear cluster OKE - 
	Menu -> Developer Services -> Kubernetes Clusters (OKE) -> Quick Create
	![quickCrate](img/createOKE.PNG)

2. Una vez que finalice el proceso, crear kubeconfig
    ```
    $ oci ce cluster create-kubeconfig --cluster-id <cluster ocid> --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0  --kube-endpoint PUBLIC_ENDPOINT
    ```
3. Crear OCI Setup Configurar
	```
	Crear config 
	oci setup config
		Definir:
			- Path donde quedará la configuración ~/.oci/NOMBREARCHIVO
			- User OCID
			- Tenancy OCID
			- Region (en mi caso us-ashburn-1)
			- Y para q fgenere las llaves
			- Validar el directorio donde se crearán
			- Validar el nombre de las llaves
	```
3.1 Para validar, hacer cat al archivo de configuración 
	```
	$ cat ~/.oci/NOMBREARCHIVO
	```
	
4. Crear API Key (permite conectar a kubernetes y realizar el despliegue mediante Helm)
	![apikey](img/userAPIKeys.PNG)
	Menu -> Identity & Security -> User -> User Details -> Add API Key
	```
		Pegar la public Key
			$ cat .oci/oci_api_key_public.pem
	```

4.2 El fingerprint que se crea debe ser el mismo q está en ~/.oci/NOMBREARCHIVO
	```
	$ fgrep "XXXXXX" ~/.oci/NOMBREARCHIVO
	```
	
6. Crear Token (Nos permitirá conectarnos con el OCI Registry)
	Menu -> Identity & Security -> User -> User Details -> Auth Tokens -> Generate Token
	![token](img/auth.PNG)
	Se puede guardar dentro de un archivo 
	```
	$ echo "XXXXXX" > .oci/token
	```
7. Crear registry en OCI
	Menu -> Developer Services -> Container Registry -> Create Repository
	![quickCrate](img/registry.PNG)

8. Clonar el repo y configurar los secrets
	Github > Project > Setings > Secrets > Actions
	![secret](img/secrets.PNG)
	```
		OCI_AUTH_TOKEN					cat ~/.oci/token
		OCI_CLI_FINGERPRINT				cat ~/.oci/deployer		fingerprint=d1:e2:  			
		OCI_CLI_KEY_CONTENT				cat ~/.oci/oci_api_key.pem. Estio se puede validar desde cat ~/.oci/NOMBREARCHIVO   key_file=/home/felipe_bas/.oci/oci_api_key.pem
		OCI_CLI_REGION					cat ~/.oci/deployer		region=us-ashburn-1
		OCI_CLI_TENANCY					cat ~/.oci/deployer		tenancy=ocid1.tenancy.oc1.
		OCI_CLI_USER					cat ~/.oci/deployer		user=ocid1.user.oc1.
		OCI_COMPARTMENT_OCID			Identity > Compartment > $COMPARTMENT_NAME > ocid1.compartment.oc1.
		OCI_DOCKER_REPO					$OCI_REGISTRY
		OKE_CLUSTER_OCID				Developer > OKE > $OKE_NAME > ocid1.cluster.oc1.
	```

9. Crear namespace
	```
	kubectl create namespace $NAMESPACE
	```
	
10. Crear Secret de tipo docker-registry para el namespace
	```
	kubectl create secret docker-registry ocirsecret --docker-server=iad.ocir.io --docker-username='<Tenancy name>/<username>' --docker-password='<user auth token>' -n demo
	```

11. Realizar un cambio en nuestro repositorio y esperar que el deploy se realice de forma automática 

May the force be with you!
