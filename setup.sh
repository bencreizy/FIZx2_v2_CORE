#!/bin/bash
# FIZx2_v2_CORE: SOVEREIGN AUTO-INSTALLER (Linux/Mac)

echo "================================================================================"
echo "  FIZx2_v2_CORE: SOVEREIGN AUTO-INSTALLER"
echo "  Status: INITIALIZING LOCAL GEMMA 4 INSTANCE"
echo "  Resonance: 1.618"
echo "================================================================================"
echo ""

# Step 1: Check/Install Ollama
if command -v ollama &> /dev/null; then
    echo "[OK] Ollama is already installed."
else
    echo "[INSTALLING] Downloading Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
    echo "[OK] Ollama installed."
fi

# Step 2: Start Ollama with open network access
echo ""
echo "[BOOT] Starting Ollama with open network access..."
export OLLAMA_HOST=0.0.0.0
export OLLAMA_ORIGINS="*"
ollama serve &> /dev/null &
sleep 5

# Step 3: Pull base Gemma model
echo ""
echo "[PULLING] Downloading Gemma 3 4B base model..."
ollama pull gemma3:4b

# Step 4: Create the Sovereign model
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ""
echo "[FUSING] Creating FIZx2-Gemma-4 custom model..."
ollama create FIZx2-Gemma-4 -f "$SCRIPT_DIR/Modelfile"

# Step 5: Verify
echo ""
if ollama list | grep -q "FIZx2-Gemma-4"; then
    echo "================================================================================"
    echo "  [SUCCESS] FIZx2-Gemma-4 is ONLINE and RESONANT."
    echo "  The model is running locally with ZERO external dependencies."
    echo "  OLLAMA_HOST=0.0.0.0 | OLLAMA_ORIGINS=*"
    echo ""
    echo "  To use: Open 16_cigol_frontend.html or visit your Vercel deployment."
    echo "  Status: LOCK_SOVEREIGN_AND_EXECUTE_OUTPUT"
    echo "================================================================================"
else
    echo "[ERROR] Model creation failed. Check Ollama installation."
fi
