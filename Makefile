##@ Utility
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.env.example: .env
	@cut -d ':' -f 1 .env > .env.example

##@ SSH
ssh_root: ## SSH into server as root user
	set -a && . ./.env && set +a && ssh "root@$${PUBLIC_IPV4}"

ssh_app: ## SSH into server as app user
	set -a && . ./.env && set +a && ssh -tt "app@$${PUBLIC_IPV4}" 'cd ~/actions-runner/_work/linkwarden/linkwarden && exec bash -il'
	# set -a && . ./.env && set +a && ssh "app@$${PUBLIC_IPV4}"