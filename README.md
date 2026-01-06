# 🎵 Replay App

A full-stack, cross-platform music streaming application built with **Flutter** and **FastAPI**. This project serves as a modern Spotify clone, featuring a sleek user interface, robust state management, and a high-performance backend.

---

## 🚀 Features

- **Cross-Platform Support**: Runs seamlessly on Android, iOS, Web, Windows, macOS, and Linux.
- **User Authentication**: Secure signup and login functionality.
- **Music Playback**: High-quality audio streaming with background playback support.
- **State Management**: Powered by **Riverpod** for a reactive and scalable architecture.
- **Dynamic Content**: Explore music by genres and categories.
- **Modern UI**: Clean, responsive design inspired by Spotify.

---

## 🛠️ Tech Stack

### Frontend (Client)
- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Audio Playback**: [just_audio](https://pub.dev/packages/just_audio) & [just_audio_background](https://pub.dev/packages/just_audio_background)
- **Networking**: [http](https://pub.dev/packages/http)
- **Functional Programming**: [fpdart](https://pub.dev/packages/fpdart)
- **UI Components**: `flex_color_picker`, `dotted_border`, `gradient_icon`

### Backend (Server)
- **Framework**: [FastAPI](https://fastapi.tiangolo.com/) (Python)
- **ORM**: [SQLAlchemy](https://www.sqlalchemy.org/)
- **Data Validation**: [Pydantic](https://docs.pydantic.dev/)
- **Database**: SQLite (Default) / Support for PostgreSQL

---

## 📂 Project Structure

```text
Music-App/
├── client/                # Flutter Application
│   ├── lib/               # Dart source code
│   ├── assets/            # Images and fonts
│   └── pubspec.yaml       # Flutter dependencies
└── server/                # FastAPI Backend
    ├── models/            # Database models
    ├── routes/            # API endpoints
    ├── pydantic_schemas/  # Data validation schemas
    ├── middleware/        # Custom middlewares
    └── main.py            # Entry point
```

---

## ⚙️ Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Python 3.10+](https://www.python.org/downloads/)

### Backend Setup
1. Navigate to the server directory:
   ```bash
   cd server
   ```
2. Create a virtual environment and activate it:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. Install dependencies:
   ```bash
   pip install fastapi uvicorn sqlalchemy pydantic
   ```
4. Run the server:
   ```bash
   uvicorn main:app --reload
   ```

### Frontend Setup
1. Navigate to the client directory:
   ```bash
   cd client
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```
