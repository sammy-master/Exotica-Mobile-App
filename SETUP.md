# 🚀 Exotica App — Setup & Run Guide

## Step 1: Install Flutter SDK

Flutter is not currently installed on this machine. Follow these steps:

### Option A — Quick Install via VS Code (Recommended)
1. Open VS Code
2. Press `Ctrl+Shift+X` (Extensions)
3. Search for **Flutter** and install the official **Flutter** extension by Dart Code
4. Press `Ctrl+Shift+P` → type `Flutter: New Project` → it will prompt to install Flutter SDK automatically
5. Install to a path like `C:\flutter`

### Option B — Manual Install
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\flutter`
3. Add `C:\flutter\bin` to your System PATH

---

## Step 2: Verify Installation

Open a **new** terminal (PowerShell) and run:
```powershell
flutter --version
flutter doctor
```

Expected output:
```
Flutter 3.x.x • channel stable
✓ Flutter SDK found
✓ Android toolchain found
```

---

## Step 3: Get Dependencies

```powershell
cd "c:\Users\admin\Desktop\VS Codes\Mobile Application"
flutter pub get
```

---

## Step 4: Add Fonts

Download **Cormorant Garamond** from Google Fonts:
https://fonts.google.com/specimen/Cormorant+Garamond

Download all weights and place the `.ttf` files in:
```
assets/fonts/
├── CormorantGaramond-Light.ttf
├── CormorantGaramond-Regular.ttf
├── CormorantGaramond-Medium.ttf
├── CormorantGaramond-SemiBold.ttf
├── CormorantGaramond-Bold.ttf
├── CormorantGaramond-LightItalic.ttf
└── CormorantGaramond-Italic.ttf
```

---

## Step 5: Connect a Device

**Option A — Physical Android phone:**
1. Enable Developer Options on your phone (tap Build Number 7 times)
2. Enable USB Debugging
3. Connect via USB

**Option B — Android Emulator:**
```powershell
flutter emulators --create --name pixel_7
flutter emulators --launch pixel_7
```

---

## Step 6: Run the App

```powershell
cd "c:\Users\admin\Desktop\VS Codes\Mobile Application"
flutter run
```

Or in VS Code:
- Open the project folder
- Press `F5` or click Run → Start Debugging

---

## 🔥 Firebase Setup (Optional — for production)

The app works with mock data out of the box. To connect real Firebase:

1. Go to https://console.firebase.google.com
2. Create project → Add Android app → Package: `com.exotica.pcmc`
3. Download `google-services.json`
4. Replace: `android/app/google-services.json`
5. Enable: Authentication, Firestore, Storage

---

## ⚡ Quick Start Summary

```powershell
# 1. Install Flutter (once)
winget install Flutter.Flutter

# 2. In project directory:
flutter pub get

# 3. Run
flutter run
```

---

## 📱 Current App Features (All Implemented)

- ✅ Splash screen with gold animations
- ✅ Login (Email + Phone OTP)  
- ✅ Sign Up with loyalty bonus
- ✅ Home with banner carousel, categories, product sections
- ✅ Product catalog (28+ real Exotica products)
- ✅ Product detail with reviews & gallery
- ✅ Search with instant results
- ✅ Shopping cart with coupon codes & gift wrapping
- ✅ Checkout with Razorpay payment selection
- ✅ Order confirmation with loyalty points
- ✅ Orders tracking
- ✅ Wishlist
- ✅ Full profile with dark mode toggle
- ✅ Notifications
- ✅ Address management
- ✅ Loyalty points screen
