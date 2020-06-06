#!/bin/sh
# Generate a Bearer Token


# Credentials from IBM Cloud add API_KEY and USERNAME from Cloudant
API_KEY=$1

# input validation
if [ -z "${API_KEY}" ]; then
    echo "Please provide your API_KEY."
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

echo ${BEARER_TOKEN}


