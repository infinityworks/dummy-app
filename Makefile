openshift-origin: origin-image setup-project

ifdef OS_SERVER
ORIGIN_SERVER = $(OS_SERVER)
else
ORIGIN_SERVER = 172.17.0.1:8443
endif

origin-image:
	oc cluster up

login:
	oc login -u test -p test $(ORIGIN_SERVER) --insecure-skip-tls-verify=true

create-project: login
	oc new-project bp

setup-project: create-project

secrets: copy-kerberos-config login
	oc secrets new kerberos ./krb

deploy: login
	if oc get services $(APP_NAME); then \
		oc start-build --wait=true $(APP_NAME); \
	else \
	oc new-app --name $(APP_NAME) https://github.com/infinityworksltd/dummy-app.git; \
		sleep 10; \
		oc logs -f bc/dummy-app; \
	fi
