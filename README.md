# Dual Sessions for Claude

Run two Claude accounts — for example **Personal** and **Business** — side by side
in Chrome, each in its own one-click "app" window. No incognito, no re-logging-in,
both accounts stay signed in permanently.

This works by combining two native Chrome features:

1. **Profiles** — each profile has its own isolated cookie store, so two Claude
   accounts never collide.
2. **App mode** (`--app=`) — opens claude.ai in a clean window with no tabs or
   address bar, so each account feels like its own desktop app.

The launcher scripts in this repo just wire those two things together into a
double-click shortcut per account.

---

## Step 1 — Create two Chrome profiles

1. Open Chrome and click your **profile avatar** in the top-right corner.
2. Click **Add** → **Continue without an account** (or sign in with a Google
   account if you want sync).
3. Name the first one e.g. **Claude Personal**, pick a color, then **Done**.
4. Repeat to create **Claude Business**.
5. In each profile's window, go to **https://claude.ai** and log in with the
   matching account. Chrome remembers each login permanently.

At this point you already have a working dual-account setup — switch via the
avatar menu any time. The launchers below just make it one-click.

---

## Step 2 — Find each profile's *internal* directory name

> ⚠️ **This is the #1 gotcha.** The `--profile-directory` flag does **not** take
> the display name you typed ("Claude Personal"). It takes Chrome's internal
> folder name, which is something like `Default`, `Profile 1`, `Profile 2`, …

To find it:

1. Switch into the profile (via the avatar menu).
2. In that window's address bar, go to **`chrome://version`**.
3. Look at the **Profile Path** line. The **last folder** in that path is the
   value you need. Examples:
   - `…/User Data/Default` → use `Default`
   - `…/User Data/Profile 1` → use `Profile 1`

Do this for **both** profiles and note the two folder names.

---

## Step 3 — Configure the launcher for your OS

Pick your platform folder under [`launchers/`](./launchers) and edit the two
files. Each launcher has a clearly marked `PROFILE` value near the top — set it
to the internal directory name you found in Step 2.

| OS | Files to edit |
| --- | --- |
| Windows | [`launchers/windows/Claude-Personal.bat`](./launchers/windows/Claude-Personal.bat), [`Claude-Business.bat`](./launchers/windows/Claude-Business.bat) |
| macOS | [`launchers/macos/Claude-Personal.command`](./launchers/macos/Claude-Personal.command), [`Claude-Business.command`](./launchers/macos/Claude-Business.command) |
| Linux | [`launchers/linux/claude-personal.desktop`](./launchers/linux/claude-personal.desktop), [`claude-business.desktop`](./launchers/linux/claude-business.desktop) |

---

## Step 4 — Run / install the launchers

### Windows
1. Set the `PROFILE` value in each `.bat` file.
2. Double-click a `.bat` to test it.
3. To pin: once the Claude app window is open, right-click its **taskbar icon →
   Pin to taskbar**. You can also right-click the `.bat` → **Create shortcut**,
   rename it, and give it a custom icon.

### macOS
1. Set the `PROFILE` value in each `.command` file.
2. Make them executable (one time):
   ```bash
   chmod +x launchers/macos/*.command
   ```
3. Double-click a `.command` to test it. (First run: if macOS blocks it,
   right-click → **Open** → **Open**.)
4. To pin: once the Claude app window is open, right-click its **Dock icon →
   Options → Keep in Dock**.

### Linux
1. Set the `PROFILE` value in each `.desktop` file (in the `Exec=` line).
2. Make them executable and install to your applications menu:
   ```bash
   chmod +x launchers/linux/*.desktop
   cp launchers/linux/*.desktop ~/.local/share/applications/
   ```
3. Launch "Claude Personal" / "Claude Business" from your app menu, then pin to
   your dock/favorites.

---

## Alternative: let Chrome create the app icon for you

If you'd rather not touch scripts, Chrome can install claude.ai as an app
directly, tied to whichever profile is active:

1. Switch into the profile and open **https://claude.ai**.
2. Click **⋮** (top-right) → **Cast, save, and share** → **Install page as app**
   (older Chrome: **More tools → Create shortcut…**, tick *Open as window*).
3. This creates a desktop/app icon bound to that profile.

Repeat in the other profile. You'll get two app icons. The scripts in this repo
do the same thing but are scriptable, portable, and version-controlled.

---

## Troubleshooting

- **It opens the wrong account / a fresh login.** The `PROFILE` value is wrong.
  Re-check `chrome://version` → **Profile Path** for that profile and copy the
  *exact* last folder name (it's case- and space-sensitive, e.g. `Profile 1`).
- **Both launchers open the same account.** Both files have the same `PROFILE`
  value — give each its own profile's folder name.
- **"chrome is not recognized" (Windows).** Chrome isn't on your PATH. Edit the
  `.bat` and replace `chrome` with the full path, typically
  `"C:\Program Files\Google\Chrome\Application\chrome.exe"`.
- **`google-chrome: command not found` (Linux).** Your binary may be
  `google-chrome-stable`, `chromium`, or `chromium-browser`. Update the `Exec=`
  line accordingly.
- **Nothing opens, or it just focuses an existing window.** Close all windows of
  that profile and try again; app mode reuses an existing app window if one is
  already open for that profile.

---

## How it works under the hood

Each launcher runs Chrome with two flags:

```
chrome --profile-directory="<internal folder name>" --app="https://claude.ai"
```

- `--profile-directory` selects which isolated profile (and therefore which
  cookie store / logged-in account) to use.
- `--app=` opens the URL in a standalone window with no tab strip or address
  bar.

Because each profile keeps its own cookies, both Claude accounts stay logged in
independently and can be open at the same time.
