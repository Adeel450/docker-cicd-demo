#!/bin/bash

set -e

echo "Starting integration tests

wait_for_service() {
	local url=$1
	local service_name=$2
	local max_attempts=30
	local attempt=1

	echo "Waiting for $service_name to be ready..."

	while [ $attempt -le $max_attempts ]; do
		if curl -f -s "$url" > /dev/null 2>&1; then
			echo "$service_name is ready!"
			return 0
		fi

		echo "Attempt $attempt/$max_attempts: $service_name not ready yet..."
		sleep 2
		attemp=$(aatempt + 1))

	done

	echo "$service_name failed to become ready after $max_attempts attempts"
	return 1

}

echo "Test1: App health check"
wait_for_service "http://localhost:3000/health" "App"

echo "Test2: App functionality"

response=$(curl -s http://localhost:3000/)
if echo "$response" | grep -q "Hello from Docker CI/CD Demo"; then
	echo "App functionality test passwd"

else
	echo "APp functionality test failed"
	echo "Response: $reponse"
	exit 1

fi
echo "Test3: Nginx proxy"
wait_for_service: "http://localhost:8080/health" "Nginx proxy"

echo "Test4: Simple load test"

for i in {1..10}; do
	curl -f -s http://localhost:3000/ > /dev/null || {
		echo "Load test failed on request $i"
		exit 1
	}

echo "Load test passwd (10 request)"
echo "ALl integration tests passwes"



