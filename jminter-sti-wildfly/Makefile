NAME=$(shell basename $(shell pwd))

build: rm
	docker build -t ${NAME} .

rm:
	-docker rmi ${NAME}

save:
	docker save ${NAME} >$(shell echo ${NAME}.tar | sed -e 's!/!-!g')

.PHONY: build rm save
