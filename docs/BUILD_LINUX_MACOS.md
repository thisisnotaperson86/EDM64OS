# Compilar en Linux o macOS

Requisitos:

- Git.
- Docker Engine o Docker Desktop.
- Bash.

Desde la raíz del repositorio:

```sh
chmod +x scripts/build.sh
./scripts/build.sh
```

Para volver a clonar ALTRA64:

```sh
./scripts/build.sh --fresh
```

El binario quedará en:

```text
dist/OS64P_NRMENU_v1.0.v64
```

En macOS, Docker Desktop debe estar iniciado. En Linux, el usuario debe poder ejecutar Docker; según la instalación puede ser necesario anteponer `sudo`.
