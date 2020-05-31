TAG=karlbunch/docker-bukkit:1.15.2
EXTRA_ARGS=

usage:
	@echo "make run N=##"

new:
	@next=$$(( $$(docker ps -a --filter 'name=minecraft-*' --format '{{.Names}}'|sort -r|head -1|sed 's/.*-//') + 1 )); \
	echo "Next server: $$next"; \
	make run N=$$next

run:
	@if [ -z "$(N)" ]; then echo "please set N=[0-9]";exit 11; fi
	p=$$(( 25564 + $(N) ));docker run -d -it --restart unless-stopped -v mcdata-$(N):/data -e EULA=true -p $$p:25565 $(EXTRA_ARGS) --name minecraft-$(N) $(TAG)
	docker logs -f minecraft-$(N)

restart:
	@if [ -z "$(N)" ]; then echo "please set N=[0-9]";exit 11; fi
	docker container restart minecraft-$(N)
	docker logs -f minecraft-$(N)

maint:
	@if [ -z "$(N)" ]; then echo "please set N=[0-9]";exit 11; fi
	-docker stop minecraft-$(N)
	docker run --rm -it -v mcdata-$(N):/data openjdk:8-alpine sh

destroy:
	@if [ -z "$(N)" ]; then echo "please set N=[0-9]";exit 11; fi
	docker stop minecraft-$(N)
	docker rm minecraft-$(N)
	docker volume rm mcdata-$(N)

run2:
	docker run -d -it -v mcdata-2:/data -e EULA=true -p 25566:25565 --name minecraft-2 karlbunch/docker-bukkit:latest

run3:
	docker run -d -it -v mcdata-3:/data -e EULA=true -p 25567:25565 --name minecraft-3 karlbunch/docker-bukkit:latest
