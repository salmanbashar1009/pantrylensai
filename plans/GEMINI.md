# CookLens — Gemini AI Integration Specification

## 1. Architecture Overview
CookLens integrates Google's Gemini models using `package:google_generative_ai` (or raw REST endpoints via client wrapper when needed) for four core AI capabilities:

```text
                     +---------------------------------------+
                     |           Flutter App Layer           |
                     +---------------------------------------+
                                         |
     +-------------------+---------------+---------------+-------------------+
     |                   |                               |                   |
     v                   v                               v                   v
+------------+  +-------------------+          +-------------------+  +-------------------+
| Multimodal |  |   Streaming Chat  |          | Structured Recipe |  | Function Calling  |
| Vision API |  |   Assistant       |          | Generation        |  | Shopping List     |
+------------+  +-------------------+          +-------------------+  +-------------------+
     |                   |                               |                   |
     +-------------------+---------------+---------------+-------------------+
                                         |
                                         v
                     +---------------------------------------+
                     |          Gemini 2.5/1.5 Flash         |
                     +---------------------------------------+
```

---

## 2. Model Selection Strategy
- **Primary Model**: `gemini-2.5-flash` / `gemini-1.5-flash`
  - Used for fast multimodal ingredient scanning, streaming AI chat, structured JSON recipe generation, and function calling.
- **Fallback / Complex Reasoning Model**: `gemini-2.5-pro` / `gemini-1.5-pro`
  - Used if complex recipe requests fail schema validation or require deep dietary substitution reasoning.

---

## 3. Multimodal Vision Pipeline (Ingredient Scanner)

### Image Preprocessing
- Camera photos must be resized to a maximum dimension of 1024px and compressed to JPEG with 80% quality (target file size < 1.5 MB).
- Input images are encoded as `DataPart('image/jpeg', bytes)`.

### Prompt Design
```text
System Instruction:
You are an expert culinary vision AI. Analyze the provided photo of a fridge, pantry, or ingredients. Identify all visible food items with reasonable estimates of quantity, unit, and location.

JSON Schema Output Requirement:
Respond strictly with valid JSON matching the following schema:
{
  "ingredients": [
    {
      "name": "String",
      "confidence": 0.0 - 1.0,
      "category": "produce | dairy | meat | pantry | bakery | frozen | beverage | condiment | spice | other",
      "estimatedQuantity": number,
      "estimatedUnit": "pieces | grams | kg | lbs | oz | ml | liters | cup | tbsp | tsp | container | bag | bottle | pack",
      "location": "fridge | freezer | pantry"
    }
  ]
}
```

---

## 4. Streaming AI Chat Assistant

### System Prompt & Context Injection
```text
System Prompt:
You are CookLens, a helpful, enthusiastic, and safety-conscious AI chef.
You assist users in deciding what to cook based on their current pantry inventory and dietary preferences.

User Profile:
- Dietary Restrictions: [e.g., Gluten-Free, Vegetarian]
- Allergies: [e.g., Peanuts, Shellfish]
- Skill Level: Intermediate
- Available Equipment: Oven, Microwave, Air Fryer, Blender

Current Pantry Inventory:
[
  {"name": "Eggs", "quantity": 6, "unit": "pieces", "location": "fridge"},
  {"name": "Chicken Breast", "quantity": 500, "unit": "grams", "location": "fridge"},
  {"name": "Spinach", "quantity": 1, "unit": "bag", "location": "fridge", "expiringSoon": true}
]

Guidelines:
- Prioritize ingredients marked as expiring soon ("Use Soon").
- Always highlight food safety when dealing with raw meats or perishables.
- Stream responses progressively.
```

---

## 5. Structured Recipe Generation Schema

Gemini Structured Output is enforced via `ResponseSchema` or JSON mode.

### Schema Definition:
```json
{
  "title": "Creamy Garlic Spinach Chicken",
  "description": "A quick, wholesome 25-minute pan-seared chicken breast dinner served with fresh spinach and garlic.",
  "servings": 2,
  "prepTimeMinutes": 10,
  "cookTimeMinutes": 15,
  "difficulty": "easy",
  "cuisine": "American",
  "dietaryTags": ["Gluten-Free", "High-Protein", "Keto-Friendly"],
  "nutrition": {
    "calories": 420,
    "proteinGrams": 45,
    "carbsGrams": 6,
    "fatGrams": 24
  },
  "ingredients": [
    {
      "name": "Chicken Breast",
      "amount": 500,
      "unit": "grams",
      "isAvailable": true
    },
    {
      "name": "Heavy Cream",
      "amount": 100,
      "unit": "ml",
      "isAvailable": false
    }
  ],
  "equipment": ["Frying Pan", "Chef Knife", "Cutting Board"],
  "steps": [
    {
      "stepNumber": 1,
      "instruction": "Season chicken breast with salt and pepper on both sides.",
      "timerSeconds": 0
    },
    {
      "stepNumber": 2,
      "instruction": "Sear chicken in pan over medium heat for 6 minutes per side.",
      "timerSeconds": 360
    }
  ],
  "substitutions": [
    {
      "original": "Heavy Cream",
      "replacement": "Greek Yogurt or Coconut Milk"
    }
  ],
  "tips": [
    "Ensure chicken internal temperature reaches 165°F (74°C)."
  ]
}
```

---

## 6. Gemini Function Calling (Shopping List Management)

The AI assistant can call tools to modify or retrieve the user's shopping list.

### Declared Functions:
1. `addShoppingListItems(items: Array<{name: string, quantity: number, unit: string, category: string}>)`
2. `removeShoppingListItem(itemId: string)`
3. `updateShoppingListItem(itemId: string, quantity: number, unit: string)`
4. `getShoppingList()`
5. `markShoppingItemPurchased(itemId: string, isPurchased: boolean)`

### Execution Flow:
```text
User Message: "Add 2 liters of milk and 1 dozen eggs to my shopping list."
  |
  v
Gemini evaluates message -> returns ToolCall Request:
  Function: addShoppingListItems
  Args: [
    {"name": "Milk", "quantity": 2, "unit": "liters", "category": "dairy"},
    {"name": "Eggs", "quantity": 12, "unit": "pieces", "category": "dairy"}
  ]
  |
  v
Flutter Function Handler validates arguments & executes Firestore write operation
  |
  v
Flutter returns ToolResponse:
  {"status": "success", "addedCount": 2}
  |
  v
Gemini receives ToolResponse -> Generates conversational reply:
  "I've added 2 liters of milk and 12 eggs to your shopping list!"
```

---

## 7. Food Safety & AI Safety Safeguards
- **Allergen Verification**: Strict prompt enforcement to flag potential allergen cross-contamination based on user settings.
- **Raw Meat & Temperature Disclaimer**: Any recipe containing poultry, pork, ground meat, or seafood automatically appends safe internal temperature guidelines.
- **Nutritional Estimation Disclaimer**: "Nutritional values are estimated by AI and should not be used as medical advice."
