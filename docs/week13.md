# 📈 Week 12 Progress Report & AI Disclosure

## ⭐ Key Accomplishments
- Finished Tutorial 10 where I:
    - Implemented the model, and network integration for the experience model and setup token authentication on the DRF API
- Finished Tugas Individu 9 where I:
    - Implemented the model, and network integration for the skills model, also added an additional delete feature that sends a DELETE request to the DRF API (fitur tambahan)

## ✅ Pertanyaan Reflektif: 
**Tugas Individu 9**
1. Kita menggunakan opsi tersebut pertama agar nama field yang dari Dart cocok dengan yang di expect (e.g. startedAt menjadi started_at yang menghindari bug yang dapat menyebabkan API menolak request tsb.), kemudian includeToJson : false digunakan agar field tsb. tidak ikut masuk ke dalam request yang dikirim saat POST, tapi dapat dibaca saat GET untuk request data. 
2. Future yang diteruskan harus dalam initState() agar request hanya dikirim sekali saat dibuat, instead of dalam build() yang dapat dijalankan oleh Flutter berulang kali yang akan menybabkan request API yang berulang. API client sebaiknya melempar ApiException agar kita dapat membedakan sukses dari gagal dan memeriksa status instead of null yang tidak memberikan informasi apa-apa.
3. SessionAuthentication adalah mekanisme dari DRF yang menggunakan sesi login dari Django di browser, sedangkan TokenAuthentication memakai token di header Authorization yang digenerate oleh backend dan dapat disimpan secara local pada application dan lebih cocok juga karena tidak menyimpan any cookies/CSRF token. Keduanya tetep diaktifkan agar both website dan mobile app dapat mengakses API tersebut.
4. Job build memakai reusable workflow flutter_package.yml dari very_good_workflows. Di workflow proyek ini, tahap setup menjalankan build_runner, lalu workflow memeriksa format kode, menjalankan flutter analyze pada lib, dan menjalankan test dengan laporan coverage. Batas coverage proyek disetel ke 0, jadi test tetep dijalankan tetapi tidak ada persentase coverage minimum yang diwajibkan. Job build_apk berjalan setelah build berhasil. Job itu memasang dependensi, membuat file hasil build_runner, membangun APK release, lalu mengunggahnya sebagai artefak bernama app-release-apk. File *.g.dart diabaikan oleh Git karena file tersebut dihasilkan dari model dan anotasi, bukan diedit sebagai sumber utama.


## 🤖 AI Disclosure
**Tools used** : Codex

**How it was Used / Main Guidelines:**
- Pada tutorial, saya banyak lakukan vibecoding untuk mengisi TODO TODO pada tutorial karena saya merasa completely lost and jujur merasa gak ngerti apa-apa. There's so much new syntax and so many new stuff to take in.
- Pada tugas individu, saya juga full vibecoding untuk mengerjakan bagian tugas + fitur tambahan yakni untuk delete skill. 

**Chat History Links** :  
[Chat for Tutorial 10](https://chatgpt.com/s/cx_6b057e084764819184c1ef2238223124) 
[Chat for Tugas 9](https://chatgpt.com/s/cx_6b069692446c81919ffa8c026633fe65)

**AI Limitations and Takeaways:**  
- Mungkin untuk kedepannya saya harus lebih banyak latihan lagi terkait materi pada minggu ini, karena sejujurnya saya tidak terlalu mengerti banyak.