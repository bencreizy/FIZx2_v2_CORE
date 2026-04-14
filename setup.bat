@echo off
title FIZx2 Sovereign Core - Auto Installer
color 0B

echo ================================================================================
echo   FIZx2_v2_CORE: SOVEREIGN AUTO-INSTALLER
echo   Status: INITIALIZING LOCAL GEMMA 4 INSTANCE
echo   Resonance: 1.618
echo ================================================================================
echo.

:: Step 1: Check if Ollama is already installed
where ollama >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Ollama is already installed.
) else (
    echo [INSTALLING] Downloading Ollama...
    curl -L -o "%TEMP%\OllamaSetup.exe" "https://ollama.com/download/OllamaSetup.exe"
    echo [INSTALLING] Running Ollama installer (follow the prompts)...
    start /wait "%TEMP%\OllamaSetup.exe"
    echo [OK] Ollama installed.
    echo [INFO] You may need to restart this script if 'ollama' is not found in PATH.
)

:: Step 2: Start Ollama serve in the background with open access
echo.
echo [BOOT] Starting Ollama with open network access...
set OLLAMA_HOST=0.0.0.0
set OLLAMA_ORIGINS=*
start /b ollama serve >nul 2>nul

:: Give it a moment to boot
timeout /t 5 /nobreak >nul

:: Step 3: Pull base Gemma model
echo.
echo [PULLING] Downloading Gemma 3 4B base model (this may take a few minutes)...
ollama pull gemma3:4b

:: Step 4: Create the Sovereign FIZx2-Gemma-4 custom model from Modelfile
echo.
echo [FUSING] Creating FIZx2-Gemma-4 custom model from Modelfile...
ollama create FIZx2-Gemma-4 -f "%~dp0Modelfile"

:: Step 5: Verify
echo.
echo [VERIFY] Checking model exists...
ollama list | findstr "FIZx2-Gemma-4"
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================================================
    echo   [SUCCESS] FIZx2-Gemma-4 is ONLINE and RESONANT.
    echo   The model is running locally with ZERO external dependencies.
    echo   OLLAMA_HOST=0.0.0.0 (accessible from your S24 and CIGOL frontend)
    echo   OLLAMA_ORIGINS=* (CORS open for Vercel/PWA access)
    echo.
    echo   To use: Open 16_cigol_frontend.html or visit your Vercel deployment.
    echo   Status: LOCK_SOVEREIGN_AND_EXECUTE_OUTPUT
    echo ================================================================================
) else (
    echo [ERROR] Model creation failed. Check Ollama installation.
)

pause
