#!/usr/bin/env bash
echo 'Building new version of Tile'

export GIT_REPO="git@github.com:ibm-garage-cloud/ibm-garage-iteration-zero.git"
export WORK_DIR="clone"
export BRANCH="master"

rm -rfd ${WORK_DIR}

git clone ${GIT_REPO} ${WORK_DIR}

mkdir -p ~/.npm
npm config set prefix ~/.npm
export PATH=$PATH:~/.npm/bin
npm i -g release-it

if [[ "${BRANCH}" != "master" ]]; then
    PRE_RELEASE="--preRelease=${BRANCH}"
fi

SRC_DIR="${WORK_DIR}/terraform"
WORKSPACE_DIR="."

ENVIRONMENT_TFVARS="${SRC_DIR}/settings/environment.tfvars"
TFVARS="${WORKSPACE_DIR}/terraform.tfvars"
cat "${ENVIRONMENT_TFVARS}" > "${TFVARS}"

# Read terraform.tfvars to see if cluster_exists, postgres_server_exists, and cluster_type are set
# If not, get them from the user and write them to a file

CLUSTER_MANAGEMENT="ibmcloud"
CLUSTER_TYPE="openshift"
STAGES_DIRECTORY="stages"

echo "Copying from ${SRC_DIR} to ${WORKSPACE_DIR}"
cp "${SRC_DIR}/${STAGES_DIRECTORY}/variables.tf" "${WORKSPACE_DIR}"
cp "${SRC_DIR}/${STAGES_DIRECTORY}"/stage*.tf "${WORKSPACE_DIR}"
cp "${SRC_DIR}"/scripts/* "${WORKSPACE_DIR}"
cp docs/README.MD ${WORKSPACE_DIR}

release-it patch ${PRE_RELEASE} --ci --no-npm --no-git.push --no-git.requireCleanWorkingDir                       --verbose                       -VV

git push --follow-tags -v

echo 'Release complete .......'
