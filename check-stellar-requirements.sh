#!/bin/bash

echo "🔍 Verificando requisitos para Stellar CLI..."
echo "=============================================="

# 1. Verificar sistema operativo
echo "Sistema operativo:"
lsb_release -d 2>/dev/null || echo "No se pudo determinar el SO"

echo "----------------------------------------------"

# 2. Verificar memoria RAM y swap
echo "Memoria disponible:"
free -h

echo "----------------------------------------------"

# 3. Verificar dependencias del sistema
echo "Dependencias del sistema:"
declare -A deps=(
    ["pkg-config"]="pkg-config"
    ["OpenSSL"]="libssl-dev"
    ["DBus"]="libdbus-1-dev" 
    ["Udev"]="libudev-dev"
    ["Build essentials"]="build-essential"
)

for dep in "${!deps[@]}"; do
    if dpkg -l | grep -q "${deps[$dep]}"; then
        echo "✅ $dep instalado"
    else
        echo "❌ $dep FALTANTE: sudo apt install ${deps[$dep]}"
    fi
done

echo "----------------------------------------------"

# 4. Verificar Rust
echo "Verificación de Rust:"
if command -v rustc &> /dev/null; then
    echo "✅ Rust instalado: $(rustc --version)"
else
    echo "❌ Rust NO instalado"
    echo "   Instalar con: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
fi

echo "----------------------------------------------"

# 5. Verificar target WASM
echo "Target WASM:"
if command -v rustup &> /dev/null; then
    if rustup target list | grep -q "wasm32-unknown-unknown (installed)"; then
        echo "✅ wasm32-unknown-unknown instalado"
    else
        echo "❌ wasm32-unknown-unknown FALTANTE"
        echo "   Instalar con: rustup target add wasm32-unknown-unknown"
    fi
fi

echo "----------------------------------------------"

# 6. Verificar Stellar CLI
echo "Stellar CLI:"
if command -v stellar &> /dev/null; then
    echo "✅ Stellar CLI instalado: $(stellar --version | head -1)"
else
    echo "❌ Stellar CLI NO instalado"
fi

echo "=============================================="
echo "Para instalar dependencias faltantes:"
echo "sudo apt update && sudo apt install -y pkg-config libssl-dev libdbus-1-dev libudev-dev build-essential"