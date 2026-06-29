# 🚀 TPBERP PBD Updates

> **Library Update Resmi** dari Sistem TPBERP

Repository ini khusus didedikasikan untuk menyimpan dan mendistribusikan *compiled library* (file `.PBD`) terbaru dari aplikasi TPBERP. File-file di sini dirancang untuk tersinkronisasi otomatis dengan komputer klien demi memastikan semua sistem berjalan dengan versi mutakhir.

---

## 📦 Isi Repository

- `bcapp.pbd` - Library utama sistem
- `bcact.pbd` - Library sistem accounting
- `bc2faktur.pbd` - Library e-Faktur
- `TPBERP-Updater.bat` - **Script Auto-Updater untuk Klien**

---

## 🛠️ Cara Menggunakan (Untuk Klien)

Bagi pengguna atau klien TPBERP, Anda tidak perlu mengunduh file ini satu per satu secara manual. Cukup gunakan script **Auto-Updater** yang telah disediakan:

1. Unduh file **`TPBERP-Updater.bat`** dari repository ini.
2. Pindahkan file tersebut ke dalam **Folder Instalasi Aplikasi TPBERP** di komputer Anda.
3. **Klik ganda (Double-Click)** file tersebut.
4. Jendela Command Prompt akan muncul, secara otomatis menutup aplikasi TPBERP yang sedang berjalan agar proses aman, dan mendownload versi terbaru dari seluruh library `.PBD` (termasuk modul terpusat `ceisa.pbd`) menggunakan teknologi pengecekan ETag HTTP. Jika sistem mendeteksi tidak ada perubahan file, maka proses download akan dilewati dengan pesan **Sudah Up to Date**.

Sangat praktis, aman, dan hemat kuota!

---
*Dikelola secara otomatis oleh Sistem TPBERP. Harap tidak memodifikasi file PBD secara manual.*
