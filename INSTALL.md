# FIZx2 Sovereign Core — Installation Guide

## One-Command Setup

### Windows
```
setup.bat
```
Double-click `setup.bat` or run it from any terminal. It will:
1. Download and install **Ollama** (if not already installed)
2. Pull **Gemma 3 4B** as the base model
3. Fuse it with the **FIZx2 Modelfile** to create `FIZx2-Gemma-4`
4. Start serving with `OLLAMA_HOST=0.0.0.0` and `OLLAMA_ORIGINS=*`

### Linux / Mac
```bash
chmod +x setup.sh && ./setup.sh
```

## After Setup
- Open `16_cigol_frontend.html` in your browser to use the CIGOL interface
- Or visit the live deployment at your Vercel URL
- The model runs **100% locally** with zero cloud dependencies

## Requirements
- 8GB+ RAM recommended
- ~3GB disk space for the model weights
- Internet connection only needed for initial download
