# Lesson 10: Arrays of Objects - Managing Complex Game Entities

## Learning Objectives
By the end of this lesson, you will:
- Understand the difference between arrays of simple data vs arrays of objects
- Store custom class instances (Enemy, Pickup, NPC) in arrays for management
- Access properties and methods of objects stored in arrays
- Create dynamic enemy spawning systems using object arrays
- Experience how object arrays enable sophisticated game systems

## Getting Started

### The Difference: Simple Data vs Objects

**What you've been doing** (arrays of simple data):
```gdscript
var enemy_names: Array[String] = ["Goblin", "Orc", "Troll"]
var enemy_health: Array[int] = [50, 80, 120]
var enemy_damage: Array[int] = [10, 15, 25]
# Separate arrays - hard to keep synchronized!
```

**What we're learning today** (arrays of objects):
```gdscript
var enemies: Array[Enemy] = []  # Each element is a complete Enemy object
# One array holds complete enemy objects with all their properties and methods!
```

### Why Object Arrays Are Powerful

**Problems with separate arrays**:
- ❌ **Data synchronization**: Hard to keep related data together
- ❌ **Adding/removing**: Must update multiple arrays
- ❌ **Complexity**: More arrays = more confusion
- ❌ **Error-prone**: Easy to get indexes mixed up

**Benefits of object arrays**:
- ✅ **Complete entities**: Each array element is a full object
- ✅ **Synchronized data**: All properties stay together
- ✅ **Easy management**: Add/remove complete objects
- ✅ **Method access**: Can call methods on array objects

## Part 1: Understanding Object Arrays

### Step 1: Create Enemy Spawner Script
**Create** a new script for practicing object arrays: `scripts/enemy_spawner.gd`

```gdscript
extends Node2D
class_name EnemySpawner

# Array to hold Enemy objects - this is our object array!
var active_enemies: Array[Enemy] = []

# Spawn configuration
@export var max_enemies: int = 5
@export var spawn_radius: float = 300.0

func _ready():
    print("=== ENEMY SPAWNER PRACTICE ===")
    print("Learning about arrays of objects!")
    
    # Demonstrate the difference
    demonstrate_simple_vs_object_arrays()
    
    # Practice with object arrays
    practice_enemy_object_arrays()
    
    print("===============================")

func demonstrate_simple_vs_object_arrays():
    print("\n--- Simple Arrays vs Object Arrays ---")
    
    # OLD WAY: Separate arrays for enemy data
    var enemy_names: Array[String] = ["Goblin", "Orc"]
    var enemy_health: Array[int] = [50, 80]
    var enemy_damage: Array[int] = [10, 15]
    
    print("Old way - separate arrays:")
    for i in range(enemy_names.size()):
        print("  " + enemy_names[i] + " - HP: " + str(enemy_health[i]) + ", Damage: " + str(enemy_damage[i]))
    
    print("\nProblems with separate arrays:")
    print("  - Must keep arrays synchronized")
    print("  - Adding enemy requires updating 3 arrays")
    print("  - Easy to make mistakes with indexes")
    
    print("\nNEW WAY: Array of Enemy objects")
    print("  - Each array element is a complete Enemy")
    print("  - All data stays together automatically")
    print("  - Add/remove complete objects easily")

func practice_enemy_object_arrays():
    print("\n--- Object Array Practice ---")
    # We'll add code here step by step
    pass
```

## Part 2: Creating Arrays of Enemy Objects

### Step 2: Add Enemy Creation to Object Array Practice
**Add this code** to your `practice_enemy_object_arrays()` function:

```gdscript
func practice_enemy_object_arrays():
    print("\n--- Object Array Practice ---")
    
    # Clear any existing enemies
    active_enemies.clear()
    print("Starting with empty enemy array")
    print("Active enemies: " + str(active_enemies.size()))
    
    # Create enemy objects and add them to array
    create_test_enemies()
    
    # Practice accessing object properties
    access_enemy_properties()
    
    # Practice calling object methods
    call_enemy_methods()
    
    # Practice finding specific enemies
    find_enemies_by_criteria()

func create_test_enemies():
    print("\n--- Creating Enemy Objects ---")
    
    # Method 1: Create enemy and configure it, then add to array
    var goblin = Enemy.new()
    goblin.character_name = "Sneaky Goblin"
    goblin.max_health = 50
    goblin.current_health = 50
    goblin.damage = 12
    goblin.level = 2
    active_enemies.append(goblin)
    print("Created and added: " + goblin.character_name)
    
    # Method 2: Create enemy with different stats
    var orc = Enemy.new()
    orc.character_name = "Fierce Orc"
    orc.max_health = 80
    orc.current_health = 80
    orc.damage = 18
    orc.level = 4
    active_enemies.append(orc)
    print("Created and added: " + orc.character_name)
    
    # Method 3: Create a wounded enemy
    var wounded_troll = Enemy.new()
    wounded_troll.character_name = "Wounded Troll"
    wounded_troll.max_health = 120
    wounded_troll.current_health = 30  # Already damaged!
    wounded_troll.damage = 25
    wounded_troll.level = 6
    active_enemies.append(wounded_troll)
    print("Created and added: " + wounded_troll.character_name)
    
    print("Total enemies in array: " + str(active_enemies.size()))
```

### Step 3: Access Object Properties in Arrays
**Add this function** to practice accessing properties of objects in arrays:

```gdscript
func access_enemy_properties():
    print("\n--- Accessing Object Properties ---")
    
    # Loop through all enemies and show their stats
    print("Enemy roster:")
    for i in range(active_enemies.size()):
        var enemy = active_enemies[i]
        print("  " + str(i + 1) + ". " + enemy.character_name)
        print("     Health: " + str(enemy.current_health) + "/" + str(enemy.max_health))
        print("     Damage: " + str(enemy.damage))
        print("     Level: " + str(enemy.level))
        
        # Calculate health percentage
        var health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
        print("     Health: " + str(int(health_percent)) + "%")
    
    # Access specific enemy by index
    if active_enemies.size() > 0:
        var first_enemy = active_enemies[0]
        print("\nFirst enemy details:")
        print("  Name: " + first_enemy.character_name)
        print("  Is alive: " + str(first_enemy.current_health > 0))
```

### Step 4: Call Methods on Objects in Arrays
**Add this function** to practice calling methods on array objects:

```gdscript
func call_enemy_methods():
    print("\n--- Calling Object Methods ---")
    
    # Call methods on enemies in the array
    print("Testing enemy methods:")
    
    for enemy in active_enemies:
        print("\nTesting " + enemy.character_name + ":")
        
        # Test take_damage method (inherited from Character)
        if enemy.current_health > 0:
            print("  Before damage - Health: " + str(enemy.current_health))
            enemy.take_damage(10)
            print("  After damage - Health: " + str(enemy.current_health))
        
        # Test heal method (inherited from Character)  
        if enemy.current_health < enemy.max_health and enemy.current_health > 0:
            print("  Healing " + enemy.character_name)
            enemy.heal(15)
    
    # Remove dead enemies from array
    remove_dead_enemies()

func remove_dead_enemies():
    print("\n--- Removing Dead Enemies ---")
    
    # Count living enemies before cleanup
    var living_count = 0
    for enemy in active_enemies:
        if enemy.current_health > 0:
            living_count += 1
    
    print("Living enemies before cleanup: " + str(living_count))
    
    # Remove dead enemies (health <= 0)
    # Loop backwards to avoid index shifting issues
    for i in range(active_enemies.size() - 1, -1, -1):
        var enemy = active_enemies[i]
        if enemy.current_health <= 0:
            print("Removing dead enemy: " + enemy.character_name)
            active_enemies.remove_at(i)
    
    print("Enemies remaining: " + str(active_enemies.size()))
```

### Step 5: Find Objects by Criteria
**Add this function** to practice searching through object arrays:

```gdscript
func find_enemies_by_criteria():
    print("\n--- Finding Enemies by Criteria ---")
    
    # Find enemies with low health (< 50%)
    print("Enemies with low health:")
    for enemy in active_enemies:
        var health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
        if health_percent < 50.0:
            print("  " + enemy.character_name + " (" + str(int(health_percent)) + "% health)")
    
    # Find the strongest enemy (highest damage)
    if active_enemies.size() > 0:
        var strongest_enemy = active_enemies[0]
        for enemy in active_enemies:
            if enemy.damage > strongest_enemy.damage:
                strongest_enemy = enemy
        print("Strongest enemy: " + strongest_enemy.character_name + " (Damage: " + str(strongest_enemy.damage) + ")")
    
    # Find enemies by level range
    print("High-level enemies (level 4+):")
    for enemy in active_enemies:
        if enemy.level >= 4:
            print("  " + enemy.character_name + " (Level " + str(enemy.level) + ")")
    
    # Count enemies by name pattern
    var goblin_count = 0
    for enemy in active_enemies:
        if "Goblin" in enemy.character_name:
            goblin_count += 1
    print("Goblin-type enemies: " + str(goblin_count))

## Part 3: Practical Object Array Applications

### Step 6: Create a Dynamic Enemy Squad System
**Add this advanced function** to show real game applications:

```gdscript
func create_dynamic_squad_system():
    print("\n--- Dynamic Squad System ---")
    
    # Create a mixed squad of enemies
    create_balanced_squad()
    
    # Squad management
    manage_squad_health()
    
    # Squad coordination
    coordinate_squad_actions()

func create_balanced_squad():
    print("Creating balanced enemy squad...")
    
    # Clear existing enemies
    active_enemies.clear()
    
    # Squad composition: Tank, DPS, Support
    var tank = Enemy.new()
    tank.character_name = "Orc Guardian"
    tank.max_health = 150
    tank.current_health = 150
    tank.damage = 12
    tank.level = 5
    active_enemies.append(tank)
    
    var dps = Enemy.new()
    dps.character_name = "Goblin Assassin"
    dps.max_health = 60
    dps.current_health = 60
    dps.damage = 30
    dps.level = 4
    active_enemies.append(dps)
    
    var support = Enemy.new()
    support.character_name = "Shaman Healer"
    support.max_health = 80
    support.current_health = 80
    support.damage = 8
    support.level = 6
    active_enemies.append(support)
    
    print("Squad created with " + str(active_enemies.size()) + " members:")
    for enemy in active_enemies:
        print("  " + enemy.character_name + " (Role based on stats)")

func manage_squad_health():
    print("\nSquad health management:")
    
    # Calculate total squad health
    var total_health = 0
    var max_total_health = 0
    
    for enemy in active_enemies:
        total_health += enemy.current_health
        max_total_health += enemy.max_health
    
    var squad_health_percent = (float(total_health) / float(max_total_health)) * 100.0
    print("Squad health: " + str(total_health) + "/" + str(max_total_health) + " (" + str(int(squad_health_percent)) + "%)")
    
    # Find the most wounded squad member
    if active_enemies.size() > 0:
        var most_wounded = active_enemies[0]
        var lowest_health_percent = (float(most_wounded.current_health) / float(most_wounded.max_health)) * 100.0
        
        for enemy in active_enemies:
            var enemy_health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
            if enemy_health_percent < lowest_health_percent:
                most_wounded = enemy
                lowest_health_percent = enemy_health_percent
        
        print("Most wounded: " + most_wounded.character_name + " (" + str(int(lowest_health_percent)) + "% health)")

func coordinate_squad_actions():
    print("\nSquad coordination:")
    
    # Simulate combat round where each enemy acts
    for i in range(active_enemies.size()):
        var enemy = active_enemies[i]
        print("  " + enemy.character_name + " attacks for " + str(enemy.damage) + " damage!")
        
        # More complex AI could go here:
        # - Healers prioritize healing wounded allies
        # - Tanks focus on protecting weaker members
        # - DPS focuses on maximum damage output
```

## Part 4: Alternative Object Array Examples

### Step 7: Pickup Loot System Practice
**Create an alternative example** using Pickup objects:

```gdscript
# Add this to your EnemySpawner class
var available_loot: Array[Pickup] = []

func practice_pickup_object_arrays():
    print("\n--- Pickup Object Arrays ---")
    
    # Create different types of pickups
    var health_potion = HealthPotion.new()
    health_potion.heal_amount = 50
    available_loot.append(health_potion)
    
    var coin = Coin.new()
    coin.coin_value = 25
    available_loot.append(coin)
    
    var exp_gem = ExperienceGem.new()
    exp_gem.exp_value = 100
    available_loot.append(exp_gem)
    
    print("Loot collection contains " + str(available_loot.size()) + " items:")
    for pickup in available_loot:
        print("  " + pickup.get_pickup_name())
    
    # Demonstrate polymorphism - same method call works on different object types
    print("\nTesting polymorphism:")
    for pickup in available_loot:
        print("  " + pickup.get_pickup_name() + " would be picked up")
        # Note: We can call get_pickup_name() on any Pickup object!
```

### Step 8: Understanding Object Array Benefits
**Add this summary function** to your `_ready()` method:

```gdscript
func _ready():
    print("=== ENEMY SPAWNER PRACTICE ===")
    print("Learning about arrays of objects!")
    
    demonstrate_simple_vs_object_arrays()
    practice_enemy_object_arrays()
    create_dynamic_squad_system()
    practice_pickup_object_arrays()
    summarize_object_array_benefits()
    
    print("===============================")

func summarize_object_array_benefits():
    print("\n--- Object Array Benefits Summary ---")
    
    print("✅ Complete entities: Each array element is a full object")
    print("✅ Data integrity: Properties stay synchronized automatically")
    print("✅ Method access: Can call methods on objects in arrays")
    print("✅ Polymorphism: Same array can hold different object types")
    print("✅ Easy management: Add/remove complete functional objects")
    print("✅ Type safety: Array[Enemy] only holds Enemy objects")
    
    print("\nReal game applications:")
    print("  - Enemy spawning and management systems")
    print("  - Player inventory holding different item types")
    print("  - Projectile arrays for bullets, arrows, spells")
    print("  - UI element arrays for menus and interfaces")
    print("  - Save data arrays for player progress")
```

## Part 5: Testing Your Object Arrays

### Step 9: Create and Test the Enemy Spawner Scene
1. **Create** a new scene (`scenes/enemy_spawner_test.tscn`)
2. **Add** a Node2D as root node
3. **Attach** your `enemy_spawner.gd` script to the root node
4. **Save** the scene

### Step 10: Test Your Object Array System
1. **Run** the enemy spawner test scene
2. **Check the console** for all the object array demonstrations
3. **Verify** that:
   - Objects are created and added to arrays
   - Properties can be accessed on array objects
   - Methods can be called on array objects
   - Objects can be found and filtered
   - Dead objects are removed properly

### Expected Console Output
```
=== ENEMY SPAWNER PRACTICE ===
Learning about arrays of objects!

--- Simple Arrays vs Object Arrays ---
Old way - separate arrays:
  Goblin - HP: 50, Damage: 10
  Orc - HP: 80, Damage: 15
...

--- Object Array Practice ---
Starting with empty enemy array
Created and added: Sneaky Goblin
Created and added: Fierce Orc
...
```

## Part 6: Common Object Array Patterns

### Pattern 1: Find and Modify Objects
```gdscript
# Find enemy by name and heal them
for enemy in active_enemies:
    if enemy.character_name == "Wounded Troll":
        enemy.heal(50)
        break  # Stop after finding the first match
```

### Pattern 2: Filter Objects by Criteria
```gdscript
# Get all low-health enemies
var wounded_enemies: Array[Enemy] = []
for enemy in active_enemies:
    var health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
    if health_percent < 30.0:
        wounded_enemies.append(enemy)
```

### Pattern 3: Sort Objects by Property
```gdscript
# Sort enemies by health (lowest first)
active_enemies.sort_custom(func(a, b): return a.current_health < b.current_health)
```

### Pattern 4: Apply Action to All Objects
```gdscript
# Heal all enemies by 10 HP
for enemy in active_enemies:
    enemy.heal(10)
```

## Deliverables
By the end of this lesson, you should have:
- [ ] EnemySpawner script that demonstrates object arrays
- [ ] Understanding of the difference between simple data arrays and object arrays
- [ ] Ability to create, access, and modify objects stored in arrays
- [ ] Experience with finding and filtering objects by criteria
- [ ] Working test scene that demonstrates all object array concepts
- [ ] Recognition of when object arrays are better than separate data arrays

## Next Lesson Preview - Displaying Array Contents!
**In Lesson 11**, we'll learn how to show array information to players:
- **UI Lists**: Display inventory contents on screen
- **Dynamic Text**: Show array data in game interfaces
- **Visual Organization**: Present complex array data clearly
- **Player Interaction**: Let players browse and select from arrays

**This foundation** will prepare you for real inventory systems and game menus!

## Troubleshooting

**"Object array is empty after creating enemies"**
- Make sure you're calling `active_enemies.append(enemy)` after creating each enemy
- Check that the array is declared as `var active_enemies: Array[Enemy] = []`
- Verify that Enemy class exists and is properly defined

**"Can't access enemy properties"**
- Ensure the Enemy class has the properties you're trying to access
- Check that objects in the array are actually Enemy instances
- Verify inheritance is working (Enemy extends Character)

**"Methods don't exist on array objects"**
- Confirm the methods exist in the Enemy class or its parent (Character)
- Check spelling of method names carefully
- Make sure objects are properly instantiated with `Enemy.new()`

**"Array index errors with objects"**
- Always check `array.size() > 0` before accessing elements
- Use proper bounds checking when accessing by index
- Be careful when removing objects during iteration

## Reflection Questions
Write down or discuss:

1. **Data Organization**: How do object arrays keep related data better organized?
2. **Complexity Management**: How do object arrays simplify managing multiple entities?
3. **Code Quality**: Which is cleaner - multiple separate arrays or one object array?
4. **Game Systems**: What game systems would benefit from object arrays?
5. **Performance**: Are there any downsides to storing objects vs simple data in arrays?

**You now understand how to manage complex game entities using object arrays!** 🎮

---

*This foundation is essential for inventory systems, enemy management, projectile systems, and almost any game feature that deals with multiple similar objects.*
