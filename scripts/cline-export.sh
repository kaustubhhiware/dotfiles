#!/bin/bash

SOURCE_DIR=~/Documents/Cline/
DEST_DIR=./Cline/

# step 1: List down MCPs (from the directory) into a mcp.list
MCP_IMPORT_DIR=MCP/
MCP_EXPORT_FILE=mcp.list
# Export MCP list
if [ -d "${SOURCE_DIR}${MCP_IMPORT_DIR}" ]; then
    mkdir -p "${DEST_DIR}"
    # List only directories in MCP/ and save to mcp.list
    find "${SOURCE_DIR}${MCP_IMPORT_DIR}" -maxdepth 1 -type d -exec basename {} \; | grep -v "^MCP$" | sort > "${DEST_DIR}${MCP_EXPORT_FILE}"
    echo ">> MCP list exported to ${DEST_DIR}${MCP_EXPORT_FILE}"
else
    echo ">> Warning: MCP directory not found at ${SOURCE_DIR}${MCP_IMPORT_DIR}"
fi

# step 2: Sync rules, as it is. Including subdirectories
RULES_IMPORT_DIR=Rules/
RULES_EXPORT_DIR=Rules/

if [ -d "${SOURCE_DIR}${RULES_IMPORT_DIR}" ]; then
    mkdir -p "${DEST_DIR}${RULES_EXPORT_DIR}"
    cp -r "${SOURCE_DIR}${RULES_IMPORT_DIR}"* "${DEST_DIR}${RULES_EXPORT_DIR}" 2>/dev/null
    echo ">> Rules synced to ${DEST_DIR}${RULES_EXPORT_DIR}"
else
    echo ">> Warning: Rules directory not found at ${SOURCE_DIR}${RULES_IMPORT_DIR}"
fi

# step 3: Sync workflows, as it is
WORKFLOW_IMPORT_DIR=Workflows/
WORKFLOW_EXPORT_DIR=Workflows/

if [ -d "${SOURCE_DIR}${WORKFLOW_IMPORT_DIR}" ]; then
    mkdir -p "${DEST_DIR}${WORKFLOW_EXPORT_DIR}"
    # Copy all files from workflows
    cp -r "${SOURCE_DIR}${WORKFLOW_IMPORT_DIR}"* "${DEST_DIR}${WORKFLOW_EXPORT_DIR}" 2>/dev/null
    echo ">> Workflows synced to ${DEST_DIR}${WORKFLOW_EXPORT_DIR}"
else
    echo ">> Warning: Workflows directory not found at ${SOURCE_DIR}${WORKFLOW_IMPORT_DIR}"
fi

echo "|> Cline export completed!"
