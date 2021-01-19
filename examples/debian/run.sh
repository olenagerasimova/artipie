set -x
set -e

# Start Artipie.
docker run --name artipie -d -it -v $(pwd)/artipie.yaml:/etc/artipie/artipie.yml -v $(pwd):/var/artipie -p 8080:80 artipie/artipie:latest

# Wait for container to be ready for new connections.
sleep 5

# Post a package.
curl -i  -X PUT  --data-binary "@aglfn_1.7-3_amd64.deb" http://localhost:8080/my-debian/main/aglfn_1.7-3_amd64.deb

# Stop Artipie.
docker stop artipie

# Remove the network for inter-container communication.
docker network rm artipie-rpm-demo
