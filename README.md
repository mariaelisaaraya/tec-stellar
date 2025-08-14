# Documentación Técnica: Stellar CLI y Soroban en Linux  
## Errores Comunes y Soluciones  

### Información del Sistema  
- **Distribución testeada**: Ubuntu/Debian (Lenovo ThinkBook 13s IML)  
- **Versión Stellar CLI**: v23.5.0  
- **Arquitectura**: x86_64  

---  

### 1. Error de Compilación: Linker `cc` no encontrado  
**Descripción del Error**  

Al intentar instalar Stellar CLI usando:


```bash
curl -L https://github.com/stellar/stellar-cli/releases/download/v23.5.0/stellar-x86_64-unknown-linux-gnu.tar.gz | tar xz
```

Se presenta el siguiente error durante la compilación:

```bash
Compiling ryu v1.0.18
error: linker `cc` not found
  |
  = note: No such file or directory (os error 2)
error: could not compile `serde_json` (build script) due to 1 previous error
warning: build failed, waiting for other jobs to finish...
error: could not compile `serde` (build script) due to 1 previous error
error: could not compile `proc-macro2` (build script) due to 1 previous error
error: could not compile `libc` (build script) due to 1 previous error
error: could not compile `typenum` (build script) due to 1 previous error
error: failed to compile `stellar-cli v23.0.1`, intermediate artifacts can be found at `/tmp/cargo-installL1MwIU`.
To reuse those artifacts with a future compilation, set the environment variable `CARGO_TARGET_DIR` to that path.
```

### **Causa del Error**  
El sistema no tiene instaladas las herramientas de desarrollo básicas de C/C++, específicamente:  
- Compilador GCC  
- Herramientas de desarrollo (`make`, etc.)  
- Headers del sistema  

### **Solución**  
Instalar las herramientas de desarrollo esenciales:  

```bash
sudo apt update && sudo apt install -y build-essential
```

### 📦 **¿Qué incluye `build-essential`?**  

El paquete `build-essential` en sistemas basados en **Debian/Ubuntu** instala las herramientas fundamentales para compilar software en C/C++ y gestionar paquetes. Contiene:  

| Herramienta       | Descripción                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| **`gcc`**         | Compilador GNU C (*GNU Compiler Collection*).                               |
| **`g++`**         | Compilador GNU C++ (para código C++).                                       |
| **`make`**        | Utilidad para automatizar la compilación (ejecuta instrucciones de `Makefile`). |
| **`libc6-dev`**   | Bibliotecas de desarrollo de C (headers como `<stdio.h>`, `<stdlib.h>`, etc.). |
| **`dpkg-dev`**    | Herramientas para construir paquetes `.deb` (empaquetado en Debian).        |

**Nota**: También instala dependencias secundarias como `binutils`, `patch`, y otros componentes esenciales.  


---


---  
# Notas para el Equipo de Stellar

---

### Problema de Dependencias

El error del linker `cc` sugiere que la **documentación oficial** debería incluir los **prerequisitos del sistema** de forma más clara.

---

### Método de Instalación

Considerar la posibilidad de proporcionar **binarios pre-compilados**, así como **instrucciones claras** sobre las dependencias necesarias para la compilación.

---

### Detección de Sistema

Sería muy útil que el instalador pudiera **detectar automáticamente las dependencias faltantes** en el sistema del usuario.
