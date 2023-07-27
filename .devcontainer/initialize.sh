#!/bin/bash
set -ex
# This file is executed before the build of the docker image, in other words
# it runs in a terminal in your local environment. It is used to pass information
# into the docker environment, such as the current user email address. Further
# it checks that we are authenticated with google cloud, and it concatenates
# the .dev lines to the prod docekrfile

# Get the user email from gcloud l
USER_EMAIL=$(gcloud config get-value account)

# Add some env vars
echo "USER_EMAIL=${USER_EMAIL}" > .devcontainer/container.env.generated
echo "USERNAME=${USER_EMAIL%%@*}" | sed -e 's/\.//g' >> .devcontainer/container.env.generated

# Check auth, as the terminal inside the container won't be able to open a
# browser and login (however it uses the same credentials as the host, so
# logging in in a local terminal will work, however this is convenient)
if !(echo "not_your_password" | gcloud projects list > /dev/null); then
    gcloud auth login --update-adc --enable-gdrive-access
fi

# Geneate a .dev dockerfile
cp Dockerfile.prod .devcontainer/Dockerfile.generated
cat .devcontainer/Dockerfile.dev >> .devcontainer/Dockerfile.generated