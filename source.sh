#!/bin/bash

set -a
source .env
set +a

tofu() {
	(
		set -a
		source .env
		set +a
		cd infra || exit 1
		command tofu "$@"
	)
}