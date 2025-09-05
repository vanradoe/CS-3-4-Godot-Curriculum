# Lesson 12: Array Manipulation - Advanced Array Operations

## Learning Objectives
By the end of this lesson, you will:
- Add and remove items from arrays based on game events and player actions
- Search arrays efficiently to find specific items or objects
- Filter arrays to create subsets based on criteria
- Sort arrays by multiple criteria for organized data presentation
- Perform advanced array operations (merging, splitting, combining arrays)
- Optimize array operations for better game performance

## Getting Started

### The Need for Array Manipulation
**Your arrays aren't static!** In real games, arrays constantly change:
- **Inventory arrays**: Players find, use, buy, sell items
- **Enemy arrays**: Enemies spawn, die, change status
- **Quest arrays**: Quests are added, completed, updated
- **Skill arrays**: Players learn new abilities, level up existing ones

### What You'll Learn Today
**Simple changes** (what you can already do):
```gdscript
inventory.append("New Sword")  # Add item
inventory.pop_back()           # Remove last item
```

**Advanced manipulation** (what we're learning):
```gdscript
# Find and remove specific item
remove_item_by_name("Old Sword")

# Get all rare items
var rare_items = filter_by_rarity("Rare")

# Sort by multiple criteria (rarity, then alphabetical)
sort_inventory_advanced()

# Merge loot from defeated enemy
merge_arrays(player_inventory, enemy_loot)
```

## Part 1: Advanced Adding and Removing

### Step 1: Create Array Manipulation Practice Script
**Create** a new script: `scripts/array_manipulation.gd`

```gdscript
extends Node
class_name ArrayManipulation

# Sample game arrays for practice
var player_inventory: Array[String] = []
var enemy_squad: Array[String] = []
var completed_quests: Array[String] = []
var available_skills: Array[String] = []

# Item classification
var item_types = {
    "weapons": ["Iron Sword", "Steel Axe", "Magic Staff", "Silver Bow"],
    "potions": ["Health Potion", "Mana Potion", "Strength Potion"],
    "treasures": ["Gold Coin", "Ruby Gem", "Ancient Scroll"],
    "keys": ["Bronze Key", "Silver Key", "Master Key"]
}

func _ready():
    print("=== ARRAY MANIPULATION PRACTICE ===")
    
    setup_sample_data()
    practice_smart_adding()
    practice_smart_removing()
    practice_array_searching()
    practice_array_filtering()
    practice_array_sorting()
    practice_array_operations()
    
    print("===================================")

func setup_sample_data():
    print("Setting up sample arrays...")
    
    # Initialize inventory with mixed items
    player_inventory = ["Iron Sword", "Health Potion", "Gold Coin", "Bronze Key"]
    
    # Initialize enemy squad
    enemy_squad = ["Goblin Warrior", "Orc Shaman", "Troll Guard"]
    
    # Initialize quest progress
    completed_quests = ["Village Tutorial", "First Monster"]
    available_skills = ["Slash", "Block", "Heal"]
    
    print("Sample data ready!")
    print_all_arrays()
```

### Step 2: Smart Adding Functions
**Add these intelligent addition methods**:

```gdscript
func practice_smart_adding():
    print("\n--- Smart Adding Practice ---")
    
    # Add item only if not already present
    add_unique_item("Health Potion")  # Should fail - already exists
    add_unique_item("Steel Axe")      # Should succeed
    
    # Add item with quantity limits
    add_with_limit("Mana Potion", 5)  # Add if inventory has space
    add_with_limit("Strength Potion", 5)
    
    # Add item to specific category
    add_to_category("Silver Key", "keys")
    
    # Add multiple items at once
    add_multiple_items(["Ruby Gem", "Ancient Scroll", "Magic Staff"])

func add_unique_item(item_name: String) -> bool:
    if item_name in player_inventory:
        print("❌ " + item_name + " already in inventory!")
        return false
    else:
        player_inventory.append(item_name)
        print("✅ Added " + item_name + " to inventory")
        return true

func add_with_limit(item_name: String, max_inventory_size: int) -> bool:
    if player_inventory.size() >= max_inventory_size:
        print("❌ Inventory full! Cannot add " + item_name)
        return false
    else:
        player_inventory.append(item_name)
        print("✅ Added " + item_name + " (" + str(player_inventory.size()) + "/" + str(max_inventory_size) + ")")
        return true

func add_to_category(item_name: String, category: String) -> bool:
    # Check if item belongs to this category
    if category in item_types and item_name in item_types[category]:
        player_inventory.append(item_name)
        print("✅ Added " + item_name + " to inventory (Category: " + category + ")")
        return true
    else:
        print("❌ " + item_name + " is not a valid " + category + " item!")
        return false

func add_multiple_items(items: Array[String]):
    print("Adding multiple items:")
    var added_count = 0
    for item in items:
        if add_unique_item(item):
            added_count += 1
    print("Successfully added " + str(added_count) + "/" + str(items.size()) + " items")
```

### Step 3: Smart Removing Functions
**Add these intelligent removal methods**:

```gdscript
func practice_smart_removing():
    print("\n--- Smart Removing Practice ---")
    
    # Remove by name
    remove_item_by_name("Health Potion")
    remove_item_by_name("Nonexistent Item")  # Should fail gracefully
    
    # Remove by category
    remove_items_by_category("potions")
    
    # Remove multiple specific items
    remove_multiple_items(["Bronze Key", "Iron Sword"])
    
    # Remove all but keep one
    add_multiple_items(["Gold Coin", "Gold Coin", "Gold Coin"])  # Add duplicates
    remove_excess_items("Gold Coin", 1)  # Keep only 1

func remove_item_by_name(item_name: String) -> bool:
    var index = player_inventory.find(item_name)
    if index >= 0:
        player_inventory.remove_at(index)
        print("🗑️ Removed " + item_name)
        return true
    else:
        print("❌ " + item_name + " not found in inventory")
        return false

func remove_items_by_category(category: String) -> int:
    if not category in item_types:
        print("❌ Unknown category: " + category)
        return 0
    
    var removed_count = 0
    var category_items = item_types[category]
    
    # Loop backwards to avoid index shifting issues
    for i in range(player_inventory.size() - 1, -1, -1):
        if player_inventory[i] in category_items:
            var removed_item = player_inventory[i]
            player_inventory.remove_at(i)
            print("🗑️ Removed " + removed_item + " (Category: " + category + ")")
            removed_count += 1
    
    print("Removed " + str(removed_count) + " " + category + " items")
    return removed_count

func remove_multiple_items(items: Array[String]) -> int:
    var removed_count = 0
    for item in items:
        if remove_item_by_name(item):
            removed_count += 1
    return removed_count

func remove_excess_items(item_name: String, keep_count: int) -> int:
    var current_count = count_item(item_name)
    var excess_count = current_count - keep_count
    
    if excess_count <= 0:
        print("No excess " + item_name + " to remove")
        return 0
    
    var removed_count = 0
    # Loop backwards to avoid index issues
    for i in range(player_inventory.size() - 1, -1, -1):
        if player_inventory[i] == item_name and removed_count < excess_count:
            player_inventory.remove_at(i)
            removed_count += 1
    
    print("Removed " + str(removed_count) + " excess " + item_name + " (kept " + str(keep_count) + ")")
    return removed_count

func count_item(item_name: String) -> int:
    var count = 0
    for item in player_inventory:
        if item == item_name:
            count += 1
    return count
```

## Part 2: Array Searching

### Step 4: Efficient Array Searching
**Add these search methods** to find items quickly:

```gdscript
func practice_array_searching():
    print("\n--- Array Searching Practice ---")
    
    # Basic searches
    find_exact_item("Gold Coin")
    find_partial_match("Sword")
    
    # Advanced searches
    find_items_by_criteria()
    find_first_of_type("weapons")
    find_all_of_type("keys")

func find_exact_item(item_name: String) -> int:
    var index = player_inventory.find(item_name)
    if index >= 0:
        print("🔍 Found '" + item_name + "' at position " + str(index))
        return index
    else:
        print("❌ '" + item_name + "' not found")
        return -1

func find_partial_match(search_term: String) -> Array[String]:
    var matches: Array[String] = []
    
    print("🔍 Searching for items containing '" + search_term + "':")
    for item in player_inventory:
        if search_term.to_lower() in item.to_lower():
            matches.append(item)
            print("  - " + item)
    
    if matches.size() == 0:
        print("  No matches found")
    
    return matches

func find_items_by_criteria() -> Array[String]:
    print("🔍 Finding items by custom criteria:")
    var results: Array[String] = []
    
    # Find items with more than 5 characters
    for item in player_inventory:
        if item.length() > 5:
            results.append(item)
            print("  Long name: " + item + " (" + str(item.length()) + " chars)")
    
    return results

func find_first_of_type(item_type: String) -> String:
    if not item_type in item_types:
        print("❌ Unknown item type: " + item_type)
        return ""
    
    var type_items = item_types[item_type]
    
    for item in player_inventory:
        if item in type_items:
            print("🔍 First " + item_type + " found: " + item)
            return item
    
    print("❌ No " + item_type + " found in inventory")
    return ""

func find_all_of_type(item_type: String) -> Array[String]:
    var results: Array[String] = []
    
    if not item_type in item_types:
        print("❌ Unknown item type: " + item_type)
        return results
    
    var type_items = item_types[item_type]
    
    print("🔍 Finding all " + item_type + " items:")
    for item in player_inventory:
        if item in type_items:
            results.append(item)
            print("  - " + item)
    
    if results.size() == 0:
        print("  No " + item_type + " items found")
    
    return results
```

## Part 3: Array Filtering

### Step 5: Array Filtering Operations
**Add these filtering methods** to create focused subsets:

```gdscript
func practice_array_filtering():
    print("\n--- Array Filtering Practice ---")
    
    # Filter by item type
    filter_by_type("weapons")
    filter_by_type("potions")
    
    # Filter by custom criteria
    filter_by_name_length(8)  # Items with 8+ characters
    filter_valuable_items()
    
    # Complex filtering
    filter_with_multiple_criteria()

func filter_by_type(item_type: String) -> Array[String]:
    var filtered: Array[String] = []
    
    if not item_type in item_types:
        print("❌ Unknown item type: " + item_type)
        return filtered
    
    var type_items = item_types[item_type]
    
    for item in player_inventory:
        if item in type_items:
            filtered.append(item)
    
    print("🔽 Filtered " + item_type + " (" + str(filtered.size()) + " items):")
    for item in filtered:
        print("  - " + item)
    
    return filtered

func filter_by_name_length(min_length: int) -> Array[String]:
    var filtered: Array[String] = []
    
    print("🔽 Items with " + str(min_length) + "+ characters:")
    for item in player_inventory:
        if item.length() >= min_length:
            filtered.append(item)
            print("  - " + item + " (" + str(item.length()) + " chars)")
    
    return filtered

func filter_valuable_items() -> Array[String]:
    var valuable_items = ["Ruby Gem", "Ancient Scroll", "Magic Staff", "Master Key"]
    var filtered: Array[String] = []
    
    print("🔽 Valuable items in inventory:")
    for item in player_inventory:
        if item in valuable_items:
            filtered.append(item)
            print("  💎 " + item)
    
    if filtered.size() == 0:
        print("  No valuable items found")
    
    return filtered

func filter_with_multiple_criteria() -> Array[String]:
    var filtered: Array[String] = []
    
    print("🔽 Items that are weapons OR have 'Key' in name:")
    
    var weapon_items = item_types["weapons"]
    
    for item in player_inventory:
        # Include if it's a weapon OR contains "Key"
        if item in weapon_items or "Key" in item:
            filtered.append(item)
            var reason = ""
            if item in weapon_items:
                reason += "weapon "
            if "Key" in item:
                reason += "key "
            print("  - " + item + " (" + reason.strip_edges() + ")")
    
    return filtered
```

## Part 4: Array Sorting

### Step 6: Advanced Sorting Methods
**Add these sorting capabilities** for organized data:

```gdscript
func practice_array_sorting():
    print("\n--- Array Sorting Practice ---")
    
    # Basic sorting
    sort_alphabetically()
    sort_by_length()
    
    # Advanced sorting
    sort_by_type_priority()
    sort_by_multiple_criteria()

func sort_alphabetically():
    var sorted_inventory = player_inventory.duplicate()
    sorted_inventory.sort()
    
    print("🔤 Alphabetical order:")
    for i in range(sorted_inventory.size()):
        print("  " + str(i + 1) + ". " + sorted_inventory[i])

func sort_by_length():
    var sorted_inventory = player_inventory.duplicate()
    
    # Custom sort by string length (shortest first)
    sorted_inventory.sort_custom(func(a, b): return a.length() < b.length())
    
    print("📏 Sorted by length (shortest first):")
    for item in sorted_inventory:
        print("  " + item + " (" + str(item.length()) + " chars)")

func sort_by_type_priority():
    var sorted_inventory = player_inventory.duplicate()
    
    # Define priority order
    var type_priority = {
        "weapons": 1,
        "potions": 2,
        "keys": 3,
        "treasures": 4,
        "unknown": 5
    }
    
    # Custom sort by item type priority
    sorted_inventory.sort_custom(func(a, b): 
        var priority_a = get_item_type_priority(a, type_priority)
        var priority_b = get_item_type_priority(b, type_priority)
        return priority_a < priority_b
    )
    
    print("⚔️ Sorted by type priority (weapons first):")
    for item in sorted_inventory:
        var item_type = get_item_type(item)
        print("  " + item + " (" + item_type + ")")

func get_item_type_priority(item_name: String, priority_map: Dictionary) -> int:
    var item_type = get_item_type(item_name)
    return priority_map.get(item_type, 5)  # Default to 5 if unknown

func get_item_type(item_name: String) -> String:
    for type_name in item_types:
        if item_name in item_types[type_name]:
            return type_name
    return "unknown"

func sort_by_multiple_criteria():
    var sorted_inventory = player_inventory.duplicate()
    
    # Sort by: 1) Type priority, 2) Alphabetically within type
    sorted_inventory.sort_custom(func(a, b):
        var type_a = get_item_type(a)
        var type_b = get_item_type(b)
        
        # First, compare by type
        if type_a != type_b:
            var priority_a = get_item_type_priority(a, {"weapons": 1, "potions": 2, "keys": 3, "treasures": 4, "unknown": 5})
            var priority_b = get_item_type_priority(b, {"weapons": 1, "potions": 2, "keys": 3, "treasures": 4, "unknown": 5})
            return priority_a < priority_b
        
        # If same type, sort alphabetically
        return a < b
    )
    
    print("🎯 Multi-criteria sort (type priority, then alphabetical):")
    var current_type = ""
    for item in sorted_inventory:
        var item_type = get_item_type(item)
        if item_type != current_type:
            current_type = item_type
            print("  --- " + item_type.to_upper() + " ---")
        print("    " + item)
```

## Part 5: Advanced Array Operations

### Step 7: Array Merging and Combining
**Add these operations** for complex array manipulations:

```gdscript
func practice_array_operations():
    print("\n--- Advanced Array Operations ---")
    
    # Set up additional arrays for testing
    var enemy_loot: Array[String] = ["Silver Bow", "Mana Potion", "Ruby Gem"]
    var shop_items: Array[String] = ["Steel Axe", "Health Potion", "Master Key"]
    
    # Practice different operations
    merge_arrays_simple(enemy_loot)
    merge_arrays_unique(shop_items)
    split_array_by_type()
    find_array_differences(enemy_loot)
    intersect_arrays(shop_items)

func merge_arrays_simple(other_array: Array[String]):
    print("🔗 Simple merge (allows duplicates):")
    print("  Before: " + str(player_inventory))
    print("  Merging: " + str(other_array))
    
    var original_size = player_inventory.size()
    player_inventory.append_array(other_array)
    
    print("  After: " + str(player_inventory))
    print("  Added " + str(player_inventory.size() - original_size) + " items")

func merge_arrays_unique(other_array: Array[String]):
    print("🔗 Unique merge (no duplicates):")
    print("  Before: " + str(player_inventory))
    print("  Merging: " + str(other_array))
    
    var added_count = 0
    for item in other_array:
        if not item in player_inventory:
            player_inventory.append(item)
            added_count += 1
            print("    ✅ Added: " + item)
        else:
            print("    ⚠️ Skipped duplicate: " + item)
    
    print("  Added " + str(added_count) + " unique items")

func split_array_by_type() -> Dictionary:
    print("✂️ Splitting inventory by type:")
    
    var categorized = {}
    
    # Initialize categories
    for type_name in item_types:
        categorized[type_name] = []
    categorized["unknown"] = []
    
    # Categorize each item
    for item in player_inventory:
        var item_type = get_item_type(item)
        categorized[item_type].append(item)
    
    # Display results
    for type_name in categorized:
        var items = categorized[type_name]
        if items.size() > 0:
            print("  " + type_name.capitalize() + " (" + str(items.size()) + "):")
            for item in items:
                print("    - " + item)
    
    return categorized

func find_array_differences(other_array: Array[String]) -> Array[String]:
    print("📊 Finding differences:")
    
    # Items in player_inventory but not in other_array
    var unique_to_player: Array[String] = []
    for item in player_inventory:
        if not item in other_array:
            unique_to_player.append(item)
    
    # Items in other_array but not in player_inventory
    var unique_to_other: Array[String] = []
    for item in other_array:
        if not item in player_inventory:
            unique_to_other.append(item)
    
    print("  Player has but other doesn't:")
    for item in unique_to_player:
        print("    - " + item)
    
    print("  Other has but player doesn't:")
    for item in unique_to_other:
        print("    - " + item)
    
    return unique_to_player

func intersect_arrays(other_array: Array[String]) -> Array[String]:
    print("🔄 Finding common items (intersection):")
    
    var common_items: Array[String] = []
    
    for item in player_inventory:
        if item in other_array and not item in common_items:
            common_items.append(item)
    
    print("  Common items (" + str(common_items.size()) + "):")
    for item in common_items:
        print("    - " + item)
    
    return common_items
```

## Part 6: Utility Functions

### Step 8: Add Helper Functions
**Add these utility functions** that you'll use frequently:

```gdscript
func print_all_arrays():
    print("\n--- Current Array Status ---")
    print("Inventory (" + str(player_inventory.size()) + "): " + str(player_inventory))
    print("Enemies (" + str(enemy_squad.size()) + "): " + str(enemy_squad))
    print("Quests (" + str(completed_quests.size()) + "): " + str(completed_quests))
    print("Skills (" + str(available_skills.size()) + "): " + str(available_skills))

func get_array_statistics(array: Array) -> Dictionary:
    var stats = {}
    
    stats["size"] = array.size()
    stats["is_empty"] = array.is_empty()
    
    if array.size() > 0:
        # For string arrays, get length statistics
        if array[0] is String:
            var lengths: Array[int] = []
            for item in array:
                lengths.append(item.length())
            
            lengths.sort()
            stats["shortest_length"] = lengths[0]
            stats["longest_length"] = lengths[-1]
            stats["average_length"] = get_average(lengths)
    
    return stats

func get_average(numbers: Array[int]) -> float:
    if numbers.size() == 0:
        return 0.0
    
    var sum = 0
    for num in numbers:
        sum += num
    
    return float(sum) / float(numbers.size())

func validate_array_integrity() -> bool:
    print("🔍 Validating array integrity:")
    
    var is_valid = true
    
    # Check for null or invalid entries
    for i in range(player_inventory.size()):
        var item = player_inventory[i]
        if item == null or item == "":
            print("  ❌ Invalid item at index " + str(i))
            is_valid = false
    
    # Check for excessive duplicates (might indicate a bug)
    var item_counts = {}
    for item in player_inventory:
        if item in item_counts:
            item_counts[item] += 1
        else:
            item_counts[item] = 1
    
    for item_name in item_counts:
        var count = item_counts[item_name]
        if count > 5:  # Arbitrary threshold
            print("  ⚠️ Excessive duplicates: " + item_name + " (" + str(count) + " copies)")
    
    if is_valid:
        print("  ✅ Array integrity check passed")
    
    return is_valid

func cleanup_array() -> int:
    print("🧹 Cleaning up inventory:")
    
    var original_size = player_inventory.size()
    var cleaned_inventory: Array[String] = []
    
    # Remove null, empty, and invalid entries
    for item in player_inventory:
        if item != null and item != "" and item.length() > 0:
            cleaned_inventory.append(item)
        else:
            print("  Removed invalid item: '" + str(item) + "'")
    
    player_inventory = cleaned_inventory
    var removed_count = original_size - player_inventory.size()
    
    print("  Removed " + str(removed_count) + " invalid items")
    return removed_count
```

## Part 7: Performance Optimization

### Step 9: Efficient Array Operations
**Add performance-conscious methods**:

```gdscript
# Add these performance tips as comments and examples

# PERFORMANCE TIP 1: Use 'in' operator for existence checks (faster than find())
func efficient_existence_check(item_name: String) -> bool:
    # ✅ Fast - uses built-in optimization
    return item_name in player_inventory
    
    # ❌ Slower - linear search
    # return player_inventory.find(item_name) >= 0

# PERFORMANCE TIP 2: Loop backwards when removing during iteration
func efficient_conditional_removal(criteria_func: Callable) -> int:
    var removed_count = 0
    
    # ✅ Loop backwards to avoid index shifting
    for i in range(player_inventory.size() - 1, -1, -1):
        if criteria_func.call(player_inventory[i]):
            player_inventory.remove_at(i)
            removed_count += 1
    
    return removed_count

# PERFORMANCE TIP 3: Use duplicate() for non-destructive operations
func safe_array_manipulation(original_array: Array[String]) -> Array[String]:
    # ✅ Safe - doesn't modify original
    var working_copy = original_array.duplicate()
    working_copy.sort()
    return working_copy
    
    # ❌ Dangerous - modifies original array
    # original_array.sort()
    # return original_array

# PERFORMANCE TIP 4: Pre-allocate arrays when size is known
func efficient_array_building(expected_size: int) -> Array[String]:
    var result: Array[String] = []
    result.resize(expected_size)  # Pre-allocate memory
    
    # Fill the array...
    for i in range(expected_size):
        result[i] = "Item " + str(i)
    
    return result
```

## Part 8: Testing Your Array Manipulation

### Step 10: Comprehensive Testing
**Add a complete test of all functionality**:

```gdscript
func test_all_operations():
    print("\n=== COMPREHENSIVE ARRAY MANIPULATION TEST ===")
    
    # Reset to known state
    player_inventory = ["Iron Sword", "Health Potion", "Bronze Key"]
    print("Starting inventory: " + str(player_inventory))
    
    # Test adding
    print("\n1. Testing Smart Adding:")
    add_unique_item("Steel Axe")
    add_unique_item("Health Potion")  # Duplicate
    add_with_limit("Mana Potion", 5)
    
    # Test searching
    print("\n2. Testing Searching:")
    find_exact_item("Steel Axe")
    find_partial_match("Potion")
    
    # Test filtering
    print("\n3. Testing Filtering:")
    filter_by_type("weapons")
    filter_by_name_length(8)
    
    # Test sorting
    print("\n4. Testing Sorting:")
    sort_alphabetically()
    sort_by_type_priority()
    
    # Test operations
    print("\n5. Testing Operations:")
    var test_loot = ["Ruby Gem", "Magic Staff"]
    merge_arrays_unique(test_loot)
    
    # Test utilities
    print("\n6. Testing Utilities:")
    var stats = get_array_statistics(player_inventory)
    print("Array stats: " + str(stats))
    validate_array_integrity()
    
    print("\n=== TEST COMPLETE ===")
    print("Final inventory: " + str(player_inventory))
```

## Deliverables
By the end of this lesson, you should have:
- [ ] Array manipulation script with smart adding/removing functions
- [ ] Efficient search methods for finding specific items
- [ ] Filtering capabilities to create focused data subsets
- [ ] Advanced sorting methods with multiple criteria
- [ ] Array operation functions for merging, splitting, and comparing
- [ ] Utility functions for array maintenance and validation
- [ ] Understanding of performance optimization techniques
- [ ] Comprehensive test demonstrating all functionality

## Next Lesson Preview - Complete Inventory System!
**In Lesson 13**, we'll combine everything you've learned to build a complete inventory system:
- **Full Integration**: Arrays + Display + Manipulation working together
- **Player Interaction**: Adding/removing items through game actions
- **Save/Load**: Preserving inventory between game sessions
- **Polish**: Professional inventory interface with all features

**This is where everything comes together** into a real game feature!

## Troubleshooting

**"Array operations are slow with large inventories"**
- Use `in` operator instead of `find()` for existence checks
- Loop backwards when removing items during iteration
- Consider using Dictionary for O(1) lookups if you have very large inventories

**"Getting index errors during manipulation"**
- Always check array bounds before accessing elements
- Use `array.size() > 0` before accessing array[0]
- Loop backwards when removing elements during iteration

**"Duplicate items keep appearing"**
- Use `add_unique_item()` instead of `append()` directly
- Implement validation in your item addition functions
- Regular cleanup with `cleanup_array()` function

**"Sorting isn't working as expected"**
- Check that your comparison functions return boolean values
- Use `duplicate()` to avoid modifying original arrays during testing
- Debug by printing intermediate results in your sort functions

## Reflection Questions
Write down or discuss:

1. **Efficiency**: Which array operations are fastest/slowest and why?
2. **Data Integrity**: How do you prevent invalid data from entering arrays?
3. **User Experience**: How do smart array operations improve gameplay?
4. **System Design**: When should you use arrays vs other data structures?
5. **Performance**: What techniques help maintain performance with large arrays?

**You now have a complete toolkit for sophisticated array manipulation in games!** 🎮

---

*These skills are essential for inventory systems, quest management, enemy spawning, loot generation, and any game feature that requires dynamic data management.*
