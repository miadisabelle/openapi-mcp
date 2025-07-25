# OpenAPI MCP Server Setup

## Project Overview
This project provides an MCP (Model Context Protocol) server that exposes OpenAPI specifications as MCP tools for the Miadi Three-Pathway Agent System.

## Current Status

### ✅ What Works
- **OpenAPI Spec Validation**: The spec `specs/miadi-250509-narrativegroup-agent_.yml` validates successfully
- **Stdio Mode**: MCP server works perfectly in stdio mode
- **Environment Configuration**: `.env` file properly configured with `EH_API_URL` and `EH_TOKEN`

### ❌ Known Issues
- **HTTP Mode Parsing Bug**: The `openapi-mcp` tool has a parsing bug in HTTP mode where it fails to load specs correctly, even though validation passes
- **Original `start_mcp.sh`**: Doesn't work due to the HTTP mode issue

### 🔧 Fixes Applied
1. **OpenAPI Spec**: Fixed missing required fields in example schemas (`resolvedCapabilities`, `startTime`, `lastActivity`)
2. **Working Scripts**: Created `start_mcp_fixed.sh` that uses stdio mode successfully

## Usage

### Start MCP Server (Stdio Mode - Working)
```bash
./start_mcp_fixed.sh specs/miadi-250509-narrativegroup-agent_.yml
```

### Test MCP Server
```bash
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}' | ./start_mcp_fixed.sh specs/miadi-250509-narrativegroup-agent_.yml
```

## Files Created/Modified
- `specs/miadi-250509-narrativegroup-agent_.yml` - Fixed OpenAPI spec examples
- `start_mcp_fixed.sh` - Working stdio mode startup script
- `start_mcp_http_workaround.sh` - HTTP mode attempt (fails due to parsing bug)
- `test-minimal.yml` - Minimal test spec for debugging

## API Endpoints Available
The OpenAPI spec exposes endpoints for:
- Memory management (`/api/memory`)
- Session management (`/api/session/*`)
- Capability resolution (`/api/capabilities/resolve`)
- Cue detection (`/api/cues/detect`)
- Agent information (`/api/agent-info`)
- Workflow integration (`/api/workflow/*`)

## Future Work / Delayed Resolution
**Note**: Tests conducted on another host environment did not work as expected. We are delaying resolution of HTTP mode issues and will investigate adequate ways to serve MCP using our OpenAPI specifications at a later time. The stdio mode remains functional for current development needs.

## Environment Variables Required
```
EH_API_URL=http://localhost:3333
EH_TOKEN=__TOKEN__
```

## Commands Available
- `./bin/openapi-mcp validate <spec>` - Validate OpenAPI spec
- `./bin/openapi-mcp --dry-run <spec>` - Test spec parsing without server
- `./bin/mcp-client` - MCP client tool (available but requires proper server setup)
