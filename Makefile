OWNER := cogentdom
IMAGE_NAME := stockapp
VERSION := stream
REPOSITORY := streamlit
IMAGE_TAG := d61789bb04e2
REGISTRY := chiefdom

default: release
git: release_git


# ------ Dockhub build ------
build: ## Build the container without caching
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) .


release: build publish ## Make a release by building and publishing tagged image to Docker Trusted Registry (DTR)

publish: ## Publish image to DTR
	@echo 'publish $(REGISTRY)$(IMAGE_NAME):$(VERSION)'
	docker push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

# ------ Github build ------
tag_git:
	docker tag $(IMAGE_ID) docker.pkg.github.com/$(OWNER)/$(REPOSITORY)/$(IMAGE_NAME):$(VERSION)

build_git: ## Build the container forrmated for githubs api
	docker build -t docker.pkg.github.com/$(OWNER)/$(REPOSITORY)/$(IMAGE_NAME):$(VERSION) .


release_git: tag_git build_git publish_git ## Make a release by building and publishing tagged image to Docker Trusted Registry (DTR)

publish_git: ## Publish image to DTR
	@echo 'publish $(REGISTRY)/$(IMAGE_NAME):$(VERSION)'
	docker push docker.pkg.github.com/$(OWNER)/$(REPOSITORY)/$(IMAGE_NAME):$(VERSION)