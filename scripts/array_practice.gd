extends Node
class_name ArrayPractice

# Array Fundamentals Practice Script
# This script demonstrates basic array operations for Lesson 8

func _ready():
    print("=== ARRAY FUNDAMENTALS PRACTICE ===")
    practice_basic_arrays()
    practice_array_access()
    practice_array_methods()
    game_development_examples()
    demonstrate_best_practices()
    challenge_exercises()
    print("===================================")

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
    
    print("Challenges completed!")
