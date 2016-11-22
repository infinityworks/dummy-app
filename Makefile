origin-image:
	oc cluster up

login:
	oc login $(ORIGIN_SERVER) --insecure-skip-tls-verify=true
	oc project $(KUBERNETES_NAMESPACE)

deploy: login
	oc process -f kube-templates/buildconfig.yaml -o yaml \
		-v KUBERNETES_NAMESPACE=$(KUBERNETES_NAMESPACE) | oc apply -f -
	oc process -f kube-templates/deployment-config.yaml -o yaml \
		-v KUBERNETES_NAMESPACE=$(KUBERNETES_NAMESPACE) \
		-v APP_NAME=$(APP_NAME) | oc apply -f -
	oc apply -R -f ./kube
	oc start-build dummy-app

delete: login
	oc delete all -l 'app = $(APP_NAME)'
