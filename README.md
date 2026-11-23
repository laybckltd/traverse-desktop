# Traverse — Windows & Linux Desktop Web App Kit

Run **Traverse** (`https://wonderful-creponne-588f15.netlify.app`) as a dedicated standalone desktop window on **Windows 10/11** and **Linux** (Ubuntu, Fedora, Arch, Debian, Mint), with offline caching, keyboard shortcuts, and optional Electron `.exe` / `.AppImage` / `.deb` installers.

---

## Option A — Windows 10 / 11 (Zero Build Tools)

1. Double-click **`Launch-Traverse-Windows.bat`** to launch Traverse immediately in a dedicated chromeless app window (Edge or Chrome).
2. Or right-click **`Install-Windows-Shortcut.ps1` → Run with PowerShell** to pin a **Traverse** shortcut directly to your **Desktop** and **Start Menu**.
3. Alternatively, open `https://wonderful-creponne-588f15.netlify.app` in **Microsoft Edge** or **Google Chrome** and click the **Install** icon in the address bar.

---

## Option B — Linux (Ubuntu / Fedora / Arch / KDE / GNOME)

Run the one-step installer in your terminal:

```bash
chmod +x install-linux.sh Launch-Traverse-Linux.sh
./install-linux.sh
```

This installs the launcher icon and `traverse.desktop` into `~/.local/share/applications/` so **Traverse** appears in your GNOME / KDE application menu and launches in its own dedicated window.

To launch directly without installing a menu entry:

```bash
./Launch-Traverse-Linux.sh
```

---

## Option C — Native `.exe` (Windows) & `.AppImage` / `.deb` (Linux) via Electron

The `electron/` folder contains a complete Electron desktop wrapper and GitHub Actions workflow:

- **Build locally (requires Node.js 20+):**
  ```bash
  cd electron
  npm install
  npm run build:win    # outputs dist/*.exe (NSIS + Portable)
  npm run build:linux  # outputs dist/*.AppImage and dist/*.deb
  ```
- **Build in the Cloud (no local SDKs needed):**
  Push this folder to GitHub and run **Actions → Build Traverse Desktop (Windows & Linux)** (`.github/workflows/build-desktop-app.yml`) to download compiled `.exe`, `.AppImage`, and `.deb` installers.
