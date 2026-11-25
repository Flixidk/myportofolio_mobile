# 🐍 Portfolio Mobile App

[![CI](https://github.com/Flixidk/myportofolio_mobile/actions/workflows/main.yaml/badge.svg?branch=main)](https://github.com/Flixidk/myportofolio_mobile/actions/workflows/main.yaml)

**Nama** : Muhammad Raihananta Adzaky Yuwono \
**NPM** : 2506547853 \
**Kelas** : PBP D 

## 📌 Project Overview
A portfolio mobile app built using Flutter for my Platform-Based Programming class. This app connects to my Django portfolio web app through a Django REST Framework API endpoint.

## ⚙️ Setup Instructions
This Flutter app connects to the Django REST Framework backend. The backend source is in the [Django portfolio repository](https://github.com/Flixidk/myportofolio), and the deployed site/API is available at [muhammad-raihananta-myportofolio.pws.cs.ui.ac.id](https://muhammad-raihananta-myportofolio.pws.cs.ui.ac.id/).

The API base URL is the deployed site origin. The app uses these endpoints:

- Experiences: `/api/v1/experiences/`
- Skills: `/api/v1/skills/`
- Authentication: `/api/v1/auth/token/`

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (run `flutter doctor` to verify your setup)
- One run target: Chrome, an Android emulator (Android Studio), an iOS simulator (Xcode, macOS only), or a physical device with USB debugging

### 1. Clone the repository
```bash
git clone https://github.com/Flixidk/myportofolio_mobile.git
cd myportofolio_mobile
```

### 2. Install Dependencies and Generate JSON Serialization Code
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

`build_runner` generates the JSON serialization files used by the experience and skill models. Run it again after changing a model or its JSON annotations.

### 3. Configure the API Base URL
The app reads its backend URL from the `API_BASE_URL` Dart define. For the deployed backend, use:

```text
https://muhammad-raihananta-myportofolio.pws.cs.ui.ac.id
```

For local backend development, use the host appropriate to your run target:

| Run target | Base URL |
|---|---|
| Chrome (web) | `http://localhost:8000` |
| Android emulator | `http://10.0.2.2:8000` |
| iOS simulator | `http://localhost:8000` |
| Physical device | `http://<your-computer-LAN-IP>:8000` |

> The Android emulator can't reach your computer through `localhost`, because that refers to the emulator itself. `10.0.2.2` is its alias for the host machine.

### 4. Run the App
Run against the deployed backend:
```bash
flutter run --dart-define=API_BASE_URL=https://muhammad-raihananta-myportofolio.pws.cs.ui.ac.id
```

To run against a local backend, start Django in the backend repository:
```bash
python manage.py runserver
```
Then pass the matching local URL, for example:
```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

To build a release APK configured for the deployed backend:
```bash
flutter build apk --release --dart-define=API_BASE_URL=https://muhammad-raihananta-myportofolio.pws.cs.ui.ac.id
```

Use `flutter devices` to list available targets. While running, press `r` for hot reload and `R` for a full restart. When running on Chrome against a local backend, configure Django CORS to allow the web app's origin.

## 📦 Tech Stack & Core Dependencies
- Flutter: UI framework for building the app from a single codebase.
- Dart: Programming language used by Flutter.
- Material 3: Design system and widgets (`useMaterial3: true`).
- http: Package for making requests to the REST API.
- Django REST Framework: Backend API that serves the portfolio data (experiences, skills).
- Django: Backend web framework powering the API and admin.

## 📚 Weekly Documentation & AI Disclosure
For complete documentation regarding weekly progress and AI Disclosure + Utilization, please refer to this [folder](docs/). (Used for grading)
