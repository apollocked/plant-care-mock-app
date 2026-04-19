# Plant Care  🌿

A modern, beautifully designed Flutter application to help you keep your plants alive and thriving. This app allows users to track their plants, set watering/care reminders, and manage their plant collection efficiently.
i developed this app as a practical for my learning journey in flutter and mobile development 

## 🌟 Features

* **Plant Collection:** Add and manage your personal plant collection.
* **Custom Reminders:** Schedule watering, fertilizing, and other care notifications.
* **Beautiful UI:** A clean, modern, theme-aware user interface with smooth animations and glassmorphism design elements.
* **Local Storage:** Fast and secure offline data persistence.
* **Push Notifications:** Reliable local notifications to ensure you never miss a care schedule.
* **Dark/Light Mode:** Seamless theme synchronization.

## 🛠 Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** Provider
* **Local Database:** Hive
* **Notifications:** Awesome Notifications
* **Architecture:** MVVM (Model-View-ViewModel)

## 📁 Project Structure

The codebase is structured following the MVVM architecture for better scalability and separation of concerns:

```text
lib/
├── core/         # Core application configuration, themes, and global constants
├── model/        # Data classes and entities
├── services/     # External services (storage, notification handlers)
├── view/         # UI layer containing main pages and reusable widgets
├── viewmodel/    # Business logic, state management, and data preparation
└── main.dart     # Main application entry point
```

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* Appropriate IDE (Visual Studio Code, Android Studio, etc.)

### Installation

1. **Clone the project:**
   ```bash
   git clone https://github.com/apollocked/plant-care-mock-app.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd plant-care-mock-app
   ```

3. **Install required dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to submit a pull request or open an issue if you'd like to improve the app.

## 📝 License

This project is licensed under the MIT License.


**Developed by : Muhammed Jameel **