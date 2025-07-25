#!/bin/bash
. .env

# This script launches the openapi-mcp server in stdio mode
# HTTP mode has a parsing bug, so we use stdio mode which works correctly

# Check if the OpenAPI spec file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_openapi_spec.yml>"
  echo "Example: $0 specs/miadi-250509-narrativegroup-agent_.yml"
  exit 1
fi

OPENAPI_SPEC="$1"

# Check if the spec file exists
if [ ! -f "$OPENAPI_SPEC" ]; then
  echo "Error: OpenAPI spec file '$OPENAPI_SPEC' not found."
  exit 1
fi

# Check if EH_API_URL and EH_TOKEN are set
if [ -z "$EH_API_URL" ]; then
  echo "Error: EH_API_URL environment variable is not set."
  echo "Please check your .env file."
  exit 1
fi

if [ -z "$EH_TOKEN" ]; then
  echo "Error: EH_TOKEN environment variable is not set."
  echo "Please check your .env file."
  exit 1
fi

echo "Starting openapi-mcp server with spec: $OPENAPI_SPEC"
echo "Base URL: $EH_API_URL"
echo "Using Bearer Token for authentication."
echo "Mode: stdio (HTTP mode has parsing issues)"
echo ""
echo "To test the server, you can use:"
echo "echo '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"initialize\",\"params\":{\"protocolVersion\":\"2024-11-05\",\"capabilities\":{},\"clientInfo\":{\"name\":\"test\",\"version\":\"1.0\"}}}' | ./bin/openapi-mcp --base-url=\"$EH_API_URL\" --bearer-token=\"$EH_TOKEN\" \"$OPENAPI_SPEC\""
echo ""

# Run the openapi-mcp command in stdio mode (works correctly)
./bin/openapi-mcp \
  --base-url="$EH_API_URL" \
  --bearer-token="$EH_TOKEN" \
  "$OPENAPI_SPEC"