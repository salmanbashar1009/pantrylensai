# CookLens — Comprehensive Testing Strategy

## 1. Overview
The testing architecture guarantees high code quality, resilience against regression, and strict adherence to business logic contracts across all application layers.

```text
               +----------------------------------+
               |     Integration & E2E Tests     |  (Flutter Integration Test)
               +----------------------------------+
               |          Widget Tests            |  (Screen & Component UI)
               +----------------------------------+
               |       BLoC & State Tests         |  (bloc_test & Mocktail)
               +----------------------------------+
               |      Unit & Repository Tests     |  (Domain Models & Data Sources)
               +----------------------------------+
               |   Firestore Security Rules Tests |  (@firebase/rules-unit-testing)
               +----------------------------------+
```

---

## 2. Test Types & Tools

### 2.1 Unit Testing
- **Tools**: `test`, `mocktail`
- **Scope**: Domain model serialization/deserialization, date/expiry calculators, unit converters, prompt builders, schema validators.

### 2.2 BLoC & State Management Testing
- **Tools**: `bloc_test`, `mocktail`
- **Scope**: Verify state sequences emitted by `PantryBloc`, `ScanBloc`, `AiChatBloc`, `RecipeBloc`, `ShoppingListBloc`, `CookingBloc` in response to user events.
- **Rules**: Every event must be tested against `loading`, `success`, `failure`, and specialized states (`streaming`, `toolExecuting`).

### 2.3 Widget & UI Testing
- **Tools**: `flutter_test`
- **Scope**: Verify key screens render correctly in static mock state and respond to tap interactions (Onboarding, Home, Pantry, Scanner, Chat, Recipe Details, Shopping List, Cooking Mode).
- **Rules**: Test light mode, dark mode, empty states, error states, loading skeletons.

### 2.4 AI Service Testing
- **Tools**: `http` mock clients, `google_generative_ai` fakes
- **Scope**: Test Gemini multimodal response parsing, streaming chunk handling, invalid JSON fallback parsing, and function calling tool request parsing without spending real API tokens.

### 2.5 Firestore Security Rules Testing
- **Tools**: `@firebase/rules-unit-testing` with Firebase Emulator Suite
- **Scope**: Verify user isolation for collections (`users/{userId}/pantry`, `users/{userId}/shoppingList`, `users/{userId}/favorites`). Ensure authenticated users cannot read or write to another user's subcollections.

---

## 3. Test Coverage Goals
- **Domain & Utility Logic**: 95%+ coverage
- **BLoCs / Cubits**: 90%+ coverage
- **Repositories & Datasources**: 85%+ coverage
- **UI Widgets**: Essential user flow coverage

---

## 4. Test Execution Commands
```bash
# Run all unit and widget tests
flutter test

# Run tests with coverage report
flutter test --coverage

# Run specific BLoC test suite
flutter test test/features/pantry/presentation/bloc/pantry_bloc_test.dart

# Run Firestore Security Rules tests (requires Emulator)
firebase emulators:exec --only firestore "npm --prefix test_rules test"
```
