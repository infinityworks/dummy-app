openshift-origin: origin-image setup-project

ifdef OS_SERVER
ORIGIN_SERVER = $(OS_SERVER)
else
ORIGIN_SERVER = 172.17.0.1:8443
endif

ifdef PROJECT
else
	PROJECT = tapim-build
endif

origin-image:
	oc cluster up

login:
	oc login $(ORIGIN_SERVER) --insecure-skip-tls-verify=true
	oc project $(PROJECT)

create-project: login
	oc new-project $(PROJECT)

setup-project: create-project

deploy: login
	if oc get services $(APP_NAME); then \
		oc start-build --wait=true $(APP_NAME); \
	else \
	oc new-app --name $(APP_NAME) http://tfs.bpweb.bp.com:8080/tfs/TradingFunctions/IntegrationServices/_git/dummy-app; \
		sleep 10; \
		oc logs -f bc/$(APP_NAME); \
	fi

apply-service-config: login
	oc apply -R -f openshift
