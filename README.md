# TMemux

Dotfiles Termux yang rapi, ringan, dan siap pakai untuk penggunaan harian.
Berbasis ZSH + Neofetch + LazyVim + WakaTime, dirancang untuk layar Termux 101×39.

Repositori: https://github.com/nt-portal/TMemux

> Dirawat oleh Tarna.

---

## Tentang

TMemux menyatukan konfigurasi shell, prompt, file manager, dan editor dalam satu paket instalasi. Fokus pada kestabilan, kecepatan, dan kemudahan kustomisasi tanpa dependensi berat. Plugin ZSH hanya dimuat jika tersedia dan alias yang membutuhkan argumen telah diperbaiki menjadi fungsi.

---

## Fitur Utama

| Kategori | Detail |
|---|---|
| Shell | ZSH + Oh My Zsh, tema `ma`, plugin `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `bgnotify`, `zsh-fzf-history-search`, `zsh-autocomplete` (filter otomatis jika belum ter-clone) |
| Prompt | Tema `ma` (`➜ user@host path git:(branch)`), fallback `bash` `PS1='\w \$'` |
| Informasi Sistem | Neofetch single ASCII `tmemux.ascii` 19×42, `gap=3`, `image_backend=ascii`. Manual via `tarz` / `home` / `nt`, menampilkan `https://github.com/nt-portal/TMemux`. Tanpa autostart |
| Editor | Neovim LazyVim starter + 6 plugin: `wakatime.lua`, `noice-disable.lua`, `markview.lua`, `transparent.lua`, `markmap.lua`, `error-lens.lua` |
| Pelacakan | WakaTime via Waka-Termux (`python` + `pip wakatime`, konfigurasi `~/.wakatime.cfg`) |
| File Manager | `lf` + `eza`/`bat`/`fzf` (fallback ke `ls`/`cat` jika `eza`/`bat` belum terpasang) |
| Tombol Bawah | `extra-keys = [['ESC','/',{key:'-',popup:'|'},'HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]` |
| Font | `assest/font.ttf` → `~/.termux/font.ttf` (2.4 MB) + `termux-reload-settings` |

---

## Prasyarat

> **Stabil di Termux Official & ZeroTermux** — dioptimalkan untuk kedua varian.

- **Termux (Official)** — [termux-app/releases](https://github.com/termux/termux-app/releases) (build F-Droid direkomendasikan; versi Play Store sudah tidak di-maintain)
- **ZeroTermux (Unofficial, kompatibel penuh)** — [ZeroTermux/releases](https://github.com/hanxinhao000/ZeroTermux/releases)
- **Termux:API** (opsional, untuk `termux-battery-status` / `termux-reload-settings` pada neofetch `battery`) — [F-Droid](https://f-droid.org/en/packages/com.termux.api/) / Play Store
- Android 9+ direkomendasikan. Diuji pada Termux 0.118.3, Android 15 (Redmi 25028RN03A / serenity, UMS9230E `aarch64`).

Perbarui paket dasar sebelum instalasi:

```bash
pkg update && pkg upgrade
pkg i -y git bc
```

---

## Instalasi

```bash
git clone --depth=1 https://github.com/nt-portal/TMemux.git
cd TMemux
export COLUMNS LINES
./install.sh
```

Catatan:

- `export COLUMNS LINES` diperlukan karena `helper/screen.sh` memeriksa ukuran layar minimal `101×39`. Jika muncul `Please Zoom Out`, perkecil tampilan Termux (pinch zoom out) lalu jalankan ulang.
- Installer bersifat interaktif (`Y/n`). Jawab `Y` untuk melanjutkan setiap tahap.
- Alur: cek paket → backup dotfiles lama (`*.backup`) → salin dotfiles baru → clone 6 repositori ZSH → pasang tema ZSH → pasang LazyVim → konfigurasi WakaTime → atur shell ke `zsh`.
- Tutup dan buka kembali Termux setelah instalasi selesai agar tema dan font diterapkan.

Validasi sintaks tanpa eksekusi:

```bash
bash -n install.sh && bash -n helper/*.sh && bash -n .scripts/**/*.sh
```

---

## Penggunaan

### Perintah Utama

| Perintah | Fungsi |
|---|---|
| `tarz` / `home` / `nt` | Tampilkan Neofetch TMemux |
| `chcolor` | Ganti colorscheme (`~/.scripts/colorscheme/colors.sh`) |
| `chfont` | Ganti font (`~/.scripts/fonts/fonts.sh`) |
| `chzsh` | Ganti tema ZSH (`~/.scripts/zsh/changetheme.sh`) |
| `disk` | Info penyimpanan (`fetch.sh storage`) |
| `battery` | Info baterai (`fetch.sh battery`) |
| `nvim` | Buka LazyVim |
| `ls`, `la`, `lt`, `lta` | Daftar file via `eza` (fallback otomatis) |
| `preview` | Pratinjau file via `fzf` + `bat` |

### WakaTime

1. Buka `~/.wakatime.cfg`
2. Ganti `api_key = waka_api` dengan kunci dari https://wakatime.com/settings/account
3. Muat ulang konfigurasi: `source ~/.zshrc`

### Konfigurasi Neofetch

```
image_backend="ascii"
image_source="$HOME/.config/neofetch/tmemux.ascii"
gap=3
```

File ASCII kustom tersedia di `~/.config/neofetch/tmemux.ascii` (19 baris, lebar maksimal 39).

---

## Kustomisasi

| Kebutuhan | File |
|---|---|
| Tema ZSH | `~/.zshrc` (`ZSH_THEME="ma"`), `~/.p10k.zsh` (`p10k configure` untuk beralih ke Powerlevel10k) |
| Alias | `~/.aliases` (fungsi `convi`, `fetch`, `gitad`, `gitcom`, `cat` telah diperbaiki) |
| Warna Termux | `~/.termux/colors.properties` |
| Tombol Termux | `~/.termux/termux.properties` |
| Warna & Font | `~/.scripts/colorscheme/colors.sh`, `~/.scripts/fonts/fonts.sh` |

---

## Struktur Direktori

```
TMemux/
├── install.sh              # Entry point
├── helper/                 # 14 modul: banner, colors, animation, package, dotfiles, clone, themes, nvchad, dll.
├── .aliases                # Alias & fungsi shell
├── .zshrc                  # Konfigurasi ZSH (guard plugin + source)
├── .autostart              # Autostart non-blocking (tanpa clear, timeout 5)
├── .p10k.zsh               # Konfigurasi Powerlevel10k (opsional)
├── .termux/                # colors.properties, termux.properties, font.ttf
├── .config/                # lf, mpd, ncmpcpp, neofetch, tmemux, awesomeshot
├── .scripts/               # library, system/fetch.sh, colorscheme, fonts, zsh, toys
├── .colorscheme/           # Koleksi colorscheme
├── .fonts/                 # Koleksi font
└── optional/               # compile, neovim-settings, zshthemes
```

---

## Paket yang Terpasang

```
awesomeshot bat curl clang eza fd fzf git grep imagemagick
inotify-tools lf mpd mpc neovim nodejs openssh
neofetch python termux-api tmux yarn zsh
```

Repositori ZSH yang di-clone (6):

- `robbyrussell/oh-my-zsh`
- `zsh-users/zsh-syntax-highlighting`
- `zsh-users/zsh-autosuggestions`
- `joshskidmore/zsh-fzf-history-search`
- `marlonrichert/zsh-autocomplete`
- `jimeh/tmux-themepack`

---

## Catatan

- **Kompatibilitas:** Termux Official (F-Droid) dan ZeroTermux berjalan penuh — instalasi, neofetch `tmemux.ascii`, ZSH, dan LazyVim identik. Versi Play Store tidak direkomendasikan (tidak di-maintain).
- Backup dotfiles lama disimpan sebagai `~/.config/nvim.bak` dan `~/.*.backup` dengan timestamp.
- Font default disalin dari `assest/font.ttf` ke `~/.termux/font.ttf`. Jalankan `termux-reload-settings` untuk menerapkan.
- Jika ZSH belum terpasang, `.zshrc` tetap aman di-source oleh `bash` berkat guard `[[ -f ]]`.

---

## Lisensi

MIT — Copyright (c) 2026 Tarna <tarnawijaya@outlook.com>. Lihat [LICENSE](./LICENSE.md).

Dikembangkan oleh [TarnaWijaya](https://github.com/nt-portal).
