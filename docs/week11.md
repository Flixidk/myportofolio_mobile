# 📈 Week 11 Progress Report & AI Disclosure

## ⭐ Key Accomplishments
- Finished Tutorial 8 where I:
    - Setup and implemented the basic Flutter mobile app with placeholder widgets
- Finished Tugas 7 where I:
    - Extended the basic mobile app to use my credentials, built a profile photo widget (fitur tambahan), set custom colors on existing homepage widgets

## ✅ Pertanyaan Reflektif: 
**Tugas Individu 7:**
1. Di dalam Flutter, semua hal yang ada di layar (bahkan yang tidak terlihat di layar secara eskplisit seperti padding) merupakan widget. Widget-widget itu saling bersarang membentuk suatu tree (mirip seperti DOM tree di HTML). Suatu parent dalam tree tersebut membungkus dan mengatur childnya via children: (bisa menerima 1 ataupun sebuah list). Data dan aturan seperti tema warna juga mengalir kebawah melewati pohon tersebut.
2. Widget yang digunakan dalam aplikasi
- MyApp : Widget root aplikasi, menyiapkan MaterialApp dan tema warna
- MyHomePage : Halaman utama
- InfoCard : Reusable card yang digunakan untuk menampilkan identitas diri
- ItemCard : Tombol berwarna yang bisa ditekan 
- Beberapa widget bawaan Flutter(too many to list) seperti Row, Column, AppBar, Padding, GridView.count, SnackBar, dsb. yang berfungsi untuk menampilkan content maupun mengatur layout.
3. MaterialApp adalah pembungkus yang digunakan sebagai root widget karena menyiapkan hal-hal untuk suatu aplikasi Material Design (toolkit Google) seperti tema, halaman awal, nama aplikasi, dsb. MaterialApp akan pass-down variabel-variabel tersebut ke child widgetsnya.
4. StatelessWidget adalah suatu widget yang tidak punya state yang berubah dan dapat direbuild hanya parent rebuild, sedangkan StatefulWidget mempunyai state yang berubah dan dapat direbuild ketika memanggil setState(). StatelessWidget sebaiknya digunakan ketika tampilan widget hanya bergantung pada data yang dikirim lewat constructor dan tidak berubah sendiri e.g. InfoCard, ItemCard. StatefulWidget sebaiknya digunakan ketika tampilan widget harus berubah selama aplikasi berjalan e.g. data yang dimuat dari API Django, input form, dll.
5. BuildContext adalah penunjuk lokasi suatu widget di widget tree. Lewat context, suatu widget dapat melihat ke-atas widget tree tsb. untuk menemukan parent widget atau data yang tersedia di atasnya. Contoh, misal Theme.of(context).colorScheme.primary maka dia mencari widget Theme terdekat di atas widget tsb. dan mencari colorScheme.primary dari Theme tersebut.
6. Hot reload menginject kode baru ke aplikasi yang sedang berjalan dan membangun ulang widget tree dan mempertahankan state aplikasi tersebut, sedangkan hot restart akan menjalankan ulang aplikasi dari awal dengan kode baru, tapi tidak dicompile ulang, serta state aplikasi akan hilang. Hot reload saja tidak cukup apabila kita mengubah main(), mengubah nilai variabel global(static/final), mengubah suatu widget dari Stateless menjadi Stateful, dsb. Kita juga dapat menggunakan full restart (stop lalu flutter run lagi) apabila kita menambahkan asset, menambahkan package, dll.  


## 🤖 AI Disclosure
**Tools used** : Claude 

**How it was Used / Main Guidelines:**
- Saat mengerjakan Tugas 7, saya menggunakan Claude untuk menjelaskan kode yang sudah diimplementasikan pada tutorial, serta membantu saya dalam pengimplementasian untuk menambahkan widget berupa foto profil. Walaupun menggunakan AI, saya tetap berusaha untuk mengerti syntax dan kode yang saya impplementasikan dengan coba membaca-baca dokumentasi Flutter yang ada di web.

**Chat History Links** :  
[Chat for Tugas 7](https://claude.ai/share/6b9841c0-ac90-40a2-bce1-37e3d407f936) 



**AI Limitations and Takeaways:**  
- Saya tidak terlalu mengalami banyak limitasi pada minggu ini karena masih relatif simple, mungkin takeawaysnya adalah saya harus lebih rajin untuk belanjar syntax Dart karena masih cukup ambigu bagi saya.