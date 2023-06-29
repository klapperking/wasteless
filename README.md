# Wasteless
**Note: This project is under development**

*Wasteless* is a web-application to tackle the problem of foodwaste, by making it easy to track what you have at home - matching your expiring food to recipes and generating shopping lists.

With *Wasteless* you won't have to waste food anymore wihtout the nightmare of remembering what you have at home.

---

## Overview

Rails application to keep track of what you have in your 'inventory' (food you have at home) and its expiration date. At the moment this uses an estimate for a given (for now arbitrary) food-category, e.g. a tomato gets its expiration date from the vegetable category (7 days).

Select ingredients to use and get an overview of recipes matching your selection.

Generate a shopping list from a recipe (matching your existing ingredients and removing from inventory & adding missing ingredients to shopping list).

Add bought ingredients directly from shopping list or adding manually (using either dropdown-search or barcode scan)

---
## Next steps
  0. Refactor code-base
  1. Create new db of known ingredients using openfoodfacts
  2. Adding Ingredients (e.g. using Barcode) match with new database
  3. "Smarter" Expiration-Dates (better estimates or user-input) - Ideally with image recognition
  4. Build a recipe table (probably webscraping)
  5. Generate recipe based on closest-to-expiry ingredients using recipes from db (or GPT generation)
