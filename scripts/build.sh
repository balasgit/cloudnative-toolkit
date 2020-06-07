#!/usr/bin/env bash
echo 'Building new version of Tile from Iteration Zero Terraform Modules'

export GIT_REPO="git@github.com:ibm-garage-cloud/ibm-garage-iteration-zero.git"
export WORK_DIR="clone"
export BRANCH="master"

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
cp docs/README ${WORKSPACE_DIR}

# Move some stages to an unused folder
rm -rf unused-stages
mkdir unused-stages
mv stage3-logdna.tf unused-stages
mv stage3-sysdig.tf unused-stages

rm -rf ${WORK_DIR}

echo 'Build complete .......'