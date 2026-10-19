# CookLens — Product Requirements Document (PRD)

## 1. Product Overview
CookLens is a production-quality Flutter mobile application that serves as an AI-powered pantry manager, recipe generator, and conversational cooking assistant. It empowers users to reduce food waste, optimize meal preparation, generate personalized recipes based on available ingredients, and manage shopping lists seamlessly through Gemini AI vision, streaming chat, structured output, and function calling.

---

## 2. Product Goals
- **Smart Pantry Inventory**: Enable fast and accurate pantry logging using Gemini Multimodal Vision.
- **Waste Reduction**: Highlight ingredients near expiration and prioritize them in recipe generation.
- **Personalized Culinary Guidance**: Generate structured, step-by-step recipes tailored to dietary preferences, available equipment, and skill level.
- **Conversational AI Assistant**: Provide streaming chat with real-time culinary advice, substitutions, and automated shopping list management via function calling.
- **Guided Cooking**: Offer an accessible, focus mode step-by-step interactive cooking experience.

---

## 3. User Personas
1. **Busy Professional (Alex)**: Wants fast recipe ideas using ingredients already in the fridge without browsing dozens of ad-heavy recipe blogs.
2. **Eco-Conscious Home Cook (Jordan)**: Focused on reducing food waste and keeping track of ingredient expiration dates.
3. **Diet-Restricted Gourmet (Sam)**: Needs safe, strict allergen filtering (e.g., gluten-free, nut-free) and intelligent ingredient substitutions.

---

## 4. Functional Requirements

### Pantry Management
- `FR-001`: User can view pantry items categorized by location (Fridge, Freezer, Pantry).
- `FR-002`: User can add, edit, delete, search, filter, and sort pantry items (by name, expiry, category).
- `FR-003`: Each pantry item must store name, quantity, unit, category, location, and expiration date.
- `FR-004`: Pantry dashboard must highlight "Use Soon" items expiring within 3 days.

### Vision & Scanning Flow
- `FR-005`: User can capture images via camera or select photos from gallery.
- `FR-006`: Gemini Multimodal Vision identifies probable ingredients with estimated quantities and categories.
- `FR-007`: App must provide an **Ingredient Review** screen allowing full editing of detected items before committing to Firestore. AI results must never be silently auto-saved.

### AI Chat Assistant
- `FR-008`: User can interact conversationally with a cooking assistant with streaming text responses.
- `FR-009`: Chat assistant receives context from user's active pantry inventory and dietary preferences.
- `FR-110`: User can stop response streaming, retry failed messages, and select suggested prompt chips.

### Recipe Generation & Details
- `FR-010`: Generate strongly typed, structured recipes using Gemini JSON schema output.
- `FR-011`: Recipes display title, prep time, cook time, servings, difficulty, calories, dietary tags, available ingredients, missing ingredients, instructions, equipment, tips, and substitutions.
- `FR-012`: User can save favorite recipes and view recipe history.
- `FR-013`: User can adjust serving sizes dynamically recalculating ingredient amounts.

### Function Calling & Shopping List
- `FR-014`: Gemini function calling triggers actions: `addShoppingListItems`, `removeShoppingListItem`, `updateShoppingListItem`, `getShoppingList`, `markShoppingItemPurchased`.
- `FR-015`: User can view, add, edit, delete, mark purchased, and clear completed shopping list items.
- `FR-016`: User can trigger "Add Missing Ingredients to Shopping List" directly from recipe details.

### Interactive Cooking Mode
- `FR-017`: Focused full-screen interactive view showing one step at a time with progress bar.
- `FR-018`: Built-in step timer with start/pause/reset controls.
- `FR-019`: Screen stay-awake functionality while cooking mode is active.

### User Profile & Preferences
- `FR-020`: Support dietary restrictions (Vegetarian, Vegan, Gluten-Free, Keto, Paleo, Halal, Kosher).
- `FR-021`: Support allergen warnings (Peanuts, Tree Nuts, Dairy, Eggs, Soy, Wheat, Shellfish, Fish).
- `FR-022`: Support cooking skill level, spice preference, and available kitchen equipment settings.

---

## 5. Non-Functional Requirements

### Performance
- `NFR-001`: App cold start within 2.5 seconds on target devices.
- `NFR-002`: Smooth 60fps/120fps UI rendering with no frame drops during list scrolling or streaming response updates.
- `NFR-003`: Compressed camera images sent to Gemini capped at < 1.5 MB for rapid analysis.

### Offline & Resilience
- `OFF-001`: Offline viewing of cached pantry items and saved recipes using Firestore offline persistence.
- `OFF-002`: Graceful offline error handling with clear user notifications when network or AI services are unreachable.

### Security
- `SEC-001`: Server-side Cloud Firestore security rules strictly enforcing user isolation (`request.auth.uid == userId`).
- `SEC-002`: Firebase App Check integration to prevent unauthorized API access.
- `SEC-003`: No API keys, credentials, or secrets committed in client code or source control.

### Accessibility
- `ACC-001`: Material 3 compliant high contrast light and dark modes.
- `ACC-002`: Screen reader accessibility with semantic labels for camera controls, recipe cards, and buttons.
- `ACC-003`: Touch targets minimum 48x48 dp. Dynamic text scaling support up to 200%.

### Food & AI Safety
- `AI-001`: AI generated content must include explicit disclaimers for allergen safety, raw meat handling, and estimated nutritional values.
- `AI-002`: Multi-level prompt safeguards preventing generation of unsafe ingredient combinations or hazardous storage advice.

### Privacy
- `PRIV-001`: User photos are processed solely for ingredient identification and discarded after analysis.
- `PRIV-002`: Full user account and data deletion compliance (Pantry, Recipes, Shopping List, History).
