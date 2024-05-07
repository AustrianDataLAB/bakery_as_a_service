HELM = $(shell which helm)

.PHONY: helm-deploy
helm-deploy:
	-$(HELM) upgrade --install baas charts/baas --namespace baas --create-namespace