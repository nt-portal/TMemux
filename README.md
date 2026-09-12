<h1 align="center">TMemux</h1>

<p align="center">
  Dotfiles Termux yang rapi, ringan, dan nyaman dipakai harian.
</p>

<p align="center">
  ZSH + Neofetch single ASCII + LazyVim + WakaTime — autostart, siap pakai.
</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="MIT"></a>
  <a href="https://github.com/nt-portal/TMemux"><img src="https://img.shields.io/github/stars/nt-portal/TMemux?style=flat-square" alt="Stars"></a>
  <a href="https://github.com/nt-portal/TMemux"><img src="https://img.shields.io/badge/platform-Termux%20%7C%20Android-blue?style=flat-square" alt="Termux"></a>
</p>

<p align="center">
  <a href="https://github.com/nt-portal/TMemux">https://github.com/nt-portal/TMemux</a>
</p>

---

TMemux bikin Termux kamu enak dipandang dan enak dipakai. Sekali pasang, shell jadi rapi, prompt jelas, neofetch keluar otomatis, dan editor langsung siap ngoding. Tidak ribet, tidak berat — pas untuk layar Termux 101×39.

> Cocok buat kamu yang buka Termux setiap hari — mau ngoding, ngoprek, atau sekadar cek sistem dengan cepat.

## Kenapa TMemux

- **Autostart Neofetch** — buka Termux langsung lihat info sistem + ASCII khas TMemux, tetap bisa dipanggil manual `tarz` / `home` / `nt`.
- **Ringan & rapi** — single ASCII 19×42, gap 3, tanpa fetch ganda.
- **Siap ngoding** — LazyVim starter + font sudah terpasang, tinggal buka `nvim`.
- **Kebiasaan tetap jalan** — WakaTime catat aktivitas shell otomatis.
- **Tombol pas di jempol** — extra-keys default nyaman untuk HP.

## Prasyarat

- **Termux (Official)** — [unduh](https://github.com/termux/termux-app/releases)
- **ZeroTermux (Unofficial)** - [unduh](https://github.com/hanxinhao000/ZeroTermux/releases)

Perbarui dulu:

```bash
pkg update && pkg upgrade
pkg i -y git bc
```

## Instalasi

```bash
git clone --depth=1 https://github.com/nt-portal/TMemux.git
cd TMemux
export COLUMNS LINES
./install.sh
```

`export COLUMNS LINES` wajib — installer mengecek ukuran layar `101×39`. Kalau muncul `Please Zoom Out`, cubit kecilkan (zoom out) Termux lalu jalankan lagi. Ikuti `Y/n` sampai selesai, lalu buka ulang Termux.

**Yang terjadi di balik layar:** cek paket → backup dotfiles lama (`*.backup`) → salin dotfiles baru → clone plugin ZSH (6 repo) → pasang tema ZSH → pasang LazyVim → pasang WakaTime (`python` + `pip wakatime`) → atur shell ke `zsh`.

## Sekilas Tampilan

Buka Termux atau ketik salah satu — hasilnya sama:

```bash
tarz   # atau home / nt
```

```
             .:===--==--..                 u0_a269@localhost
           :+**####%%#%%#*+:               -----------
          -+==---==+#%%%%#*#:              OS: Android 15 aarch64
        .:=+++========*%%%%#*.             Host: Redmi 25028RN03A (serenity)
       .+###*+====+*#%%##-                 Kernel: 5.15.194-android13-8
       :*#**+*####*===+*#%#%#-             Uptime: up 2 days, 11 hours
      .-+===++*+===*####*-                 Packages: 347 (apt)
      -=++*++++++======+###*+---:.         Shell: bash 5.3.15
      -=+***++++=======+*####%%%##=:       Terminal: Termux 0.118.3
      :=+++==++*+++++=++++*#%%%##%%#-      CPU: UMS9230E (8)
      -*##*++++++++++++++++##****####-     Memory: 2643MiB / 3790MiB
     .=**+++=++++++=+*##*++++*####-        Disk (/): 14G / 52G
      -**+++++++++-=###*++*###+.           Battery: via fetch.sh
      .-+++:.*#*++*###*:                    https://github.com/nt-portal/TMemux
        :+#####+++- .+++*+++++++##*=
        -+++++:  ===++++====###-
      .:=+++++++=:..-+**+=-+##*.
:::--:-+===+***++++===-::-=====++=+##*:
::+*-.:--===+++====-------:::::-+#%%#:
```

> Link `https://github.com/nt-portal/TMemux` muncul di baris bawah — enak buat dibagikan.

## Cara Pakai

```bash
tarz        # tampilkan neofetch TMemux
home        # sama — alias alternatif
nt          # sama — alias pendek
chcolor     # ganti colorscheme
chfont      # ganti font (default 2.4 MB JetBrains/assest)
chzsh       # ganti tema ZSH
disk        # info storage
battery     # info baterai
nvim        # buka LazyVim
```

**WakaTime:** buka `~/.wakatime.cfg`, ganti `api_key = waka_api` dengan key kamu dari [wakatime.com/settings/account](https://wakatime.com/settings/account), lalu `source ~/.zshrc`.

**Tombol bawah:** default dua baris

```
ESC  /  - |  HOME UP END PGUP
TAB  CTRL ALT LEFT DOWN RIGHT PGDN
```
(`-` ada popup `|`)

## Yang Kamu Dapat

| Bagian | Isi |
|--------|-----|
| Shell | ZSH + Oh-My-Zsh, plugin autosuggestions, syntax-highlighting, bgnotify, fzf-history, autocomplete |
| Tampilan | Neofetch single ASCII `tmemux.ascii` 19×42, autostart + manual `tarz/home/nt` |
| Editor | Neovim LazyVim starter + 6 plugin (wakatime, noice-disable, markview, transparent, markmap, error-lens) |
| Pelacak | WakaTime via Waka-Termux (`python` + `pip wakatime`, `~/.wakatime.cfg`) |
| Paket | `awesomeshot bat curl clang eza fd fzf git grep imagemagick inotify-tools lf mpd mpc neovim nodejs openssh neofetch python termux-api tmux yarn zsh` |

## Catatan Kecil

- `neofetch` perlu ada (`pkg i -y neofetch`). Preview di atas pakai data HP asli sebagai contoh.
- Butuh layar `101×39` — kalau gagal, `export COLUMNS LINES` dulu.
- Backup lama aman di `~/.config/nvim.bak` dan `~/*.backup`.
- Buka ulang Termux setelah instal agar tema & font terasa.

## Lisensi

MIT — Copyright (c) 2026 **Tarna** <tarnawijaya@outlook.com>. Lihat [LICENSE](./LICENSE.md).

<p align="center">
  Dibuat oleh <a href="https://github.com/nt-portal">TarnaWijaya</a>
</p>
