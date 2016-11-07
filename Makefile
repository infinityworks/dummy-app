ifdef PROJECT
else
	PROJECT = tapim-build
endif

origin-image:
	oc cluster up

login:
	oc login $(ORIGIN_SERVER) --insecure-skip-tls-verify=true
	oc project $(PROJECT)

deploy: login
	oc apply -R -f ./kube
	oc start-build dummy-app

delete: login
	oc delete all -l 'app = $(APP_NAME)'
