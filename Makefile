STACK_NAME="AWS-Workspace-Cevo-Pattern"

test-lint-yaml:
	@echo "--- Test Lint YAML"
	@docker-compose run --rm yamllint .

test-cfn-lint-yaml:
	@echo "--- Test CFN Lint YAML"
	@docker-compose run --rm cfnlint cfn-lint -t cloudformation/template.yml

test-validate-shell:
	@echo "--- Test Validate Shell Scripts"
	@docker-compose run --rm shellcheck scripts/validate_shell_scripts.sh

test-validate-cfn:
	@echo "--- Test Validate CloudFormation"
	@docker-compose run --rm awscli scripts/validate_cloudformation.sh

test: test-validate-cfn

deploy:
	@echo "--- Deploy $(STACK_NAME) cloudformation stack"
	@docker-compose run --rm stackup $(STACK_NAME) up \
		--template cloudformation/template.yml \
		--parameters cloudformation/parameters/dev.yml \
		--capability CAPABILITY_IAM 

