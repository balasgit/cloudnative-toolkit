#!/bin/sh
###################################################################################
# Register IBM Cloud Private Catalog Offering within an Existing Catalog
# If the Catalog does not exist it will Create One with the name provided
#
# Author : Matthew Perrins
# email  : mjperrin@us.ibm.com
#
###################################################################################
echo "IBM Cloud Private Catalog Offering Creation!"
echo "This will create a CNCF DevOps Cloud Native Toolkit Tile in an existing Catalog"

# the API_KEY and Catalog Name are required to run this script
API_KEY=$1
CATALOG_NAME=$2
VERSION=1.1.0

# input validation
if [ -z "${API_KEY}" ]; then
    echo "Please provide your API_KEY as first parameter"
    exit
fi

# input validation
if [ -z "${CATALOG_NAME}" ]; then
    echo "Please provide your CATALOG_NAME as second paramter"
    exit
fi

# input validation, Version is provided when the packaged release of this repository is created
if [ -z "${VERSION}" ]; then
    echo "Please provide the version to register as third paramter"
    exit
fi

# Get a Bearer Token from IBM Cloud IAM
IAM_AUTH=$(curl -s -k -X POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Accept: application/json" \
  --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey" \
  --data-urlencode "apikey=${API_KEY}" \
  "https://iam.cloud.ibm.com/identity/token")

# Extract the Bearer Token from IAM response
TOKEN=$(echo $IAM_AUTH |  jq '.access_token' | tr -d '"')
BEARER_TOKEN="Bearer ${TOKEN}"

# credentials to post data to cloudant for bulk document upload
ACURL="curl -s -g -H 'Authorization: ${BEARER_TOKEN}'"
HOST="https://cm.globalcatalog.cloud.ibm.com/api/v1-beta"

# Get List of Catalogs and match to Catalog name
# If the catalog does not exist create it and use that GUID for the Offering Registration
echo "Retrieving Catalogs"
CATALOGS=$(eval ${ACURL} -X GET "${HOST}/catalogs")
CATALOG_ID=

# Lets find the Catalog Label and match it to the one we have passed in
for row in $(echo "${CATALOGS}" | jq -r '.resources[] | @base64'); do
  _jq() {
   echo ${row} | base64 --decode | jq -r ${1}
  }

#  echo $(_jq '.label')

  if [[ "$(_jq '.label')" == ${CATALOG_NAME} ]]; then
    CATALOG_ID=$(_jq '.id')
    echo "Found ${CATALOG_NAME} creating offering inside this one"
  fi

done

# Lets check if we have a Catalog
if [ -z "${CATALOG_ID}" ]; then

  echo "Catalog Does not Exist, pease create on with the User Experience "
  exit
fi

# Define the Offering and relationship to the Catalog
OFFERING=$(cat offering.json | sed "s/#CATALOG_ID/${CATALOG_ID}/g" | sed "s/#VERSION/${VERSION}/g" > offering-new.json )

echo "Creating Offering in Catalog ${CATALOG_ID}"
CATALOGS=$(eval ${ACURL} -location -request POST "${HOST}/catalogs/${CATALOG_ID}/offerings" -H 'Content-Type: application/json' --data "@offering-new.json")

echo "Offering Registration Complete ...!"
