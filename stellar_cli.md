# Stellar CLI

La **Stellar CLI** es la herramienta de línea de comandos oficial y unificada para interactuar con toda la red Stellar, incluyendo sus capacidades de cuentas, pagos y contratos inteligentes (Soroban).

## ¿Qué puede hacer la Stellar CLI?

Permite interactuar con la red Stellar (futurenet, testnet, mainnet o una sandbox local) para:

### Operaciones Clásicas (L1)
- Crear y gestionar cuentas  
- Consultar balances y transacciones  
- Enviar pagos y activos  
- Revisar información del ledger  

### Contratos Inteligentes (Soroban L2)
- Compilar contratos inteligentes escritos en Rust  
- Desplegar (instalar e implementar) contratos en la red  
- Invocar funciones de contratos desplegados  
- Gestionar las identidades que firman las transacciones  

## Ejemplos de Uso Unificados

### Para Operaciones de Cuenta (L1)
```bash
# Generar una nueva cuenta y fondearla en testnet
stellar keys generate --global alice --network testnet --fund

# Consultar el balance de una cuenta
stellar account balance GABCD...1234

# Enviar un pago (usando una identidad configurada 'alice')
stellar payment --from alice --to GABCD...1234 --amount 10
```

### Para Contratos Inteligentes (Soroban)
```bash
# Compilar un contrato desde su carpeta en Rust
stellar contract build

# Desplegar un contrato a la testnet
stellar contract deploy --network testnet --source alice --wasm target/wasm32-unknown-unknown/release/mi_contrato.wasm

# Invocar una función 'hola' en un contrato desplegado
stellar contract invoke --id C... --network testnet --source alice --func hola
```