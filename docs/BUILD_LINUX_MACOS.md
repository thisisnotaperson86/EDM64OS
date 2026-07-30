# Compilar en Linux o macOS

## Requisitos

- Git.
- Docker Engine o Docker Desktop.
- Bash.
- Python 3.

## Verificar

```sh
chmod +x scripts/*.sh
./scripts/verify-repository.sh
```

## Compilar

```sh
./scripts/build.sh
```

Para limpiar y volver a preparar el commit upstream fijado:

```sh
./scripts/build.sh --fresh
```

El script lee `build.env`, descarga el commit exacto de ALTRA64 y usa la imagen Docker fijada por digest.

Salidas:

```text
dist/OS64P_NRMENU_v1.0.1.v64
dist/OS64P_NRMENU_v1.0.1.v64.sha256
dist/BUILD_INFO.txt
```

En macOS, Docker Desktop debe estar iniciado. En Linux, el usuario debe tener permiso para ejecutar Docker.
