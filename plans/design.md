# CookLens — Material 3 Design System & UI/UX Specification

## 1. Design Philosophy
CookLens follows **Material 3 (Material You)** principles. The visual experience is clean, modern, food-focused, accessible, and intuitive.

Key visual attributes:
- **Warm & Appetizing Color Palette**: Terracotta red/orange accents, fresh avocado greens, warm neutral creams, and deep slate dark tones.
- **Elevation & Depth**: Tonal elevation cards with rounded corners (16px to 24px radius).
- **Clear Button Hierarchy**: Filled for primary actions, Tonal/Outlined for secondary actions, Text for tertiary.
- **Accessibility**: AAA contrast ratios, minimum 48x48dp touch targets, clean typographic scale.

---

## 2. Design Tokens

### Color Palette (M3 Seed: `#E05A47` - Warm Culinary Terracotta)

#### Light Theme:
- **Primary**: `#C0392B` (Warm Terracotta Red)
- **OnPrimary**: `#FFFFFF`
- **PrimaryContainer**: `#FADBD8`
- **Secondary**: `#27AE60` (Fresh Herb Green)
- **OnSecondary**: `#FFFFFF`
- **SecondaryContainer**: `#D4EFDF`
- **Surface**: `#FDFEFE`
- **SurfaceVariant**: `#F2F4F4`
- **OnSurface**: `#1C2833`
- **Outline**: `#BDC3C7`
- **Error**: `#E74C3C`

#### Dark Theme:
- **Primary**: `#EC7063`
- **OnPrimary**: `#4A150E`
- **PrimaryContainer**: `#7B241C`
- **Secondary**: `#52BE80`
- **OnSecondary**: `#0E3A1F`
- **SecondaryContainer**: `#1E8449`
- **Surface**: `#121212`
- **SurfaceVariant**: `#1E1E1E`
- **OnSurface**: `#ECF0F1`
- **Outline**: `#424949`
- **Error**: `#F1948A`

### Typography (`AppTypography`)
- **Display Large**: 32sp, Bold, Line height 1.2
- **Headline Medium**: 24sp, SemiBold, Line height 1.3
- **Title Large**: 20sp, Medium, Line height 1.4
- **Body Large**: 16sp, Regular, Line height 1.5
- **Body Medium**: 14sp, Regular, Line height 1.5
- **Label Large**: 14sp, SemiBold, Line height 1.4

### Spacing (`AppSpacing`)
- `xs`: 4.0 dp
- `sm`: 8.0 dp
- `md`: 16.0 dp
- `lg`: 24.0 dp
- `xl`: 32.0 dp
- `xxl`: 48.0 dp

### Radii (`AppRadius`)
- `small`: 8.0 dp (Chips, text fields)
- `medium`: 16.0 dp (Cards, bottom sheets, dialogs)
- `large`: 24.0 dp (Pantry item cards, recipe hero containers)
- `circular`: 999.0 dp (Pills, FABs)

---

## 3. Screen Specifications (Raw UI Phase)

### 3.1 Onboarding
- Page 1: Welcome illustration, tagline ("Cook smarter, waste less").
- Page 2: How CookLens Works (Snap -> Review -> Cook).
- Page 3: AI & Privacy explanation (Photos analyzed securely, never stored publicly).
- Page 4: Dietary & Allergen Selector (Interactive checkable chips).
- Page 5: Completion checkmark & "Get Started" filled button.

### 3.2 Home Screen
- Top Bar: Avatar greeting ("Hello, Chef Alex! 👋"), notifications icon.
- Pantry Summary Card: Total items (e.g. 28 items), breakdown (Fridge: 14, Freezer: 6, Pantry: 8).
- "Use Soon" Section: Horizontally scrollable list of expiring ingredients within 3 days (highlighted with orange/red subtle badges).
- Suggested Recipes Carousel: M3 cards showing recipe photo placeholder, title, cook time, and missing item tag.
- Quick Actions Bar: Grid buttons for `Scan Pantry` (Camera FAB/Primary), `Add Ingredient`, `Ask AI`, `Shopping List`.

### 3.3 Pantry Screen
- Segmented Tab Bar: `Fridge` | `Freezer` | `Pantry` | `All`.
- Search & Filter Bar: Text input + filter bottom sheet trigger (by category, expiration status, sorting order).
- Ingredient Cards: Image/Icon, name, quantity + unit pill, expiration status ("Expiring in 2 days"), options menu (Edit, Delete).

### 3.4 Scan Pantry Screen
- Viewport: Camera preview placeholder with viewable frame guidelines.
- Action Controls: Gallery selection button, Shutter capture button, Multi-image preview carousel.
- Secondary State: "Analyzing image with Gemini AI..." overlay with animated progress indicator.

### 3.5 Ingredient Review Screen
- Header: "AI Detected 6 Ingredients — Review & Confirm".
- Editable List: Cards with text fields for Name, Quantity, Unit dropdown, Category dropdown, Expiry date picker, Location dropdown.
- Checkbox on each item to include/exclude.
- Action Buttons: `Add Selected to Pantry` (Primary Filled), `Scan Again` (Outlined), `Cancel`.

### 3.6 AI Chat Screen
- Streaming Chat View: Message history list with smooth autoscroll.
- User Bubble: Primary color aligned right.
- AI Bubble: Neutral variant container aligned left with streaming typing indicator.
- Prompt Suggestion Chips: "What can I make in 15 mins?", "High protein dinner ideas", "How to replace eggs in baking?".
- Controls: Input box, send icon, "Stop Generating" button, "Retry" button.

### 3.7 Recipe Results & Details
- Results Grid: Cards featuring prep time, difficulty tag, matching ingredient count (e.g. "8/9 ingredients in pantry").
- Details Screen:
  - Hero image with favorite bookmark FAB.
  - Quick Info Bar: Time, Servings, Calories, Skill level.
  - Ingredients List: Checkmarks for available items (green), warning icons for missing items (orange).
  - Equipment Needed chips.
  - Step-by-Step cooking instructions.
  - Action Bar: `Start Cooking Mode` (Filled), `Add Missing Items to Shopping List` (Outlined).

### 3.8 Shopping List Screen
- Items grouped by category (Produce, Dairy, Pantry, Meat).
- Interactive Checkboxes: Checking item moves it to "Purchased" expandable list at bottom.
- Action Bar: `Add Item`, `Clear Purchased Items`.

### 3.9 Focused Cooking Mode Screen
- Stepper View: Top progress bar ("Step 3 of 7").
- Main Card: Large readable instruction text.
- Step Timer: Embedded circular or linear timer widget (`05:00` with Start/Pause/Reset).
- Navigation Footer: `Previous Step` (Outlined), `Next Step` (Filled).
- Ingredient Drawer: Swipeable bottom sheet listing ingredients required specifically for the current step.
