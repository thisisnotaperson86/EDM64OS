# NRMenu v1.0

NRMenu is a visual frontend for **ED64 Plus**, built on top of **ALTRA64**. It adds a two-panel browser, delayed box-art preview, persistent Favorites and History while keeping ALTRA64's critical ROM-loading, emulator and save routines unchanged.

NRMenu is distributed free of charge. It does not include ROMs, BIOS files, commercial artwork or any other protected content. Use at your own risk and always back up the SD card and save files.

## Quick build

Requirements: Git, Docker Desktop and PowerShell.

```bat
scripts\build.cmd
```

Output:

```text
dist\OS64P_NRMENU_v1.0.v64
```

Install to an SD card mounted as `D:`:

```bat
scripts\install-sd.cmd
```

For full documentation, see the Spanish [README](README.md) and the files under [docs](docs/).
