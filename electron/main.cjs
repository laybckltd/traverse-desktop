const { app, BrowserWindow, shell } = require('electron');
const path = require('path');

const APP_URL = "https://wonderful-creponne-588f15.netlify.app";
let allowedHost = '';
try {
  allowedHost = new URL(APP_URL).hostname;
} catch {
  allowedHost = '';
}

function createMainWindow() {
  const win = new BrowserWindow({
    width: 1400,
    height: 880,
    minWidth: 960,
    minHeight: 620,
    title: "Traverse",
    backgroundColor: '#060312',
    autoHideMenuBar: true,
    icon: path.join(__dirname, 'build', 'icon.png'),
    webPreferences: {
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
    },
  });

  win.webContents.setWindowOpenHandler(({ url }) => {
    try {
      const targetHost = new URL(url).hostname;
      if (targetHost === allowedHost || targetHost.endsWith('.web.app') || targetHost.endsWith('.run.app')) {
        return { action: 'allow' };
      }
    } catch {
      // Fall through to external shell
    }
    shell.openExternal(url);
    return { action: 'deny' };
  });

  win.webContents.on('did-fail-load', () => {
    const html = `<!doctype html><html><body style="font-family:system-ui;background:#060312;color:#f8fafc;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;text-align:center;"><div><h2 style="margin-bottom:8px;">Traverse Offline</h2><p style="color:#94a3b8;margin-bottom:16px;">Check your connection and retry to sync updates.</p><button onclick="location.href='${APP_URL}'" style="padding:10px 18px;border-radius:10px;border:none;background:#2563eb;color:white;font-weight:600;cursor:pointer;">Retry Connection</button></div></body></html>`;
    win.loadURL('data:text/html;charset=utf-8,' + encodeURIComponent(html));
  });

  win.loadURL(APP_URL);
}

const gotLock = app.requestSingleInstanceLock();
if (!gotLock) {
  app.quit();
} else {
  app.on('second-instance', () => {
    const [existing] = BrowserWindow.getAllWindows();
    if (existing) {
      if (existing.isMinimized()) existing.restore();
      existing.focus();
    }
  });

  app.whenReady().then(() => {
    createMainWindow();
    app.on('activate', () => {
      if (BrowserWindow.getAllWindows().length === 0) {
        createMainWindow();
      }
    });
  });

  app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
      app.quit();
    }
  });
}
