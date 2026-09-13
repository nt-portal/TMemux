# CONTRIBUTING.md

Terima kasih telah tertarik untuk berkontribusi pada repository nt-portal/TMemux.

Dokumen ini berisi panduan untuk membantu Anda dalam memberikan kontribusi, baik berupa pelaporan masalah (bug), usulan fitur baru, maupun pengiriman kode (pull request).

---

## Daftar Isi

1. Kode Etik
2. Bagaimana Cara Berkontribusi?
   - Melaporkan Bug
   - Mengajukan Fitur Baru
   - Mengirimkan Pull Request (PR)
3. Standar Penulisan Kode
4. Format Pesan Commit

---

## Kode Etik

Kami berkomitmen untuk menyediakan lingkungan berkontribusi yang inklusif, ramah, dan bebas dari intimidasi. Diharapkan semua kontributor:
- Saling menghormati perbedaan pendapat dan pengalaman.
- Memberikan kritik konstruktif dan menerima masukan dengan lapang dada.
- Mengutamakan kolaborasi positif demi kemajuan proyek.

---

## Bagaimana Cara Berkontribusi?

### 1. Melaporkan Bug

Jika Anda menemukan kendala atau kesalahan (bug) saat menggunakan TMemux:
1. Periksa halaman Issues pada repository terlebih dahulu untuk memastikan masalah tersebut belum pernah dilaporkan.
2. Jika belum ada, buat New Issue.
3. Jelaskan masalah secara rinci:
   - Deskripsi singkat mengenai bug.
   - Langkah-langkah untuk mereproduksi masalah (steps to reproduce).
   - Perilaku yang diharapkan vs perilaku yang terjadi.
   - Log error jika ada.
   - Informasi lingkungan (versi Termux, OS, dll.).

### 2. Mengajukan Fitur Baru

Punya ide menarik untuk meningkatkan TMemux?
1. Buka New Issue di repository.
2. Pilih atau beri judul yang jelas, misalnya: `[Feature Request] Judul Fitur`.
3. Jelaskan mengapa fitur tersebut berguna dan bagaimana cara kerjanya.

### 3. Mengirimkan Pull Request (PR)

Langkah-langkah untuk mengirimkan kontribusi kode:

1. Fork Repository
   Klik tombol Fork di pojok kanan atas halaman repository nt-portal/TMemux.

2. Clone Repository Anda
   git clone https://github.com/USERNAME-ANDA/TMemux.git
   cd TMemux

3. Buat Branch Baru
   Gunakan nama branch yang deskriptif:
   git checkout -b feature/nama-fitur-anda
   git checkout -b fix/penjelasan-bug

4. Lakukan Perubahan dan Uji Coba
   - Tulis kode baru atau perbaiki kode yang ada.
   - Pastikan skrip/program dapat berjalan dengan baik di lingkungan Termux tanpa error.

5. Commit Perubahan
   Gunakan pesan commit yang jelas dan informatif:
   git add .
   git commit -m "feat: menambahkan fitur X"

6. Push ke Branch Anda
   git push origin feature/nama-fitur-anda

7. Buat Pull Request
   - Buka repository asli nt-portal/TMemux.
   - Klik New Pull Request.
   - Pilih branch Anda dan berikan penjelasan mengenai perubahan yang dilakukan pada deskripsi PR.
