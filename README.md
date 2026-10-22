# 🌿 Exotica — Premium Imported Foods & Beverages App

A production-quality Flutter mobile application for **Exotica PCMC**, a luxury imported food, beverages, chocolates, snacks, and gourmet products store based in Pimpri-Chinchwad, Pune.

---

## 🎨 Design Identity
- **Brand**: Exotica PCMC — "Imported Chocolates. Premium Drinks. Global Treats."
- **Color Palette**: Matte Black + Deep Emerald (#006466) + Gold (#D4A843) + Cream
- **Typography**: Cormorant Garamond (luxury serif) + Inter (clean sans-serif)
- **Aesthetic**: Premium, minimal, luxurious — inspired by the live site at [exotica-main.vercel.app](https://exotica-main.vercel.app/)

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| **Splash** | Animated brand reveal with gold particle lines |
| **Login** | Email + Phone OTP toggle, Google/Apple sign-in |
| **Signup** | Form with loyalty welcome bonus (50 pts) |
| **OTP** | Pinput with countdown resend timer |
| **Forgot Password** | Email reset with success state |
| **Home** | Auto-scroll banner, categories, product sections, brands marquee |
| **Categories** | Animated 2-column grid |
| **Product List** | Filter chips, sort bar, shimmer loading, infinite grid |
| **Product Detail** | Gallery, rating, tabs (Details/Nutrition/Reviews), cart CTA |
| **Search** | Instant search, recent/popular suggestions |
| **Cart** | Item management, gift wrapping, coupon codes, order summary |
| **Checkout** | Address selector, Razorpay payment methods, delivery instructions |
| **Order Confirmation** | Success animation, loyalty points earned |
| **Orders** | Active/Past tabs, tracking timeline |
| **Wishlist** | Product grid, add-all-to-cart |
| **Profile** | User header, loyalty card, settings, dark mode toggle |
| **Notifications** | Type-colored cards with unread indicators |
| **Address Manager** | Home/office addresses with edit/delete |
| **Loyalty** | Points card, worth-in-rupees, how-it-works |

---

## 🛠️ Tech Stack

```yaml
State Management: Flutter Riverpod 2.x
Navigation:       GoRouter 13.x (animated page transitions)
Animation:        flutter_animate 4.x
Images:           cached_network_image
Fonts:            Cormorant Garamond (local) + Google Fonts Inter
Payment:          Razorpay Flutter
Auth:             Firebase Auth (placeholder configured)
Database:         Cloud Firestore (placeholder configured)
OTP Input:        Pinput 5.x
Banner Dots:      smooth_page_indicator
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # Root widget + theme provider
├── core/
│   ├── constants/app_constants.dart
│   ├── theme/
│   │   ├── app_colors.dart      # Brand color tokens
│   │   ├── app_typography.dart  # Cormorant Garamond + Inter
│   │   └── app_theme.dart       # Material 3 dark/light themes
│   └── widgets/common_widgets.dart  # PremiumButton, GlassCard, etc.
├── data/
│   └── mock_data.dart           # 28+ real Exotica products
├── models/
│   └── models.dart              # Product, CartItem, Order, AppUser...
├── providers/
│   └── providers.dart           # All Riverpod state notifiers
├── router/
│   └── app_router.dart          # GoRouter with 20+ routes
└── features/
    ├── splash/
    ├── auth/
    │   ├── login/
    │   ├── signup/
    │   ├── otp/
    │   └── forgot_password/
    ├── shell/                   # Bottom navigation shell
    ├── home/
    ├── categories/
    ├── products/
    │   ├── product_list/
    │   ├── product_detail/
    │   └── widgets/product_card.dart
    ├── search/
    ├── cart/
    ├── checkout/
    ├── orders/
    ├── wishlist/
    ├── profile/
    │   ├── address/
    │   └── loyalty/
    └── notifications/
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.2.0
- Android Studio / VS Code
- Android device or emulator

### Setup

```bash
# 1. Install dependencies
flutter pub get

# 2. Add Cormorant Garamond font files to assets/fonts/
#    (Download from Google Fonts: https://fonts.google.com/specimen/Cormorant+Garamond)

# 3. Create asset directories
mkdir assets\images assets\icons assets\lottie assets\fonts

# 4. Run the app
flutter run
```

---

## 🔥 Firebase Setup

> The app currently uses **mock data**. To connect to Firebase:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create project → Add Android app with package `com.exotica.pcmc`
3. Download `google-services.json` → replace `android/app/google-services.json`
4. Enable Authentication (Email/Password + Phone + Google)
5. Enable Cloud Firestore
6. Uncomment Firebase initialization in `lib/main.dart`

---

## 💳 Razorpay Integration

1. Create account at [Razorpay Dashboard](https://dashboard.razorpay.com)
2. Get your API Key ID
3. Replace `rzp_live_YOUR_KEY_HERE` in `lib/core/constants/app_constants.dart`
4. Implement `razorpay_flutter` in `lib/features/checkout/checkout_screen.dart`

---

## 🎯 Coupon Codes (Mock)

| Code | Discount |
|------|---------|
| `EXOTICA10` | 10% off |
| `WELCOME20` | 20% off |
| `PREMIUM15` | 15% off |

---

## 📞 Store Info

- **Location**: Pimpri-Chinchwad (PCMC), Pune, Maharashtra
- **WhatsApp**: +91 92969 09095
- **FSSAI**: 21526038001776
- **Website**: https://exotica-main.vercel.app/

---

## 📄 License

This application is proprietary to Exotica PCMC. All rights reserved.
