# Publicar NRMenu en GitHub

## Opción recomendada: Git por línea de comandos

### 1. Instalar herramientas

- Crear una cuenta en GitHub.
- Instalar Git for Windows.
- Opcional: instalar GitHub CLI (`gh`).

### 2. Elegir el nombre

Recomendado:

```text
NRMenu
```

Descripción sugerida:

```text
Frontend visual para ED64 Plus basado en ALTRA64, con carátulas, Favoritos e Historial.
```

### 3. Preparar la carpeta

Extraer este paquete, por ejemplo:

```text
C:\NR64\NRMenu
```

Abrir Git Bash o PowerShell en esa carpeta.

### 4. Configurar identidad de Git

```sh
git config --global user.name "NovenRetro"
git config --global user.email "TU-CORREO-DE-GITHUB"
```

Para no publicar el correo real, se puede usar el correo `noreply` proporcionado por GitHub.

### 5. Inicializar y crear el primer commit

```sh
git init -b main
git add .
git status
git commit -m "Release NRMenu v1.0"
```

Antes del commit, revisar que `git status` no muestre ROMs, saves, boxarts comerciales, tokens o archivos privados.

### 6. Crear el repositorio vacío en GitHub

1. En GitHub, pulsar `+` → `New repository`.
2. Owner: la cuenta de NovenRetro.
3. Repository name: `NRMenu`.
4. Visibility: `Public`.
5. **No marcar** README, `.gitignore` ni License, porque ya existen localmente.
6. Pulsar `Create repository`.

### 7. Enlazar y subir

Reemplazar `TU-USUARIO`:

```sh
git remote add origin https://github.com/TU-USUARIO/NRMenu.git
git remote -v
git push -u origin main
```

## Alternativa con GitHub CLI

Después del primer commit:

```sh
gh auth login
gh repo create NRMenu --public --source=. --remote=origin --push
```

## Alternativa con GitHub Desktop

1. Abrir GitHub Desktop.
2. `File` → `Add Local Repository`.
3. Elegir la carpeta NRMenu.
4. Si aún no es repositorio, usar `Create a repository`.
5. Confirmar el primer commit.
6. Pulsar `Publish repository`.
7. Desmarcar `Keep this code private` para publicarlo.

## Crear la release v1.0.0

### 1. Compilar

```bat
scripts\build.cmd
```

### 2. Crear tag

```sh
git tag -a v1.0.0 -m "NRMenu v1.0.0"
git push origin v1.0.0
```

### 3. Crear Release en la web

1. Abrir el repositorio.
2. `Releases` → `Draft a new release`.
3. Elegir el tag `v1.0.0`.
4. Título: `NRMenu v1.0.0`.
5. Copiar el resumen de `CHANGELOG.md`.
6. Adjuntar:
   - `dist/OS64P_NRMENU_v1.0.v64`
   - `dist/OS64P_NRMENU_v1.0.v64.sha256`
7. Aclarar que el release no incluye ROMs, BIOS, emuladores ni boxarts comerciales.
8. Publicar.

## Después de publicar

En `Settings`:

- Activar Issues.
- Activar Discussions si se desea comunidad.
- Proteger `main` y exigir pull requests cuando haya colaboradores.
- Añadir topics: `nintendo64`, `ed64plus`, `altra64`, `retrogaming`, `homebrew`, `n64`.

## Actualizaciones futuras

```sh
git checkout -b feature/nueva-funcion
# cambios
git add .
git commit -m "Add nueva función"
git push -u origin feature/nueva-funcion
```

Luego crear un Pull Request hacia `main`.
