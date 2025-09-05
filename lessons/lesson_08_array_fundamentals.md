# Lesson 8: Array Fundamentals - Organizing Multiple Values

## Learning Objectives
By the end of this lesson, you will:
- Understand what arrays are and why they're essential for game development
- Create and initialize arrays with different data types
- Access individual elements using index numbers
- Understand array size and bounds
- Use basic array methods (append, size, clear)
- Recognize when arrays are the right solution for organizing data

## Getting Started

### The Problem Arrays Solve
**Look at this messy code**:
```gdscript
var enemy_name_1 = "Goblin"
var enemy_name_2 = "Orc" 
var enemy_name_3 = "Skeleton"
var enemy_name_4 = "Dragon"
var enemy_name_5 = "Spider"

# Want to print all enemy names? Tedious!
print(enemy_name_1)
print(enemy_name_2)  
print(enemy_name_3)
print(enemy_name_4)
print(enemy_name_5)
```

**Problems**:
- ❌ **Lots of variables** to manage
- ❌ **Hard to loop through** all values
- ❌ **Difficult to add/remove** enemies
- ❌ **Repetitive code** for similar operations

### The Array Solution
**Same data with arrays**:
```gdscript
var enemy_names = ["Goblin", "Orc", "Skeleton", "Dragon", "Spider"]

# Print all enemy names - simple loop!
for enemy_name in enemy_names:
    print(enemy_name)
```

**Benefits**:
- ✅ **One variable** holds multiple values
- ✅ **Easy to loop** through all items
- ✅ **Dynamic size** - add/remove easily
- ✅ **Clean, readable** code

## Part 1: Creating Your First Arrays

### Step 1: Create Array Practice Script
1. **Create** a new script: `scripts/array_practice.gd`
2. **Set it up** as a basic scene script:

```gdscript
extends Node
class_name ArrayPractice

func _ready():
    print("=== ARRAY FUNDAMENTALS PRACTICE ===")
    practice_basic_arrays()
    practice_array_access()
    practice_array_methods()
    print("===================================")

func practice_basic_arrays():
    print("\n--- Creating Basic Arrays ---")
    # We'll add code here step by step
    
func practice_array_access():
    print("\n--- Accessing Array Elements ---")
    # We'll add code here step by step
    
func practice_array_methods():
    print("\n--- Array Methods ---")
    # We'll add code here step by step
```

### Step 2: Create Different Types of Arrays
**Add this code** to your `practice_basic_arrays()` function:

```gdscript
func practice_basic_arrays():
    print("\n--- Creating Basic Arrays ---")
    
    # Array of strings (text values)
    var colors: Array[String] = ["Red", "Blue", "Green", "Yellow"]
    print("Colors array: " + str(colors))
    
    # Array of integers (whole numbers)
    var player_levels: Array[int] = [1, 5, 12, 23, 45]
    print("Player levels: " + str(player_levels))
    
    # Array of floats (decimal numbers)
    var damage_multipliers: Array[float] = [1.0, 1.5, 2.0, 2.5]
    print("Damage multipliers: " + str(damage_multipliers))
    
    # Empty array (we'll add items later)
    var empty_inventory: Array[String] = []
    print("Empty inventory: " + str(empty_inventory))
    
    # Array without explicit typing (Godot figures out the type)
    var mixed_example = ["Sword", "Shield", "Potion"]
    print("Mixed example: " + str(mixed_example))
```

**Understanding Array Syntax**:
- **`Array[String]`**: Array that only holds strings
- **`["item1", "item2"]`**: Array literal with initial values
- **`[]`**: Empty array

### Step 3: Test Your Arrays
1. **Create** a simple scene with a Node as root
2. **Attach** your `array_practice.gd` script
3. **Run the scene** and check the console output

**Expected Output**:
```
=== ARRAY FUNDAMENTALS PRACTICE ===

--- Creating Basic Arrays ---
Colors array: ["Red", "Blue", "Green", "Yellow"]
Player levels: [1, 5, 12, 23, 45]
...
```

## Part 2: Accessing Array Elements

### Step 4: Understanding Array Indexing
**Add this explanation** in your console, then add the code to `practice_array_access()`:

```gdscript
func practice_array_access():
    print("\n--- Accessing Array Elements ---")
    
    # Create an array for testing
    var weapons: Array[String] = ["Sword", "Bow", "Staff", "Dagger"]
    print("Weapons array: " + str(weapons))
    print("Array has " + str(weapons.size()) + " items")
    
    # Arrays use INDEX NUMBERS starting from 0
    print("\nAccessing individual weapons:")
    print("Index 0 (first item): " + weapons[0])    # "Sword"
    print("Index 1 (second item): " + weapons[1])   # "Bow"
    print("Index 2 (third item): " + weapons[2])    # "Staff"
    print("Index 3 (fourth item): " + weapons[3])   # "Dagger"
    
    # Common mistake - arrays start at 0, not 1!
    print("\nIMPORTANT: Arrays start counting at 0!")
    print("First item is index 0, not index 1")
    
    # Last item shortcut
    var last_index: int = weapons.size() - 1
    print("Last item (index " + str(last_index) + "): " + weapons[last_index])
```

### Step 5: Safe Array Access
**Add error prevention** to your array access practice:

```gdscript
# Add this to practice_array_access() function:

    # Safe array access - prevent crashes
    print("\n--- Safe Array Access ---")
    
    var test_array: Array[String] = ["Apple", "Banana"]
    print("Test array: " + str(test_array))
    print("Array size: " + str(test_array.size()))
    
    # This would crash: test_array[5] - index doesn't exist!
    # Always check size first
    var requested_index: int = 5
    if requested_index < test_array.size():
        print("Item at index " + str(requested_index) + ": " + test_array[requested_index])
    else:
        print("Error: Index " + str(requested_index) + " doesn't exist!")
        print("Valid indexes are 0 to " + str(test_array.size() - 1))
```

**Key Concept**: Array indexes start at 0 and go up to `size() - 1`

## Part 3: Basic Array Methods

### Step 6: Adding and Removing Items
**Add this code** to your `practice_array_methods()` function:

```gdscript
func practice_array_methods():
    print("\n--- Array Methods ---")
    
    # Start with an empty inventory
    var inventory: Array[String] = []
    print("Starting inventory: " + str(inventory))
    print("Size: " + str(inventory.size()))
    
    # Add items to the end of array
    print("\n--- Adding Items ---")
    inventory.append("Health Potion")
    print("Added Health Potion: " + str(inventory))
    
    inventory.append("Magic Sword")
    print("Added Magic Sword: " + str(inventory))
    
    inventory.append("Gold Coin")
    print("Added Gold Coin: " + str(inventory))
    print("Final size: " + str(inventory.size()))
    
    # Remove the last item
    print("\n--- Removing Items ---")
    if inventory.size() > 0:
        var removed_item: String = inventory.pop_back()
        print("Removed last item: " + removed_item)
        print("Inventory now: " + str(inventory))
    
    # Clear all items
    print("\n--- Clearing Array ---")
    inventory.clear()
    print("Cleared inventory: " + str(inventory))
    print("Size after clear: " + str(inventory.size()))
```

### Step 7: Looping Through Arrays
**Add array iteration practice**:

```gdscript
# Add this to practice_array_methods() function:

    # Create a new array for loop practice
    print("\n--- Looping Through Arrays ---")
    var spell_names: Array[String] = ["Fireball", "Ice Spike", "Lightning", "Heal"]
    
    # Method 1: For-each loop (easiest)
    print("Method 1 - For-each loop:")
    for spell in spell_names:
        print("  Spell: " + spell)
    
    # Method 2: Index-based loop (when you need the index number)
    print("Method 2 - Index-based loop:")
    for i in range(spell_names.size()):
        print("  Spell " + str(i + 1) + ": " + spell_names[i])
    
    # Method 3: While loop (for complex conditions)
    print("Method 3 - While loop:")
    var index: int = 0
    while index < spell_names.size():
        print("  Index " + str(index) + " = " + spell_names[index])
        index += 1
```

## Part 4: Practical Array Examples

### Step 8: Game Development Use Cases
**Add a new function** to show real game applications:

```gdscript
func _ready():
    print("=== ARRAY FUNDAMENTALS PRACTICE ===")
    practice_basic_arrays()
    practice_array_access()
    practice_array_methods()
    game_development_examples()  # Add this line
    print("===================================")

func game_development_examples():
    print("\n--- Game Development Examples ---")
    
    # Player stats that could be arrays
    var player_stats: Array[int] = [100, 50, 25, 15]  # health, mana, strength, defense
    print("Player stats [HP, MP, STR, DEF]: " + str(player_stats))
    
    # Different enemy types
    var enemy_types: Array[String] = ["Goblin", "Orc", "Troll", "Dragon"]
    print("Enemy types: " + str(enemy_types))
    
    # Loot drop chances (percentages)
    var drop_chances: Array[float] = [0.8, 0.3, 0.1, 0.05]  # common, uncommon, rare, legendary
    print("Drop chances: " + str(drop_chances))
    
    # Quest completion status
    var quest_completed: Array[bool] = [true, false, false, true]
    print("Quest completion: " + str(quest_completed))
    
    print("\nArrays are perfect for:")
    print("  - Lists of similar items")
    print("  - Game content that changes")
    print("  - Data that needs looping")
    print("  - Collections that grow/shrink")
```

## Part 5: Array Best Practices

### Step 9: Type Safety and Error Prevention
**Add a function** demonstrating good array practices:

```gdscript
func demonstrate_best_practices():
    print("\n--- Array Best Practices ---")
    
    # 1. Use explicit typing
    var good_array: Array[String] = ["Apple", "Banana"]  # ✅ Clear type
    var unclear_array = ["Apple", "Banana"]              # ❌ Type unclear
    
    # 2. Check size before accessing
    var items: Array[String] = ["Sword", "Shield"]
    
    # ✅ Safe access
    if items.size() > 2:
        print("Third item: " + items[2])
    else:
        print("No third item exists")
    
    # 3. Use descriptive names
    var player_inventory: Array[String] = []  # ✅ Clear purpose
    var stuff: Array[String] = []             # ❌ Unclear purpose
    
    # 4. Initialize with expected type
    var enemy_names: Array[String] = []       # ✅ Clear what it will hold
    var enemies = []                          # ❌ Could hold anything
    
    print("Always use clear types and check bounds!")
```

**Add the call** to your `_ready()` function:

```gdscript
func _ready():
    print("=== ARRAY FUNDAMENTALS PRACTICE ===")
    practice_basic_arrays()
    practice_array_access()
    practice_array_methods()
    game_development_examples()
    demonstrate_best_practices()  # Add this line
    print("===================================")
```

## Part 6: Testing Your Understanding

### Step 10: Array Challenge Exercises
**Create these challenge functions** and call them from `_ready()`:

```gdscript
func challenge_exercises():
    print("\n--- Challenge Exercises ---")
    
    # Challenge 1: Create an array of your favorite games
    var favorite_games: Array[String] = [] # TODO: Add 3-5 game names
    
    # Challenge 2: Create an array of numbers 1-10
    var numbers: Array[int] = [] # TODO: Add numbers 1 through 10
    
    # Challenge 3: Print every other item in an array
    var test_items: Array[String] = ["A", "B", "C", "D", "E", "F"]
    print("Every other item:")
    # TODO: Print items at indexes 0, 2, 4 (A, C, E)
    
    # Challenge 4: Find the largest number in an array
    var scores: Array[int] = [85, 92, 78, 96, 88]
    # TODO: Find and print the highest score
    
    print("Complete the challenges above!")
```

### Answer Key (Don't look until you try!)
<details>
<summary>Challenge Solutions</summary>

```gdscript
func challenge_exercises():
    print("\n--- Challenge Exercises ---")
    
    # Challenge 1: Create an array of your favorite games
    var favorite_games: Array[String] = ["Zelda", "Mario", "Pokemon", "Minecraft"]
    print("Favorite games: " + str(favorite_games))
    
    # Challenge 2: Create an array of numbers 1-10
    var numbers: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print("Numbers 1-10: " + str(numbers))
    
    # Challenge 3: Print every other item in an array
    var test_items: Array[String] = ["A", "B", "C", "D", "E", "F"]
    print("Every other item:")
    for i in range(0, test_items.size(), 2):  # Start at 0, step by 2
        print("  " + test_items[i])
    
    # Challenge 4: Find the largest number in an array
    var scores: Array[int] = [85, 92, 78, 96, 88]
    var highest_score: int = scores[0]  # Start with first score
    for score in scores:
        if score > highest_score:
            highest_score = score
    print("Highest score: " + str(highest_score))
```

</details>

## Deliverables
By the end of this lesson, you should have:
- [ ] Array practice script that creates different types of arrays
- [ ] Understanding of array indexing (starting from 0)
- [ ] Ability to safely access array elements with bounds checking
- [ ] Knowledge of basic array methods (append, pop_back, clear, size)
- [ ] Experience with different ways to loop through arrays
- [ ] Recognition of when arrays are the right tool for organizing data
- [ ] Completed challenge exercises demonstrating array mastery

## Next Lesson Preview - Arrays for Game Data!
**In Lesson 9**, we'll apply your array knowledge to solve a real game problem:
- **NPC Dialogue System**: Multiple dialogue lines stored in arrays
- **Dynamic Content**: NPCs that say different things each time
- **Practical Application**: Using arrays to make games more interesting
- **Foundation Building**: Preparing for inventory systems and more!

## Common Array Mistakes to Avoid

**Index Out of Bounds**:
```gdscript
var items = ["A", "B", "C"]
print(items[5])  # ❌ CRASH! Index 5 doesn't exist
```

**Wrong Index Counting**:
```gdscript
var items = ["A", "B", "C"]
print("First item: " + items[1])  # ❌ This prints "B", not "A"!
print("First item: " + items[0])  # ✅ Correct - arrays start at 0
```

**Type Mixing**:
```gdscript
var numbers: Array[int] = [1, 2, 3]
numbers.append("four")  # ❌ ERROR! Can't add string to int array
```

## Troubleshooting

**"Array index out of range" error**
- Check that your index is less than `array.size()`
- Remember arrays start at index 0, not 1
- Use `if index < array.size():` before accessing

**"Type mismatch" error**
- Make sure you're adding the right type to typed arrays
- Use `Array[String]` for text, `Array[int]` for whole numbers
- Check that your array declaration matches what you're storing

**"Array is empty" issues**
- Check `array.size() > 0` before accessing elements
- Initialize arrays with starting values if needed
- Use `append()` to add items to empty arrays

## Reflection Questions
Write down or discuss:

1. **Organization**: How do arrays help organize related data compared to separate variables?
2. **Loops**: Why are arrays so much better when you need to do the same operation on multiple items?
3. **Game Design**: What kinds of game data would work well in arrays?
4. **Index Understanding**: Why do arrays start counting from 0 instead of 1?
5. **Type Safety**: How does `Array[String]` help prevent bugs compared to untyped arrays?

**You now understand the fundamental building blocks for managing collections of data!** 🎯

---

*This foundation will be essential for inventory systems, dialogue management, enemy spawning, and almost every other game system you'll build.*
