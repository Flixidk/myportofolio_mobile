# 📈 Week 12 Progress Report & AI Disclosure

## ⭐ Key Accomplishments
- Finished Tutorial 9 where I:
    - Implemented navigation across all pages and a form for adding experiences with a placeholder dialog alert
- Finished Tugas Individu 8 where I:
    - Implemented a form for adding skills with a placeholder dialog alert and navigation to said skill form
    - Implemented an extra feature for the SVG preview for the skill dialog 

## ✅ Pertanyaan Reflektif: 
**Tugas Individu 8:**
1. push() menambahkan halaman baru di atas stack, pushReplacement() menambahkan halaman baru tapi menggantikan halaman yang sedang ada di atas stack sehingga tidak bisa back ke previous halaman, dan pop() berfungsi untuk meremove halaman paling atas di stack dan balik ke halaman yang ada di bawahnya. Item card menggunakan push() dengan routing ke page yang benar melalui if statement dan mengecek nama yang ada di item card tersebut. Sedangkan Drawer Home sudah saya edit sehingga menggunakan popUntil() sehingga sampai di halaman pertama di stack yakni Home page, dimana opsi lainnya di drawer cukup menggunakan push() juga (editan saya, berbeda dari tutorial).
2. Susunan Scaffold, AppBar dan Drawer memberi setiap page baru kerangka/struktur yang sama sehingga tetap konsisten, yakni AppBar menyediakan suatu title bar di atas, dan Drawer memberi suatu menu untuk navigasi yang digunakan pada tiap halaman. Salah satu contoh penggunaan warna tema portofolio adalah AppBar menu.dart yang menggunakan primary color dari Theme yang sudah di set, setiap form menggunakan warna indigo untuk AppBar dan save buttonnya, dsb.
3. Tata letak/layout yang digunakan dipilih untuk formulir tsb. karena formulir akan terbangun sebagai suatu kolom dari form fields yang di stack secara vertikal dan di align ke kiri. Untuk widget pengatur jarak dan widget penggulir, saya menggunakan widget Padding yang wrap setiap form field dengan EdgeInsets.all(8.0) untuk memberi jarak antara setiap field, dan seluruh kolom di wrap dalam SingleChildScrollView agar user dapat melakukan scrolling pada formulir apabila field forms tidak cukup dalam satu tangkapan layar.
4. GlobalKey<FormState> tertempel/attached pada form via key: _formKey. Key ini memberi access pada widget lain untuk mengakses state pada form tersebut, contoh pada onPressed tombol Save. validator: adalah suatu function pada setiap FormField yang berbeda dan berfungsi untuk validasi input form yang diberikan oleh user. Validator tersebut dipanggil saat ingin menyimpan form pada tombol Save melalui _formKey.currentState!.validate(). Contohnya pada field url devicon, keyboardType hanya mengubah jenis keyboard apa yang diperlihatkan kepada user, dia tidak melakukan validasi apapun, sehingga kita perlu validasi untuk input yang tidak berbentuk url yang valid seperti test://url.junk.


## 🤖 AI Disclosure
**Tools used** : Claude 

**How it was Used / Main Guidelines:**
- Pada minggu ini, saya banyak menggunakan AI untuk menanya terkait kode yang diberi pada tutorial, dan serta untuk bugfixing/nanya terkait penerapan kode tutorial pada model skills form saya. Saya juga menggunakan AI untuk brainstorming dan menerapkan ide untuk fitur tambahan yang dibangun pada minggu ini.

**Chat History Links** :  
[Chat for Tutorial 9](https://claude.ai/share/b423f1e3-a17b-447b-b8c3-71bb2b9e78a5) 
[Chat for Tugas Individu 8](https://claude.ai/share/c0cbab09-bda1-44f5-98b1-6387c76efdf5) 

**AI Limitations and Takeaways:**  
- Saya tidak terlalu banyak mengalami limitasi terkait penggunaan AI pada minggu ini karena menurut saya tasknya masih menurut relatif simple. Saya juga sudah coba memfamiliarisasikan diri dengan syntaxing Dart yang dihighlight pada awal conversation saya saat mengerjakan tutorial.