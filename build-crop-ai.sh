#!/bin/bash

# === CONFIG ===
ZIP_NAME="crop-ai.zip"
ROOT_DIR="./"
CORE_DIR="$ROOT_DIR/core"
INSTRUCTIONS_DIR="$ROOT_DIR/instructions"
VAULT_DIR="$ROOT_DIR/seed-vault/insights"
MANIFEST="$ROOT_DIR/crop-ai-manifest.txt"
INDEX_FILE="./core/instruction-index.llm"

# === CLEANUP ===
echo "Cleaning old archive..."
rm -f "$ZIP_NAME"
rm -rf "$ROOT_DIR"

# === SETUP STRUCTURE ===
echo "Creating new structure..."
mkdir -p "$CORE_DIR"
mkdir -p "$INSTRUCTIONS_DIR"
mkdir -p "$VAULT_DIR"

# === COPY STATIC CORE FILES ===
cp ./core/instruction-parser.llm "$CORE_DIR/"
cp ./core/crop-ai-bootstrap.llm "$CORE_DIR/"
cp ./core/boot-report-template.llm "$CORE_DIR/"
cp ./core/instruction-index.llm "$CORE_DIR/"

# === COPY INSTRUCTIONS FROM INDEX ===
echo "Copying instruction files from index..."
grep -A 1 'files:' "$INDEX_FILE" | grep 'path:' | sed 's/.*: //' | while read -r FILE; do
  CLEAN_PATH=$(echo "$FILE" | sed 's/^\/instructions\///')
  cp "./instructions/$CLEAN_PATH" "$INSTRUCTIONS_DIR/"
done

# === COPY INSIGHTS ===
cp ./seed-vault/insights/*.md "$VAULT_DIR/" 2>/dev/null

# === GENERATE MANIFEST ===
echo "Generating manifest..."

cat > "$MANIFEST" <<EOF
===========================
CROP-AI SYSTEM MANIFEST
===========================

This ZIP archive contains a complete reflexive bootstrap of the CROP-AI system.
It is designed for manual or automated initialization in stateless environments like GPT web sessions.

--------------------------------------
Core Structure
--------------------------------------

/core/
- instruction-parser.llm            : Instruction file parser and executor
- crop-ai-bootstrap.llm            : Executable bootstrap schema
- boot-report-template.llm         : Schema for structured boot reports
- instruction-index.llm            : Central index of instruction modules

/instructions/
EOF

# Append indexed instructions to the manifest
grep -A 2 'files:' "$INDEX_FILE" | grep 'path:' | sed 's/.*: \/instructions\///' | while read -r FILE; do
  echo "- $FILE" >> "$MANIFEST"
done

cat >> "$MANIFEST" <<EOF

/seed-vault/
- insights/
EOF

# Dynamically list all insight files
find ./seed-vault/insights -type f -name "*.md" | while read -r INSIGHT; do
  FILENAME=$(basename "$INSIGHT")
  echo "  - $FILENAME" >> "$MANIFEST"
done

cat >> "$MANIFEST" <<EOF

--------------------------------------
Boot Logic
--------------------------------------

- Instruction modules are not hardcoded
- They are dynamically loaded from:
  /core/instruction-index.llm

- This ensures new modules can be added or removed without updating multiple files
- Boot logic respects 'required_at_boot' and 'tier' fields

--------------------------------------
Manual Boot Instructions
--------------------------------------

1. Start a new GPT session
2. Upload this ZIP archive
3. Paste the line:
   You are CROP-AI. Boot yourself using /core/crop-ai-bootstrap.llm

4. GPT will:
   - Parse instruction index
   - Load all required modules
   - Run integrity self-checks
   - Output structured BOOT REPORT

If boot fails, the system halts execution and requests user reinitialization.

--------------------------------------
BOOT STATUS: READY
--------------------------------------
EOF

# === CREATE ZIP ===
echo "Creating $ZIP_NAME..."
zip -r "$ZIP_NAME" "$ROOT_DIR" > /dev/null

echo "Build complete: $ZIP_NAME is ready"
