#!/bin/bash
. .env

# This script launches the openapi-mcp server.

# Check if the OpenAPI spec file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_openapi_spec.yml>"
  exit 1
fi

OPENAPI_SPEC="$1"

# Check if EH_API_URL and EH_TOKEN are set
if [ -z "$EH_API_URL" ]; then
  echo "Error: EH_API_URL environment variable is not set."
  exit 1
fi

if [ -z "$EH_TOKEN" ]; then
  echo "Error: EH_TOKEN environment variable is not set."
  exit 1
fi

echo "Starting openapi-mcp server with spec: $OPENAPI_SPEC"
echo "Base URL: $EH_API_URL"
echo "Using Bearer Token for authentication."

# Run the openapi-mcp command
# We'll assume EH_TOKEN is a bearer token. If it's an API key, change --bearer-token to --api-key
./bin/openapi-mcp \
  --http=:8080 \
  --base-url="$EH_API_URL" \
  --bearer-token="$EH_TOKEN" \
  "$OPENAPI_SPEC"

