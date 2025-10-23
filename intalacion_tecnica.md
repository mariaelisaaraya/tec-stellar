# Technical Documentation: Stellar CLI and Soroban on Linux
## Errores Comunes y Soluciones  

### System Information  
- **Tested Distribution:**: Ubuntu/Debian (Lenovo ThinkBook 13s IML)  
- **Stellar CLI Version:**: v23.5.0  
- **Architecture**: x86_64  

---  


# Instalación de Rust y Stellar CLI en Linux

Este documento resume los pasos realizados para instalar Rust y configurar el entorno necesario para trabajar con contratos en Stellar (Soroban).

---

## 1. Instalación de Rust

Se descargó e instaló Rust usando `rustup`, que es el instalador oficial y gestor de toolchains de Rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Durante la instalación:

- Rust se instala en el directorio de usuario:
  - `Rustup home`: `/home/ar3lisa/.rustup`
  - `Cargo home`: `/home/ar3lisa/.cargo`
- Se añadió el directorio de binarios de Cargo al `PATH` del sistema (`~/.profile` y `~/.bashrc`).
- Se eligió la instalación estándar.
- La versión instalada fue `rustc 1.89.0`.

### Configuración del entorno

Para que los comandos de Rust funcionen inmediatamente en la sesión actual de terminal:

```bash
source "$HOME/.cargo/env"
```

Se verificó la instalación con:

```bash
rustc --version
# rustc 1.89.0 (29483883e 2025-08-04)
```

## 2. Soporte para WebAssembly

Soroban (Stellar) requiere compilar a WebAssembly (wasm). Se añadió el target:

```bash
rustup target add wasm32-none
```

Esto descarga e instala los componentes necesarios para compilar contratos Rust a WASM.

## 3. Instalación de Stellar CLI

Finalmente, se instaló la CLI de Stellar (Soroban) usando Cargo:

```bash
cargo install --locked stellar-cli
```

> ⚠️ **Nota**: antes de la instalación de la CLI, al intentar `stellar --version`,  
> la terminal devolvía un error indicando que no se encontraba el comando.  
> Esto es normal hasta que la CLI esté instalada y el binario esté en el `PATH`.

## 3.1 Error encontrado

Durante la instalación, la compilación de la crate openssl-sys falló:

```bash
warning: openssl-sys@0.9.107: Could not find directory of OpenSSL installation...
error: failed to run custom build command for `openssl-sys v0.9.107`
...
Could not find openssl via pkg-config:
Could not run `PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 pkg-config --libs --cflags openssl`
The pkg-config command could not be found.
...
Make sure you also have the development packages of openssl installed.
For example, `libssl-dev` on Ubuntu or `openssl-devel` on Fedora.
```

El error principal es que faltan las dependencias de desarrollo de OpenSSL en el sistema. 

Te puedo seguir tirando errores tipo 

```bash
  note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
warning: build failed, waiting for other jobs to finish...
    Building [================>        ] 423/613: wasm-opt-sys(build), stellar-xdr
```

Solución Guia:
Ejecuta estos comandos para instalar TODAS las dependencias necesarias:

```bash
# 1. Instalar dependencias del sistema
sudo apt update

# 2. Instalar TODAS las dependencias que podrían ser necesarias

sudo apt install -y \
    pkg-config \
    libssl-dev \
    libdbus-1-dev \
    libudev-dev \
    build-essential \
    cmake \
    clang \
    llvm

# 3. Instalar Stellar CLI con cargo
cargo install --locked stellar-cli

# 4. Verificar que se instaló correctamente
stellar --version

```

Si te da un error de memoria corrobora con `free -h`
```bash
# 1. Aumentar el swap
# Crear swap adicional de 4GB
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# 2. Ver nuevo espacio swap
free -h

# 3. Activar el swap existente 
sudo swapon -a


# 4. Intentar compilar con más memoria disponible
cargo install --locked stellar-cli
```

## 🚀 Verificación de instalación de Stellar CLI

Ejecutar el comando:

```bash
stellar --version
```

Resultado:

```bash
stellar 23.0.1 (44d65c93765ce078232921807f34437ea9fbbddb)
stellar-xdr 23.0.0-rc.2 (eee82d4314c715bf971f6c7c85aa81e989b8a19a)
xdr curr (4b7a2ef7931ab2ca2499be68d849f38190b443ca)
```

### Desglose línea por línea

- stellar 23.0.1 (44d65c9...)
→ Versión del CLI Stellar (23.0.1), compilada desde el commit 44d65c9.

- stellar-xdr 23.0.0-rc.2 (eee82d4...)
→ Versión de la librería XDR (23.0.0 release candidate 2), commit eee82d4.

- xdr curr (4b7a2ef...)
→ Versión current de las definiciones XDR, commit 4b7a2ef.

## ❓ ¿Por qué tantas dependencias?

La **Stellar CLI** es una herramienta compleja que necesita:

- Todo esto: https://sh.rustup.rs (que le falta y depende mucho de tu cual versión de Ubuntu)

### Hacer el script ejecutable
chmod +x check-stellar-requirements.sh

### Ejecutar verificación
./check-stellar-requirements.sh

### ¿Qué verifica el script?

- Sistema operativo (Ubuntu version)
- Memoria RAM y Swap disponible
- Dependencias del sistema (pkg-config, OpenSSL, DBus, Udev)
- Rust y toolchain instalado
- Target WASM para contratos
- Stellar CLI instalado

---

### ✅ Recomendación
Si solo se quiere **usar Stellar CLI** y no **compilar desde fuente**, lo más sencillo es **usar el binario precompilado** o dockerizar uno porque viste todo lo que hicimos, mucho!

# Entonces... ¡BASTA DE COMPILAR! Hola binario precompilado(MUY RECOMENDADA)

En otra oportunidad lo explico mejor porque tendría que limpiar nuevamente toda la maquina y ahora cero ganas pero te dejo en parte de como son los pasos: 

## Stellar CLI - Binarios Precompilados

La información del binario precompilado está en la página oficial de releases de GitHub de Stellar CLI:

📖 **Documentación Oficial:**  
https://github.com/stellar/stellar-cli/releases  

🎯 **Release específico (v23.0.1):**  
https://github.com/stellar/stellar-cli/releases/tag/v23.0.1  

---

### 📋 En la página de releases se puede encontrar:

**1. Assets (Archivos disponibles)**  
- `stellar-cli-x86_64-unknown-linux-gnu.tar.gz` → Linux (compressed)  
- `stellar-cli-x86_64-unknown-linux-gnu` → Linux (binario directo)  
- `stellar-cli-aarch64-apple-darwin.tar.gz` → macOS Apple Silicon(esto no nos importa pero lo dejo) 
- `stellar-cli-x86_64-apple-darwin.tar.gz` → macOS Intel(esto no nos importa pero lo dejo)   
- `stellar-cli-x86_64-pc-windows-msvc.zip` → Windows(esto no nos importa pero lo dejo)  

**2. Instrucciones oficiales**  
En cada release suelen incluir instrucciones de instalación para diferentes sistemas operativos.

---

### 🔗 Otras fuentes oficiales

- **Documentación principal:**  
  https://developers.stellar.org/docs/build/smart-contracts/getting-started/setup#install-the-stellar-cli  

- **Stellar Developer Center:**  
  https://developers.stellar.org/  

- **GitHub Organization:**  
  https://github.com/stellar  

---

### 📝 Nota importante
Los comandos que te di son la versión simplificada de lo que encontrarías en las releases.  
La documentación oficial a veces muestra la versión comprimida (`.tar.gz`), pero el **binario directo** también está disponible y es más simple para instalación rápida.  

⚡ **Siempre es buena práctica verificar las releases oficiales por si hay versiones más recientes.**  
La **v23.0.1** es la estable más reciente al mes de agosto 2025.
