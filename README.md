# Book App

A simple Flutter application to manage and display books.

![App Screenshot 1](assets/images/screenshot1.png)  
![App Screenshot 2](assets/images/screenshot2.png)

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

Ensure you have Flutter installed on your machine. You can follow the installation instructions from the official Flutter website:  
[Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

### Installation

Clone the repository:
```bash
git clone https://github.com/ahmedomar201/book_app.git
cd book_app
```

Install dependencies:
```bash
flutter pub get
```

### Running the App

To run the application:
```bash
flutter run
```

## Project Structure

- `lib/`: Contains the Flutter app code.

## Features ✨
- Browse books with infinite scroll.
- Search books by title/author.
- Expand/Collapse book summaries.
- Error handling for network issues.
- Offline caching to allow browsing without internet.
- Clean Architecture (Cubit for state management).

## Bonus Feature (Optional) 🌟
- **Offline Caching**:  
  - Implemented offline mode by caching the fetched book data.
  - If the device is offline or an API request fails, the app displays the relevant cached data seamlessly.

## Libraries Used 🛠️
- flutter_bloc
- Dio
- cached_network_image
- get_it
- dartz
- flutter_native_splash
- shared_preferences
- path_provider

## Design Decisions 🧠
- **Cubit** was chosen for lightweight and easy state management.
- **Repository pattern** used to separate data handling and UI logic.
- **Clean architecture** to maintain scalability and testing ease.
- API errors and empty fields are handled gracefully.

## Notes 📋
- The app is responsive across different mobile and tablet screen sizes.
- Error messages and empty states are handled to ensure a smooth UX.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
