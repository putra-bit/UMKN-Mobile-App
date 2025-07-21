<p align="center">
    <img src="https://jasalogocepat.com/wp-content/uploads/2024/08/8-Kegunaan-dari-Logo-untuk-Produk-UMKM-jasalogocepat.jpg" align="center" width="25%">
</p>

<h1 align="center">🏪 UMKN Mobile App</h1>

<p align="center">
    <strong>Aplikasi Mobile Terpadu untuk Manajemen UMKM Indonesia</strong>
    <br>
    <em>Comprehensive Mobile Application for Small and Medium Enterprises Management</em>
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
    <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
    <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue?style=for-the-badge" alt="Platform">
    <img src="https://img.shields.io/github/license/putra-bit/UMKN-Mobile-App?style=for-the-badge" alt="License">
    <img src="https://img.shields.io/github/last-commit/putra-bit/UMKN-Mobile-App?style=for-the-badge" alt="Last Commit">
    <img src="https://img.shields.io/github/stars/putra-bit/UMKN-Mobile-App?style=for-the-badge" alt="Stars">
</p>

<p align="center">
    <a href="#-tentang-proyek">Tentang</a> •
    <a href="#-fitur-utama">Fitur</a> •
    <a href="#-tangkapan-layar">Screenshots</a> •
    <a href="#-instalasi">Instalasi</a> •
    <a href="#-arsitektur">Arsitektur</a> •
    <a href="#-kontribusi">Kontribusi</a> •
    <a href="#-lisensi">Lisensi</a>
</p>

---

## 🎯 Tentang Proyek

**UMKN Mobile App** adalah aplikasi mobile yang dikembangkan khusus untuk mendukung ekosistem **Usaha Mikro, Kecil, dan Menengah (UMKM)** di Indonesia. Aplikasi ini dibangun menggunakan Flutter dengan arsitektur yang scalable dan modern, menyediakan tools komprehensif untuk manajemen bisnis UMKM.

### 🌟 Mengapa UMKN Mobile App?

- **🇮🇩 Fokus Lokal**: Dirancang khusus untuk kebutuhan UMKM Indonesia
- **📱 Cross-Platform**: Satu kode untuk semua platform (Android, iOS, Web, Desktop)
- **🔐 Aman & Terpercaya**: Sistem autentikasi yang robust dan secure
- **🎨 User-Friendly**: Interface yang intuitif dan modern
- **⚡ Performa Tinggi**: Optimized untuk performa maksimal

---

## ✨ Fitur Utama

### 🔐 **Sistem Autentikasi**
- ✅ Registrasi pengguna baru dengan validasi lengkap
- ✅ Login aman dengan session management
- ✅ Validasi password yang kuat
- ✅ Forgot password & reset functionality

### 👥 **Role-Based Access Control**
- **👤 User Dashboard**: Tools manajemen bisnis untuk pemilik UMKM
  - Dashboard analitik bisnis
  - Manajemen produk dan inventory
  - Laporan penjualan
  - Customer management
  
- **⚙️ Admin Panel**: Panel kontrol administratif
  - User management
  - System monitoring
  - Business analytics
  - Content moderation

### 🎨 **User Experience Premium**
- 🌓 Dark/Light theme dengan smooth transition
- 📱 Responsive design untuk semua ukuran layar
- 🎯 Navigasi intuitif dengan bottom navigation
- 🔄 Loading states dan error handling yang elegant
- ⚡ Smooth animations dan transitions

### 🔧 **Fitur Teknis**
- 🌐 RESTful API integration ready
- 🔄 Real-time data synchronization
- 📊 State management dengan Provider pattern
- 🏗️ Modular architecture
- 🧪 Comprehensive testing suite
- 📦 Offline capability (coming soon)

---

## 📱 Tangkapan Layar

<div align="center">

### 🔐 Authentication Screens
<img src="https://via.placeholder.com/250x450/02569B/FFFFFF?text=Login+Screen" width="200" style="margin: 10px;">
<img src="https://via.placeholder.com/250x450/0175C2/FFFFFF?text=Register+Screen" width="200" style="margin: 10px;">

### 🏠 Dashboard Screens
<img src="https://via.placeholder.com/250x450/4CAF50/FFFFFF?text=User+Dashboard" width="200" style="margin: 10px;">
<img src="https://via.placeholder.com/250x450/FF9800/FFFFFF?text=Admin+Panel" width="200" style="margin: 10px;">

</div>

> **📝 Note**: Screenshots akan diperbarui seiring dengan pengembangan UI. Silakan clone repository untuk melihat tampilan terbaru.

---

## 📁 Struktur Proyek

```
UMKN-Mobile-App/
├── 📱 Platform Files
│   ├── android/                 # Android configuration
│   ├── ios/                     # iOS configuration  
│   ├── web/                     # Web deployment
│   ├── windows/                 # Windows desktop
│   ├── linux/                  # Linux desktop
│   └── macos/                  # macOS desktop
│
├── 📚 Source Code
│   ├── lib/
│   │   ├── 🚀 main.dart         # App entry point
│   │   ├── 🧩 Components/       # Reusable UI components
│   │   │   └── MyTextField.dart # Custom input field
│   │   ├── 🎮 controller/       # Business logic & state
│   │   │   ├── backend.dart     # API integration
│   │   │   └── provider_theme.dart # Theme management
│   │   └── 📄 pages/           # Application screens
│   │       ├── login.dart       # Login screen
│   │       ├── registerPage.dart # Registration screen
│   │       ├── HomeUser.dart    # User dashboard
│   │       └── HomeAdmin.dart   # Admin dashboard
│
├── 🧪 test/                    # Testing files
├── 📋 pubspec.yaml             # Dependencies
└── 📖 README.md                # Documentation
```

---

## 🚀 Instalasi

### 📋 Prerequisites

Pastikan sistem Anda memiliki:

- **Flutter SDK** ≥ 3.0.0 ([Install Guide](https://docs.flutter.dev/get-started/install))
- **Dart SDK** (included with Flutter)
- **Git** ([Download](https://git-scm.com/downloads))

**Platform-specific requirements:**
- **Android**: Android Studio + Android SDK
- **iOS**: Xcode (macOS only)
- **Web**: Chrome browser
- **Desktop**: Visual Studio Build Tools (Windows) / Xcode (macOS) / Build Essential (Linux)

### ⚡ Quick Start

```bash
# 1. Clone repository
git clone https://github.com/putra-bit/UMKN-Mobile-App.git
cd UMKN-Mobile-App

# 2. Install dependencies
flutter pub get

# 3. Verify Flutter setup
flutter doctor

# 4. Run the app
flutter run
```

### 🎯 Platform-Specific Commands

<details>
<summary><strong>📱 Mobile (Android/iOS)</strong></summary>

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios
```
</details>

<details>
<summary><strong>🌐 Web</strong></summary>

```bash
# Development
flutter run -d chrome

# Build for production
flutter build web
```
</details>

<details>
<summary><strong>🖥️ Desktop</strong></summary>

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```
</details>

### 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage report
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart

# Integration tests
flutter drive --target=test_driver/app.dart
```

---

## 🏗️ Arsitektur

### 📐 Design Patterns

**UMKN Mobile App** mengimplementasikan **Clean Architecture** dengan separation of concerns:

```
┌─────────────────────────────────────┐
│           Presentation Layer         │
│  (UI, Widgets, State Management)    │
├─────────────────────────────────────┤
│            Business Layer           │
│     (Use Cases, Business Logic)     │
├─────────────────────────────────────┤
│              Data Layer             │
│    (Repository, API, Local DB)      │
└─────────────────────────────────────┘
```

### 🔧 State Management

- **Provider Pattern**: Global state management
- **ChangeNotifier**: Theme & user session
- **StatefulWidget**: Local component state

### 🧩 Key Components

| Component | Description | Location |
|-----------|-------------|----------|
| `MyTextField` | Custom input field with validation | `lib/Components/` |
| `ThemeProvider` | App-wide theme management | `lib/controller/` |
| `Backend` | API service layer | `lib/controller/` |
| Authentication Pages | Login/Register with validation | `lib/pages/` |

---

## 🤝 Kontribusi

Kami sangat menghargai kontribusi dari komunitas! 🙌

### 🛠️ Cara Berkontribusi

1. **🍴 Fork** repository ini
2. **🌿 Buat branch** untuk fitur Anda (`git checkout -b feature/FiturKeren`)
3. **💾 Commit** perubahan (`git commit -m 'Menambahkan fitur keren'`)
4. **📤 Push** ke branch (`git push origin feature/FiturKeren`)
5. **📝 Buat Pull Request**

### 📋 Guidelines

- Ikuti [Flutter Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Tulis commit message yang jelas dan deskriptif
- Tambahkan tests untuk fitur baru
- Update dokumentasi jika diperlukan
- Pastikan semua tests pass sebelum PR

### 🐛 Melaporkan Bug

Gunakan [GitHub Issues](https://github.com/putra-bit/UMKN-Mobile-App/issues) dengan template:
- **Bug description**: Deskripsi singkat bug
- **Steps to reproduce**: Langkah-langkah reproduksi
- **Expected vs Actual**: Hasil yang diharapkan vs aktual
- **Environment**: OS, Flutter version, device

---

## 🗺️ Roadmap

### 🎯 Short-term Goals
- [ ] **🔔 Push Notifications**: Real-time notifications
- [ ] **📊 Advanced Analytics**: Business insights dashboard  
- [ ] **💰 Payment Integration**: Payment gateway integration
- [ ] **📱 Offline Support**: Data sync when offline

### 🌟 Long-term Vision
- [ ] **🤖 AI-Powered Insights**: Business recommendations using AI
- [ ] **🌐 Multi-language Support**: Indonesian, English, regional languages
- [ ] **📈 Advanced Reporting**: Comprehensive business reports
- [ ] **🔗 Third-party Integrations**: E-commerce, social media, accounting tools

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

```
MIT License

Copyright (c) 2024 UMKN Mobile App

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

- **💙 Flutter Team**: Framework luar biasa untuk cross-platform development
- **🏪 Komunitas UMKM Indonesia**: Inspirasi dan feedback berharga
- **🌟 Open Source Community**: Kontributor dan maintainer libraries
- **🎨 Jasa Logo Cepat**: Logo design yang menarik
- **🚀 GitHub**: Platform collaboration yang powerful

---

## 📞 Kontak & Dukungan

<div align="center">

### 🔗 Quick Links
[![GitHub Issues](https://img.shields.io/badge/GitHub-Issues-red?style=for-the-badge&logo=github)](https://github.com/putra-bit/UMKN-Mobile-App/issues)
[![GitHub Discussions](https://img.shields.io/badge/GitHub-Discussions-blue?style=for-the-badge&logo=github)](https://github.com/putra-bit/UMKN-Mobile-App/discussions)

### 👨‍💻 Developer
[![GitHub Profile](https://img.shields.io/badge/putra--bit-GitHub-black?style=for-the-badge&logo=github)](https://github.com/putra-bit)

### 📧 Support
Untuk pertanyaan teknis atau support, silakan buat [GitHub Issue](https://github.com/putra-bit/UMKN-Mobile-App/issues/new) atau mulai [Discussion](https://github.com/putra-bit/UMKN-Mobile-App/discussions/new).

</div>

---

<div align="center">
    <h3>🇮🇩 Dibuat dengan ❤️ untuk Komunitas UMKM Indonesia</h3>
    <p><em>"Membangun ekosistem digital yang kuat untuk UMKM Indonesia"</em></p>
    
    ⭐ **Jangan lupa berikan star jika project ini bermanfaat!** ⭐
</div>

---

<p align="center">
    <sub>© 2024 UMKN Mobile App. All rights reserved.</sub>
</p>
