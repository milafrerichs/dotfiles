docker rm `docker ps --no-trunc -aq` && docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker rmi $(docker images -f "dangling=true" -q)
docker volume rm $(docker volume ls -qf dangling=true)
