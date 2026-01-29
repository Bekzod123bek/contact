<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/07dea9db-9634-4e53-8721-e03bf4a21535" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/a824d01e-1659-436c-8731-e19416673cd4" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/df55c743-c05e-4220-9543-6b13f2b2b6f2" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/0caba0a7-1a00-4d32-90b6-c44b7e2cbad5" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/5fe260b9-8146-4ec1-b419-b091fa8538b3" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/af0f1c47-25ea-4f04-8296-1f1f933b9b76" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/1961e72f-b15f-47b7-8ebb-e2acd011fab2" />

# 📇 Contact Manager App (Flutter)

A modern **Flutter Contact Manager application** built with  
**Bloc**, **Firebase**, **go_router**, **Easy Localization**, and **persistent theme & language settings**.

---

## ✨ Features

- 📇 Create, edit, and delete contacts
- 🖼 Add contact photo from gallery
- 🔍 Real-time contact list updates
- 🌍 Multi-language support (EN / UZ)
- 🌙 Light & Dark theme
- 💾 Theme and language persistence
- 🔄 State management with Bloc
- 🧭 Modern navigation using go_router
- ☁️ Firebase backend
- 📱 Clean UI & scalable architecture

---

## 🧱 Tech Stack

| Technology | Usage |
|-----------|------|
| **Flutter** | UI framework |
| **Dart** | Programming language |
| **Firebase** | Backend & data storage |
| **flutter_bloc** | State management |
| **go_router** | Navigation (Navigator 2.0) |
| **easy_localization** | Multi-language support |
| **shared_preferences** | Persist theme & language |
| **image_picker** | Select contact images |

---

## 📂 Project Structure

```text
lib/
├── core/
│   ├── theme/
│   ├── utils/
│   │   ├── locale_storage.dart
│   │   ├── theme_storage.dart
│   │   ├── snackbar.dart
│   │   └── dialogs.dart
│   └── widgets/
├── features/
│   └── contacts/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
├── localization/
│   ├── en.json
│   └── uz.json
├── app_router.dart
├── firebase_options.dart
└── main.dart

