# Browser OS (v0.1)

A tiny Linux system that boots straight into a full-screen Chromium browser.
No desktop, no extras. Modern websites work because it is real Chromium.

## How it works
- Base: Debian (minimal, no recommended extras)
- Screen: `cage`, a tiny program that shows exactly one app full-screen
- Browser: Chromium, set up with small caches and no background extras
- Memory: compressed RAM swap (zram) so low-RAM laptops cope better
- Wi-Fi: the start page has a Wi-Fi button (type the password, connect)

## Build it (no Linux needed, uses GitHub)
1. Make a free GitHub account and a new repository called `browser-os`.
2. Upload everything from this folder, including the hidden `.github` folder.
3. Open the repository's **Actions** tab, pick **Build Browser OS ISO**, click **Run workflow**.
4. Wait about 20 to 40 minutes. When it turns green, open the run and download **BrowserOS-iso**.
5. Unzip it to get `BrowserOS.iso`.

## Put it on a laptop
1. Get a USB stick (4 GB or more). Everything on it will be erased.
2. Use the free tool Rufus (Windows) or balenaEtcher (Windows, Mac, Linux) to write `BrowserOS.iso` to it.
3. Plug it into the laptop, turn it on, and press the boot menu key (often F12, F2, Esc or F10).
4. Pick the USB stick. The browser should appear in under a minute.

To try it without a laptop: `qemu-system-x86_64 -m 1024 -cdrom BrowserOS.iso`

## Known limits of v0.1
- Not tested on real hardware yet. The first build may fail on a package name; the Actions log shows which one.
- Runs from the USB stick and forgets everything when turned off (no saved logins yet).
- 64-bit PCs only. No Bluetooth or printing yet.
