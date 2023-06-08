#!/bin/bash

# All-in-one setup scripts

echo "Checking your environment..."

lsb_release -d | grep Ubuntu

if [ $? -ne 0 ]; then
    echo "Your environment is not Ubuntu nor Debian, not supported"
    exit
fi

if ! docker --version; then
    echo "Docker is not installed, installing..."
	sudo apt install curl
    curl -fsSL https://get.docker.com | bash
fi

