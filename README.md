# 🐍 Portofolio Mobile App

**Nama** : Muhammad Raihananta Adzaky Yuwono \
**NPM** : 2506547853 \
**Kelas** : PBP D 

## 📌 Project Overview
A portofolio mobile app built using Flutter for my Platform-Based Programming Class. This app connects to my Django portofilio web app via a DRF API endpoint.

## ⚙️ Setup Instructions
**Important Note:** This is the mobile client for my portfolio. It is designed to talk to my Django + Django REST Framework backend ([myportofolio](https://github.com/Flixidk/myportofolio)), so the backend needs to be running for data-driven features to work. If you have any problems setting this up, please feel free to reach out!

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (run `flutter doctor` to verify your setup)
- One run target: Chrome, an Android emulator (Android Studio), an iOS simulator (Xcode, macOS only), or a physical device with USB debugging

### 1. Clone the repository
```bash
git clone https://github.com/Flixidk/myportofolio_mobile.git
cd myportofolio_mobile
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure the API Base URL
Point the app at your running Django backend. The right host depends on where the app runs:

| Run target | Base URL |
|---|---|
| Chrome (web) | `http://localhost:8000` |
| Android emulator | `http://10.0.2.2:8000` |
| iOS simulator | `http://localhost:8000` |
| Physical device | `http://<your-computer-LAN-IP>:8000` |

> The Android emulator can't reach your computer through `localhost`, because that refers to the emulator itself. `10.0.2.2` is its alias for the host machine.

### 4. Start the Backend
In the Django project:
```bash
python manage.py runserver
```
If running on Chrome, make sure `django-cors-headers` is configured on the backend, otherwise the browser will block API requests.

### 5. Run the App
```bash
flutter run -d chrome     # web
flutter run               # connected emulator / device
```
Use `flutter devices` to list available targets. While running, press `r` for hot reload and `R` for a full restart.

## 📦 Tech Stack & Core Dependencies
- Flutter: UI framework for building the app from a single codebase.
- Dart: Programming language used by Flutter.
- Material 3: Design system and widgets (`useMaterial3: true`).
- http (planned): Package for making requests to the REST API.
- Django REST Framework: Backend API that serves the portfolio data (experiences, skills).
- Django: Backend web framework powering the API and admin.

## 📚 Weekly Documentation & AI Disclosure
For complete documentation regarding weekly progress and AI Disclosure + Utilization, please refer to this [folder](docs/). (Used for grading)
