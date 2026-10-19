# CookLens — Implementation Tasks Roadmap

## Phase 0 — Specification & Architecture
- [x] **TASK-000**: Define Complete Specification Suite (`requirements.md`, `tasks.md`, `GEMINI.md`, `design.md`, `issues.md`, `test.md`).
  - **Req IDs**: All
  - **Dependencies**: None
  - **Acceptance Criteria**: All 6 plan documents created in `plans/` detailing system requirements, M3 design system, Gemini architecture, tasks, issue tracker, and testing strategy.

---

## Phase 1 — Project Foundation
- [x] **TASK-001**: Initialize Flutter Project & Package Configuration
  - **Req IDs**: `NFR-001`, `ACC-001`
  - **Dependencies**: TASK-000
  - **Acceptance Criteria**: Flutter application initialized with `pubspec.yaml`, analysis options configured (`very_good_analysis` or strict linter rules), clean folder architecture established under `lib/`.
- [x] **TASK-002**: Material 3 Design System & Theme Engine
  - **Req IDs**: `ACC-001`, `ACC-003`
  - **Dependencies**: TASK-001
  - **Acceptance Criteria**: Centralized `AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppElevation` defined. Light and Dark themes working seamlessly.

---

## Phase 2 — Raw UI First (Static Mock UI)
- [ ] **TASK-003**: Onboarding Flow Screens
  - **Req IDs**: `FR-020`, `FR-021`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Welcome, How CookLens works, AI/privacy explanation, Dietary & allergen setup screens built with mock data.
- [ ] **TASK-004**: Home Screen UI
  - **Req IDs**: `FR-004`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Greeting, Pantry summary card, "Use Soon" expiring items preview, suggested recipe carousel, and quick action buttons (`Scan Pantry`, `Add Ingredient`, `Ask AI`, `Shopping List`).
- [ ] **TASK-005**: Pantry Screen UI
  - **Req IDs**: `FR-001`, `FR-002`, `FR-003`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Tabs for Fridge, Freezer, Pantry. Cards with quantity, unit, expiry, category. Search bar, filter chips, and sorting dialog.
- [ ] **TASK-006**: Scan Pantry & Camera Selection UI
  - **Req IDs**: `FR-005`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Camera preview placeholder, photo capture & gallery picker UI, multi-image thumbnail preview, and "Scan with AI" button.
- [ ] **TASK-007**: Ingredient Review Screen UI
  - **Req IDs**: `FR-006`, `FR-007`
  - **Dependencies**: TASK-006
  - **Acceptance Criteria**: List of detected ingredients with editable text fields for name, quantity, unit, category, location, expiry. Checkbox select/deselect all, "Add to Pantry", "Scan Again", and "Cancel".
- [ ] **TASK-008**: AI Chat Assistant UI
  - **Req IDs**: `FR-008`, `FR-110`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Chat message bubbles (User & AI), suggestion chips, input field with send button, stop streaming button, retry button, loading indicators.
- [ ] **TASK-009**: Recipe Results & Details UI
  - **Req IDs**: `FR-010`, `FR-011`, `FR-013`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Recipe cards grid/list. Detailed view showing hero image, stats (prep time, cook time, calories, servings slider), ingredients list with available vs missing items, equipment, step-by-step instructions, tips, and substitutions.
- [ ] **TASK-010**: Shopping List UI
  - **Req IDs**: `FR-014`, `FR-015`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Category-grouped list items with checkboxes, quantity, unit, add item sheet, edit item dialog, "Clear Purchased" button.
- [ ] **TASK-011**: Cooking Mode UI
  - **Req IDs**: `FR-017`, `FR-018`, `FR-019`
  - **Dependencies**: TASK-002
  - **Acceptance Criteria**: Focused single-step cooking view, step progress bar, step timer widget (start/pause/reset), ingredient checklist drawer, next/previous step navigation.
- [ ] **TASK-012**: Navigation & Router Setup (GoRouter)
  - **Req IDs**: `NFR-001`
  - **Dependencies**: TASK-003 through TASK-011
  - **Acceptance Criteria**: Clean bottom NavigationBar connecting Home, Pantry, Scan, AI Chat, Recipes, and Shopping List with full screen transition support.

---

## Phase 3 — BLoC Architecture & State Management
- [ ] **TASK-013**: Implement Core BLoC Foundation & State Classes
  - **Req IDs**: All
  - **Dependencies**: TASK-012
  - **Acceptance Criteria**: Setup `PantryBloc`, `ScanBloc`, `AiChatBloc`, `RecipeBloc`, `ShoppingListBloc`, `CookingBloc`, `SettingsCubit` with explicit `Initial`, `Loading`, `Success`, `Failure`, `Streaming`, `ToolExecuting` states.

---

## Phase 4 — Data Layer & Repositories
- [ ] **TASK-014**: Define Domain Models & Repository Contracts
  - **Req IDs**: All
  - **Dependencies**: TASK-013
  - **Acceptance Criteria**: `PantryItem`, `Ingredient`, `Recipe`, `ShoppingItem`, `UserProfile` models created with `freezed` or `equatable` and full `fromJson`/`toJson` serializing. Repository interfaces defined. Dependency injection (get_it) configured.

---

## Phase 5 — Firebase Foundation & Authentication
- [ ] **TASK-015**: Firebase Setup & Authentication Integration
  - **Req IDs**: `SEC-001`, `PRIV-002`
  - **Dependencies**: TASK-014
  - **Acceptance Criteria**: Firebase Core, Auth (Anonymous + Email/Password), Firestore initialized. Auth state stream connected to app router.

---

## Phase 6 — Pantry Persistence (Cloud Firestore)
- [ ] **TASK-016**: Firestore Pantry Repository & Real-time Sync
  - **Req IDs**: `FR-001`, `FR-002`, `FR-003`, `FR-004`, `OFF-001`
  - **Dependencies**: TASK-015
  - **Acceptance Criteria**: Real-time Firestore synchronization for pantry CRUD operations, expiration calculation, and "Use Soon" filtering under `users/{userId}/pantry`.

---

## Phase 7 — Gemini Multimodal Vision Integration
- [ ] **TASK-017**: Gemini Vision Service & Ingredient Detection
  - **Req IDs**: `FR-005`, `FR-006`, `FR-007`, `NFR-003`, `AI-001`
  - **Dependencies**: TASK-016
  - **Acceptance Criteria**: Image compression pipeline (< 1.5MB). Gemini multimodal vision request returning structured JSON list of detected ingredients. Review flow committing validated items to Firestore.

---

## Phase 8 — Gemini Streaming AI Chat
- [ ] **TASK-018**: Streaming Chat Service with Pantry Context
  - **Req IDs**: `FR-008`, `FR-009`, `FR-110`, `AI-001`
  - **Dependencies**: TASK-017
  - **Acceptance Criteria**: `google_generative_ai` streaming integration. Active user pantry items automatically injected into prompt context. Cancellation, retry, and conversation history supported.

---

## Phase 9 — Structured Recipe Generation
- [ ] **TASK-019**: JSON Schema Structured Recipe Generation
  - **Req IDs**: `FR-010`, `FR-011`, `FR-012`, `FR-013`
  - **Dependencies**: TASK-018
  - **Acceptance Criteria**: Gemini JSON Schema enforcing strongly typed `Recipe` output. Automatic matching of ingredients to user's pantry to highlight available vs missing items. Recipe saving to Firestore under `users/{userId}/favorites`.

---

## Phase 10 — Function Calling & Automated Shopping List
- [ ] **TASK-020**: Gemini Function Calling & Tool Execution Handler
  - **Req IDs**: `FR-014`, `FR-015`, `FR-016`, `SEC-001`
  - **Dependencies**: TASK-019
  - **Acceptance Criteria**: Function declarations for `addShoppingListItems`, `removeShoppingListItem`, `updateShoppingListItem`, `getShoppingList`, `markShoppingItemPurchased`. Client-side tool call execution against Firestore with response roundtrip to Gemini.

---

## Phase 11 — Shopping List Firestore Persistence
- [ ] **TASK-021**: Firestore Shopping List Sync & Recipe Import
  - **Req IDs**: `FR-015`, `FR-016`, `OFF-001`
  - **Dependencies**: TASK-020
  - **Acceptance Criteria**: Real-time Firestore sync for `users/{userId}/shoppingList`. "Add Missing Ingredients" button in Recipe Details successfully parses missing items and pushes them into shopping list.

---

## Phase 12 — Cooking Experience & Timer
- [ ] **TASK-022**: Cooking Mode Logic, Timers, and Screen Stay-Awake
  - **Req IDs**: `FR-017`, `FR-018`, `FR-019`
  - **Dependencies**: TASK-021
  - **Acceptance Criteria**: `CookingBloc` managing current step index, active countdown timer with background notifications, and wakelock integration (`wakelock_plus`).

---

## Phase 13 — Production Hardening & Resilience
- [ ] **TASK-023**: Global Error Handling, Offline UI, and Rate Limit Fallbacks
  - **Req IDs**: `OFF-002`, `AI-001`, `AI-002`
  - **Dependencies**: TASK-022
  - **Acceptance Criteria**: User-friendly error banners, retry mechanisms for AI timeouts, food safety disclaimers displayed on recipes and chat.

---

## Phase 14 — Security Rules & App Check
- [ ] **TASK-024**: Firestore Security Rules & Firebase App Check
  - **Req IDs**: `SEC-001`, `SEC-002`, `SEC-003`
  - **Dependencies**: TASK-023
  - **Acceptance Criteria**: `firestore.rules` preventing cross-user data access. App Check debug and production providers configured.

---

## Phase 15 — Automated Testing Suite
- [ ] **TASK-025**: Unit, BLoC, Widget, and Security Rule Tests
  - **Req IDs**: All
  - **Dependencies**: TASK-024
  - **Acceptance Criteria**: Comprehensive unit tests for repositories, BLoC tests using `bloc_test`, widget tests for primary screens, and `@firebase/rules-unit-testing` for Firestore rules.

---

## Phase 16 — CI/CD Pipeline Configuration
- [ ] **TASK-026**: Setup GitHub Actions Workflows
  - **Req IDs**: `SEC-003`
  - **Dependencies**: TASK-025
  - **Acceptance Criteria**: `.github/workflows/ci.yml`, `android.yml`, `release.yml` for automated formatting, linting, testing, and Android APK/AAB build checks.

---

## Phase 17 — Technical Documentation & Codelab
- [ ] **TASK-027**: Codelab Learning Guide & Comprehensive README
  - **Req IDs**: All
  - **Dependencies**: TASK-026
  - **Acceptance Criteria**: Google Codelab-style step-by-step tutorial explaining architectural choices, Gemini integration patterns, state management, and setup guide in `README.md`.
