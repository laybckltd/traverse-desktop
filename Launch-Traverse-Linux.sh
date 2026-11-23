#!/usr/bin/env sh
set -eu

APP_URL="https://wonderful-creponne-588f15.netlify.app"
APP_CLASS="traverse"

for browser in google-chrome chromium chromium-browser microsoft-edge brave-browser vivaldi; do
  if command -v "$browser" >/dev/null 2>&1; then
    exec "$browser" --app="$APP_URL" --class="$APP_CLASS" --new-window >/dev/null 2>&1 &
  fi
done

if command -v flatpak >/dev/null 2>&1; then
  for app_id in com.google.Chrome org.chromium.Chromium com.microsoft.Edge com.brave.Browser; do
    if flatpak info "$app_id" >/dev/null 2>&1; then
      exec flatpak run "$app_id" --app="$APP_URL" --class="$APP_CLASS" >/dev/null 2>&1 &
    fi
  done
fi

if command -v xdg-open >/dev/null 2>&1; then
  exec xdg-open "$APP_URL" >/dev/null 2>&1 &
fi

echo "Please open $APP_URL in your browser." >&2
exit 1
