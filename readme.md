  # 🚀 Termux Environment Over ADB

[![Termux](https://img.shields.io/badge/Termux-Environment-green?logo=termux&style=for-the-badge)](https://termux.dev/en/)
[![ADB](https://img.shields.io/badge/ADB-Android_Debug_Bridge-blue?logo=android&style=for-the-badge)](https://developer.android.com/studio/command-line/adb)
[![Root](https://img.shields.io/badge/Root-Optional-orange?style=for-the-badge)]()

> **Access your Termux environment seamlessly from another terminal via ADB.**
> This guide explains how to inject the Termux environment variables into a standard ADB shell session to get a fully functional terminal.

---

## 📋 Prerequisites

**ADB CONNECTION IS BACKBONE**
| Device Status | Requirement | Action |
| :--- | :--- | :--- |
| **🔐 Non-Rooted** | **Debug Version Only** | You **must** install the debug build. Standard Play Store versions will not work with `run-as`. <br> [📥 Download Debug Build from GitHub](https://github.com/termux/termux-app/releases) |
| **🔓 Rooted** | Any Version | You can use any version of Termux (Play Store, F-Droid, or GitHub). |
---

## 🛠️ Step-by-Step Guide

### 1. Prepare Termux Environment
Open your **Termux app** on the Android device and export your current environment variables to a file.

```bash
# Run this inside the Termux App
env > env
```

### 2. Connect via ADB

On your computer (or secondary device), establish an ADB connection and start the shell.

```bash
# Verify connection
adb devices

# Enter the device interactive shell
adb shell
```

---

### 3. Switch User Context

Depending on your root status, use one of the following methods to switch to the Termux user context.

#### 🅰️ Method A: Non-Rooted Devices

If you are using the **Debug** version of Termux (as required), use `run-as`:

```bash
run-as com.termux
```

> [!WARNING]
> If you get an error here, it means the app is not debuggable. Please check the **Prerequisites** section and install the Debug APK.

#### 🅱️ Method B: Rooted Devices

You have two choices.

**Option 1: Impersonate Termux User (Recommended)**:

This command finds the UID of the Termux app and switches to it, giving you the exact privileges of the app.

```bash
su - $(pm list packages -U | grep "com.termux " | grep -o '[0-9]*$')
```

**Option 2: Stay as Root**
If root privileges are fine for your use case, simply run:

```bash
su
```
---

### 4. Inject Environment & Start Shell

Once you have switched users (via `run-as` or `su`), run the following command to load the environment variables and start your shell.

```bash
export $(cat /data/data/com.termux/files/home/env | xargs) && bash
```

> [!IMPORTANT]
> **Permission Denied?**
> If you get a "Permission Denied" error here, it means you are not running as the Termux user or Root. The standard `shell` user cannot access these files. Ensure Step 3 was successful.

> [!TIP]
> **Custom Shells:**
> Termux uses `bash` by default. If you use a different shell (like `zsh` or `fish`), replace `&& bash` with `&& zsh`.
> This process will automatically load your shell configuration files (like `.bashrc` or `.zshrc`).
> 
> **Shortcut for Windows:**
> Add the funtions in [sample.ps1](sample.ps1) to your powershell profile by running `notepad $PROFILE` in poweshell.
> Then you can just call the funtions instead of writing all commands again.
