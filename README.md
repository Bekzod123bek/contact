<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/a824d01e-1659-436c-8731-e19416673cd4" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/df55c743-c05e-4220-9543-6b13f2b2b6f2" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/0caba0a7-1a00-4d32-90b6-c44b7e2cbad5" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/5fe260b9-8146-4ec1-b419-b091fa8538b3" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/af0f1c47-25ea-4f04-8296-1f1f933b9b76" />
<img width="400" height="860" alt="image" src="https://github.com/user-attachments/assets/1961e72f-b15f-47b7-8ebb-e2acd011fab2" />

A simple and clean Contact Manager application built with Flutter, Firebase, and Bloc/Cubit state management.
The app allows users to add, edit, delete contacts, store data in Firebase Firestore, save images locally, and switch language & theme dynamically.

✨ Features
➕ Add new contacts
✏️ Edit existing contacts
🗑 Delete contacts
📸 Pick and store contact images locally
☁️ Store contact data in Firebase Firestore
🌍 Multi-language support (EN / UZ)
🎨 Light & Dark theme support
🔄 Real-time updates with Firestore
🧠 Clean architecture with Cubit (flutter_bloc)
🧰 Tech Stack
Flutter
Firebase
Firebase Core
Cloud Firestore
State Management
flutter_bloc (Cubit)
Localization
JSON-based localization (no ARB)
Image Picker


📂 Project Structure
lib/
 ├── features/
 │   └── contacts/
 │       ├── data/
 │       ├── domain/
 │       └── presentation/
 │           ├── cubit/
 │           └── pages/
 ├── localization/
 │   ├── en.json
 │   └── uz.json
 └── main.dart
