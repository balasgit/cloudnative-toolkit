#!/usr/bin/env bash
echo 'Building new version of Tile'

#export GIT_REPO="git@github.com:ibm-garage-cloud/ibm-garage-iteration-zero.git"
export GIT_REPO="git@github.com:seansund/ibm-garage-iteration-zero.git"
export WORK_DIR="clone"
export BRANCH="private-catalog"


curl -H 'Content-Type: application/json' -X GET http://admin:vuFmsueQ3knDMzpdUDiP@127.0.0.1:5984/_users/_all_docs




rm -rfd ${WORK_DIR}

git clone -b ${BRANCH} ${GIT_REPO}  ${WORK_DIR}

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

#rm -rf ${WORK_DIR}

echo 'Build complete .......'
