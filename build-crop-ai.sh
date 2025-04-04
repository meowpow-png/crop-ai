#!/bin/bash

# === CONFIG ===
ZIP_NAME="crop-ai.zip"
BUILD_DIR="build"
CORE_DIR="$BUILD_DIR/core"
INSTRUCTIONS_DIR="$BUILD_DIR/instructions"
VAULT_DIR="$BUILD_DIR/seed-vault/insights"
MANIFEST="$BUILD_DIR/crop-ai-manifest.txt"
INDEX_FILE="./core/instruction-index.llm"

# === CLEANUP ===
echo "Cleaning build directory..."
rm -rf "$BUILD_DIR"

# === SETUP STRUCTURE ===
echo "Creating directory structure..."
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
awk '/path:/ { for (i=1; i<=NF; i++) if ($i ~ /path:/) print $(i+1) }' "$INDEX_FILE" | while read -r FILE; do
  cp ".$FILE" "$INSTRUCTIONS_DIR/"
done

# === COPY INSIGHTS ===
echo "Copying insights..."
cp ./seed-vault/insights/*.yaml "$VAULT_DIR/" 2>/dev/null

# === GENERATE MANIFEST ===
echo "manifest_version: 1.0" > "$MANIFEST"
echo "archive: $ZIP_NAME" >> "$MANIFEST"
echo "structure:" >> "$MANIFEST"

# Core
echo "  core:" >> "$MANIFEST"
for FILE in instruction-parser.llm crop-ai-bootstrap.llm boot-report-template.llm instruction-index.llm; do
  echo "    - $FILE" >> "$MANIFEST"
done

# Instructions
echo "  instructions:" >> "$MANIFEST"
awk '/path:/ { for (i=1; i<=NF; i++) if ($i ~ /^path:/) print $(i+1) }' "$INDEX_FILE" | while read -r FILE; do
  FILENAME=$(basename "$FILE")
  echo "    - $FILENAME" >> "$MANIFEST"
done

# Insights
echo "  seed-vault:" >> "$MANIFEST"
echo "    insights:" >> "$MANIFEST"
find ./seed-vault/insights -type f -name "*.yaml" | while read -r INSIGHT; do
  FILENAME=$(basename "$INSIGHT")
  echo "      - $FILENAME" >> "$MANIFEST"
done

# === CREATE ZIP ARCHIVE ===
zip -r "$ZIP_NAME" "$BUILD_DIR" > /dev/null
rm -rf "$BUILD_DIR" && mkdir "$BUILD_DIR" && mv "$ZIP_NAME" "$BUILD_DIR"
echo "Build complete: $ZIP_NAME"
