# 🌟 Stellar CLI - Documentación y Guías

Este repositorio contiene documentación práctica, guías de instalación y herramientas para trabajar con Stellar CLI en Linux.

---

## 📚 Contenido del Repositorio

### 📖 [`stellar_CLI.md`](https://github.com/mariaelisaaraya/tec-stellar/blob/master/stellar_cli.md)
**¿Qué es y para qué sirve Stellar CLI?**
- Explicación completa de las capacidades de Stellar CLI
- Diferencias entre operaciones clásicas (L1) y contratos inteligentes (Soroban L2)
- Ejemplos prácticos de uso unificado
- Comparación con la antigua Soroban CLI (ahora obsoleta)

### 🔧 [`instalacion_tecnica.md`](https://github.com/mariaelisaaraya/tec-stellar/blob/master/intalacion_tecnica.md)
**Guía técnica completa de instalación**
- Proceso paso a paso de instalación en Ubuntu/Debian
- **Errores comunes y sus soluciones**
- Instalación de Rust y dependencias del sistema
- Problemas de compilación con OpenSSL y memoria
- Alternativas: binario precompilado vs compilación desde fuente
- Información del sistema probado (Lenovo ThinkBook 13s IML)

### 🛠️ [`check-stellar-requirements.sh`](https://github.com/mariaelisaaraya/tec-stellar/blob/master/check-stellar-requirements.sh)
**Script de verificación automática**
- Verifica si tu sistema tiene todos los requisitos
- Detecta dependencias faltantes
- Revisa instalación de Rust y Stellar CLI
- Proporciona comandos específicos para resolver problemas

---

## 🚀 Inicio Rápido

### ¿Problemas con Stellar CLI?

1. **Ejecuta el script de diagnóstico:**
   ```bash
   chmod +x check-stellar-requirements.sh
   ./check-stellar-requirements.sh
   ```

---

## 📋 Información del Sistema

**Probado en:**
- Ubuntu/Debian (Lenovo ThinkBook 13s IML)
- Stellar CLI v23.0.1
- Arquitectura x86_64

---

## 🤝 Contribuciones

¿Encontraste un error nuevo? ¿Hay una solución mejor?
- Abre un issue describiendo el problema
- Comparti tu solución en las discusiones
- Propone mejoras a la documentación

---

## 📄 Licencia

Este repositorio de documentación es de uso libre para la comunidad Stellar.

---

## 🛠️ ¿Primer paso?
Ejecuta:
```bash
./check-stellar-requirements.sh
```
