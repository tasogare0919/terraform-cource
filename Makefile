.PHONY: init plan apply destroy check force-unlock
ARG="default"

init: 
	@docker-compose run --rm terraform init

plan: 
	@docker-compose run --rm terraform plan

apply: 
	@docker-compose run --rm terraform apply

destroy: 
	@docker-compose run --rm terraform destroy

force-unlock:
	@docker-compose run --rm terraform force-unlock ${ARG}

check:
	@docker-compose run --rm terraform fmt -recursive
	@docker-compose run --rm terraform fmt -check
	@docker-compose run --rm terraform validate
