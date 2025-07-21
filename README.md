<p align="center">
    <img src="https://jasalogocepat.com/wp-content/uploads/2024/08/8-Kegunaan-dari-Logo-untuk-Produk-UMKM-jasalogocepat.jpg" align="center" width="30%">
</p>

<h1 align="center">UMKN Mobile App</h1>

<p align="center">
    <em>Mobile Application for Small and Medium Enterprises (UMKM) Management</em>
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
    <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
    <img src="https://img.shields.io/github/license/putra-bit/UMKN-Mobile-App.git?style=for-the-badge" alt="license">
    <img src="https://img.shields.io/github/last-commit/putra-bit/UMKN-Mobile-App.git?style=for-the-badge" alt="last-commit">
</p>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
  - [Testing](#testing)
- [Architecture](#-architecture)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

UMKN Mobile App is a comprehensive Flutter-based mobile application designed to support Small and Medium Enterprises (UMKM) in Indonesia. The app provides essential tools for business management, user authentication, and administrative functions to help UMKM owners streamline their operations.

**Key Highlights:**
- Cross-platform support (Android, iOS, Web, Desktop)
- Role-based access control (Admin/User)
- Modern Flutter UI with responsive design
- Secure authentication system
- Scalable architecture with proper separation of concerns

---

## ✨ Features

### 🔐 Authentication System
- User registration and login
- Secure session management
- Password validation and security

### 👥 Role-Based Access
- **User Dashboard**: Business management tools for UMKM owners
- **Admin Panel**: Administrative controls and oversight features
- Profile management and settings

### 🎨 User Experience
- Modern and intuitive interface
- Responsive design for all screen sizes
- Dark/Light theme support (theme provider implemented)
- Custom UI components for consistency

### 🔧 Technical Features
- Backend integration ready
- RESTful API support
- State management with Provider pattern
- Modular component architecture

---

## 📱 Screenshots

> Add screenshots of your app here to showcase the UI and key features

---

## 📁 Project Structure

```
UMKN-Mobile-App/
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── web/                     # Web deployment files
├── windows/                 # Windows desktop files
├── linux/                  # Linux desktop files
├── macos/                  # macOS desktop files
├── lib/                    # Main Flutter source code
│   ├── main.dart           # App entry point
│   ├── Components/         # Reusable UI components
│   │   └── MyTextField.dart
│   ├── controller/         # State management & backend logic
│   │   ├── backend.dart    # API integration
│   │   └── provider_theme.dart # Theme management
│   └── pages/              # Screen/Page widgets
│       ├── login.dart      # Login screen
│       ├── registerPage.dart # Registration screen
│       ├── HomeUser.dart   # User dashboard
│       └── HomeAdmin.dart  # Admin dashboard
├── test/                   # Unit and widget tests
├── pubspec.yaml           # Dependencies and project config
└── README.md              # This file
```

---

## 🚀 Getting Started

### Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK** (Latest stable version)
- **Dart SDK** (Comes with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control

**Platform-specific requirements:**
- **Android**: Android Studio, Android SDK
- **iOS**: Xcode (macOS only)
- **Web**: Chrome browser
- **Desktop**: Platform-specific build tools

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/putra-bit/UMKN-Mobile-App.git
cd UMKN-Mobile-App
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Verify Flutter installation**
```bash
flutter doctor
```

4. **Check available devices**
```bash
flutter devices
```

### Running the App

Choose your target platform:

**Android/iOS:**
```bash
flutter run
```

**Web:**
```bash
flutter run -d chrome
```

**Desktop (Windows):**
```bash
flutter run -d windows
```

**Desktop (macOS):**
```bash
flutter run -d macos
```

**Desktop (Linux):**
```bash
flutter run -d linux
```

### Testing

Run the test suite:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

---

## 🏗️ Architecture

This project follows Flutter best practices with a clean architecture approach:

### State Management
- **Provider Pattern**: Used for theme management and app state
- **Stateful/Stateless Widgets**: For local component state

### Project Organization
- **Components**: Reusable UI widgets
- **Pages**: Screen-level widgets
- **Controllers**: Business logic and state management
- **Backend**: API integration and data handling

### Key Components
- `MyTextField`: Custom input field component
- `ThemeProvider`: App-wide theme management
- `Backend`: API service integration
- Authentication pages with form validation

---

## 🤝 Contributing

We welcome contributions to improve the UMKN Mobile App! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow Flutter/Dart style guidelines
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Ensure code passes all existing tests

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- UMKM community in Indonesia
- Open source contributors
- Logo design from [Jasa Logo Cepat](https://jasalogocepat.com/)

---

## 📞 Contact & Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/putra-bit/UMKN-Mobile-App.git/issues)
- **Developer**: [putra-bit](https://github.com/putra-bit)

---

<p align="center">
    <strong>Built with ❤️ for Indonesian UMKM Community</strong>
</p>
