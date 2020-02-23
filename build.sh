#!/bin/sh

name='ungdev/openshift-s2i-yarn'
declare -a tags=(lts-alpine alpine 13-alpine 12-alpine 10-alpine)

for tag in ${tags[*]}; do
  echo "Create image node:$tag"
  echo "FROM node:$tag" > Dockerfile
  cat Dockerfile.template >> Dockerfile

  if [[ $tag == 'alpine' ]]; then
    tag='latest'
  fi

  # Remove tag name
  tag=${tag%-alpine}

  docker build -t $name:$tag .
  docker push $name:$tag
done
