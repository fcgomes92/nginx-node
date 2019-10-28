
.PHONY: start dev
.DEFAULT_GOAL := start

start:
	@echo "Starting"
	pm2 start
	nginx -g "daemon off;"

dev:
	@echo "Loading dev"
	pm2 start
	nginx -g "daemon off;"