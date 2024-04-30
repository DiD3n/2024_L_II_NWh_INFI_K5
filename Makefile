install:
	pip install -r requirements.txt
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. py.test --verbose -s
docker_build:
	docker image build -t hello-world-printer .
docker_run: docker_build; \
	docker run --name hello-world-printer-dev -p 5001:5000 -d hello-world-printer
USERNAME=dawderkokstotalny
TAG=$(USERNAME)/hello-world-printer
docker_publish: docker_build; \
	docker login --username '$(USERNAME)' --password '$(DOCKER_PASSWORD)'
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;
