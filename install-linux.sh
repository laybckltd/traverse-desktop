#!/usr/bin/env sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
APP_NAME="Traverse"
APP_SLUG="traverse"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/512x512/apps"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$APP_DIR" "$ICON_DIR" "$BIN_DIR"

cp "$SCRIPT_DIR/Launch-Traverse-Linux.sh" "$BIN_DIR/$APP_SLUG-web-app"
chmod +x "$BIN_DIR/$APP_SLUG-web-app"

if [ -f "$SCRIPT_DIR/assets/traverse.png" ]; then
  cp "$SCRIPT_DIR/assets/traverse.png" "$ICON_DIR/$APP_SLUG.png"
fi

cat > "$APP_DIR/$APP_SLUG.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=Interactive KTU S4 CSE study platform with offline notes, flashcards & mock exam lab
Exec=$BIN_DIR/$APP_SLUG-web-app
Icon=$ICON_DIR/$APP_SLUG.png
Terminal=false
Categories=Education;Science;Utility;
StartupWMClass=$APP_SLUG
StartupNotify=true
EOF

chmod +x "$APP_DIR/$APP_SLUG.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
fi

echo "Installed $APP_NAME to your Linux Applications menu ($APP_DIR/$APP_SLUG.desktop)."
