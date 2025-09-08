# Lesson 1.5: Multiple Instances and Dynamic Creation

## Learning Objectives
By the end of this lesson, you will:
- Understand how to create class instances programmatically from code
- Learn to manage collections of objects of the same class
- Implement random generation systems using class blueprints
- Create a treasure chest that spawns different pickup types dynamically
- Debug and track dynamically created objects to ensure they work correctly

## What We're Building
Today we're creating a **Treasure Chest system** that spawns random coins and potions when opened! You'll discover how to create objects from code rather than just placing them in scenes manually.

## Part 1: Understanding Dynamic Object Creation

### Step 1: Examine Current Object Creation
Let's investigate how objects currently exist in your game:

1. **Open** `scenes/main.tscn`
2. **Look at the scene tree** - how many coins and potions do you see?
3. **Run the game** - these objects exist because you placed them manually
4. **Think**: What if you wanted 100 coins? Would you place each one manually?

### Step 2: Predict Dynamic Creation Needs
Answer these questions before we start building:

**Creation Questions:**
- How could you create a coin from code instead of placing it in the scene?
- What information would you need to create a coin programmatically?
- How could you make each dynamically created coin have different properties?

**Management Questions:**
- If you create 10 coins from code, how would you keep track of them?
- What happens to dynamically created objects when you change scenes?
- How could you verify that each created object works correctly?

## Part 2: Understanding Programmatic Instantiation

### Documentation: Scene Instantiation Pattern
Here's how to create objects from code in Godot:

```gdscript
# Example: Enemy spawner that creates different enemy types
extends Node2D
class_name EnemySpawner

# Store references to scene files
var goblin_scene = preload("res://scenes/goblin.tscn")
var orc_scene = preload("res://scenes/orc.tscn")

func spawn_random_enemy() -> Node:
    """Create and configure a random enemy. Returns the created enemy."""
    # Choose random enemy type
    var enemy_scenes = [goblin_scene, orc_scene]
    var chosen_scene = enemy_scenes[randi() % enemy_scenes.size()]
    
    # Create instance from scene
    var enemy = chosen_scene.instantiate()
    
    # Configure the enemy
    enemy.global_position = global_position
    enemy.level = randi_range(1, 3)
    
    # Add to scene tree
    get_parent().add_child(enemy)
    
    # Debug information
    print("Spawned " + enemy.name + " at level " + str(enemy.level))
    
    return enemy

func spawn_enemy_wave(count: int) -> Array:
    """Spawn multiple enemies and return array of created enemies."""
    var spawned_enemies = []
    
    for i in count:
        var enemy = spawn_random_enemy()
        spawned_enemies.append(enemy)
        
        # Space them out
        enemy.global_position.x += i * 50
    
    print("Spawned wave of " + str(count) + " enemies")
    return spawned_enemies
```

**Key Instantiation Concepts:**
- **preload()**: Load scene files at compile time
- **instantiate()**: Create new object from scene
- **configure properties**: Set values after creation
- **add_child()**: Add to scene tree so object appears
- **return references**: Allow caller to track created objects

## Part 3: Creating the Treasure Chest Class

### Step 3: Create TreasureChest Script
Create a new script `scripts/treasure_chest.gd`:

```gdscript
extends Area2D
class_name TreasureChest

# Chest properties
@export var is_opened: bool = false
@export var min_items: int = 2
@export var max_items: int = 5

# Scene references - TODO: preload your pickup scenes
# TODO: var coin_scene = preload("path/to/coin.tscn")
# TODO: var potion_scene = preload("path/to/health_potion.tscn")

# Tracking created objects
var spawned_pickups: Array = []

func _ready():
    print("Treasure chest ready - contains " + str(randi_range(min_items, max_items)) + " items")
    # TODO: Connect collision signal for player interaction
    pass

func _on_body_entered(body):
    # TODO: Check if body is Player and chest is not opened
    # TODO: If conditions met, call open_chest()
    pass

func open_chest() -> Array:
    """Open chest and spawn random pickups. Returns array of spawned items."""
    # TODO: Prevent opening twice
    # TODO: Determine how many items to spawn
    # TODO: Create random items using spawn_random_pickup()
    # TODO: Return array of created pickups for tracking
    pass
```

**Design Questions:**
- How will you prevent the chest from being opened multiple times?
- What should happen to the chest's appearance when opened?
- How will you track all the items you create?

### Step 4: Implement Random Pickup Creation
Add this method to create random pickups:

```gdscript
func spawn_random_pickup() -> Node:
    """Create a random pickup item. Returns the created pickup."""
    # TODO: Choose random pickup type (coin or potion)
    # TODO: If coin, choose random coin_type
    # TODO: If potion, choose random potion_type
    # TODO: Instantiate the appropriate scene
    # TODO: Configure the pickup's properties
    # TODO: Position it randomly near the chest
    # TODO: Add to scene tree
    # TODO: Return the created pickup for tracking
    pass
```

**Implementation Hints:**
- Use `randi() % 2` to choose between coin and potion
- Use arrays to store coin/potion type options
- Use `Vector2(randf_range(-50, 50), randf_range(-50, 50))` for random positioning

### Step 5: Complete the Chest Implementation
Following the enemy spawner example, implement your methods:

```gdscript
# At the top, add scene preloads:
var coin_scene = preload("res://scenes/coin.tscn")
var potion_scene = preload("res://scenes/health_potion.tscn")

func open_chest() -> Array:
    if is_opened:
        print("Chest already opened!")
        return []
    
    is_opened = true
    print("Opening treasure chest!")
    
    # TODO: Generate random number of items between min_items and max_items
    # TODO: Create that many random pickups using spawn_random_pickup()
    # TODO: Add each created pickup to spawned_pickups array
    # TODO: Return the spawned_pickups array
    pass

func spawn_random_pickup() -> Node:
    # TODO: Randomly choose pickup type (0 = coin, 1 = potion)
    # TODO: Create and configure the chosen type
    # TODO: Set random position near chest
    # TODO: Add to scene and return
    pass
```

## Part 4: Testing Dynamic Creation

### Step 6: Create Treasure Chest Scene
1. **Create** a new scene: `scenes/treasure_chest.tscn`
2. **Add** these nodes:
   - **Area2D** (root, rename to "TreasureChest")
   - **CollisionShape2D** (with RectangleShape2D)
   - **Sprite2D** (treasure chest image) or **ColorRect** (brown color)
3. **Attach** your `treasure_chest.gd` script
4. **Save** the scene

### Step 7: Add Chest to Game World
1. **Open** `scenes/main.tscn`
2. **Instance** your TreasureChest scene
3. **Position** it somewhere accessible
4. **Save** the scene

### Step 8: Test Basic Chest Functionality
1. **Run the game**
2. **Touch the chest** - does it open?
3. **Check console output** - what debug messages appear?
4. **Look for spawned pickups** - do they appear near the chest?

## Part 5: Debugging Dynamic Objects

### Step 9: Add Creation Tracking
Enhance your chest to track what it creates. Add this debug method:

```gdscript
func debug_spawned_items():
    """Print information about all spawned pickups."""
    print("=== CHEST DEBUG INFO ===")
    print("Chest opened: " + str(is_opened))
    print("Items spawned: " + str(spawned_pickups.size()))
    
    for i in range(spawned_pickups.size()):
        var pickup = spawned_pickups[i]
        if pickup and is_instance_valid(pickup):
            if pickup is Coin:
                print("- Coin " + str(i) + ": " + pickup.coin_type + " (" + str(pickup.gold_value) + " gold)")
            elif pickup is HealthPotion:
                print("- Potion " + str(i) + ": " + pickup.potion_type + " (" + str(pickup.heal_amount) + " HP)")
        else:
            print("- Item " + str(i) + ": No longer exists")
    
    print("======================")
```

### Step 10: Test Object Properties
Add this verification method:

```gdscript
func verify_spawned_items() -> bool:
    """Test that all spawned items have correct properties. Returns true if all valid."""
    var all_valid = true
    
    for pickup in spawned_pickups:
        if not is_instance_valid(pickup):
            print("❌ Invalid pickup found")
            all_valid = false
            continue
        
        # Test pickup-specific properties
        if pickup is Coin:
            var coin_valid = pickup.has_method("configure_coin_type")
            if not coin_valid:
                print("❌ Coin missing configuration method")
                all_valid = false
        elif pickup is HealthPotion:
            var potion_valid = pickup.has_method("configure_potion_type")
            if not potion_valid:
                print("❌ Potion missing configuration method")
                all_valid = false
    
    if all_valid:
        print("✅ All spawned items are valid")
    
    return all_valid
```

### Step 11: Add Debug Controls
In `scripts/game_world.gd`, add chest debugging:

```gdscript
# Add to _unhandled_input method:
if Input.is_action_just_pressed("ui_end"):  # End key
    var chests = get_tree().get_nodes_in_group("treasure_chests")  # Set this group
    for chest in chests:
        if chest.has_method("debug_spawned_items"):
            chest.debug_spawned_items()
        if chest.has_method("verify_spawned_items"):
            chest.verify_spawned_items()
```

## Part 6: Advanced Dynamic Creation

### Step 12: Create Multiple Chest Types
Create variations by setting different properties in the Inspector:

**Small Chest**:
- min_items: 1
- max_items: 2

**Large Chest**:  
- min_items: 4
- max_items: 7

**Treasure Hoard**:
- min_items: 8
- max_items: 12

### Step 13: Test Collection Management
1. **Create multiple chests** with different sizes
2. **Open each chest** and observe spawning
3. **Use End key** to debug all chests
4. **Collect some pickups** then debug again - what changed?

### Step 14: Advanced Spawning Features (Optional)
If you want to challenge yourself, add these features:

```gdscript
func spawn_rare_pickup() -> Node:
    """Spawn a rare pickup with enhanced properties."""
    # TODO: Create coin or potion with higher values
    # TODO: Maybe gold coin (100) or super potion (100 HP)
    pass

func spawn_pickup_cluster(center_pos: Vector2, count: int) -> Array:
    """Spawn multiple pickups in a cluster formation."""
    # TODO: Create multiple pickups arranged in a circle or pattern
    pass
```

## Part 7: Understanding Instance Management

### Step 15: Analyze Object Lifecycle
Now that you have dynamic creation working, examine the complete lifecycle:

1. **Creation**: `instantiate()` creates object from scene
2. **Configuration**: Properties are set after creation
3. **Scene Addition**: `add_child()` makes object active
4. **Runtime**: Object exists and functions normally
5. **Collection**: Player picks up item
6. **Cleanup**: `queue_free()` removes object from memory

**Management Questions:**
- How do you keep track of objects you created?
- What happens if you try to access an object after it's been collected?
- How can you verify all your created objects work correctly?

## Reflection Questions

Write down or discuss your answers:

1. **Creation vs Placement**: What are the advantages of creating objects from code versus placing them manually in scenes?

2. **Instance Management**: How do you keep track of multiple objects created from the same class? What challenges arise?

3. **Property Configuration**: When you create objects dynamically, how do you ensure they have the correct property values?

4. **Debugging Dynamic Objects**: What debugging strategies help when objects are created at runtime rather than design time?

5. **Memory Management**: What happens to objects you create when the player collects them or changes scenes?

6. **Scalability**: How would you manage a system that creates hundreds of pickup objects?

## Deliverables
By the end of this lesson, you should have:
- [ ] Working TreasureChest class that creates random pickups dynamically
- [ ] Understanding of scene instantiation with `preload()` and `instantiate()`
- [ ] Multiple chest variations that spawn different amounts of items
- [ ] Debugging methods to track and verify dynamically created objects
- [ ] Experience with managing collections of class instances
- [ ] Working pickup system where dynamically created items function correctly
- [ ] Understanding of object lifecycle from creation to cleanup

## Next Lesson Preview
In Lesson 1.6, we'll learn about **Class Inheritance and the Pickup Base Class** - you'll discover how to eliminate the code duplication between your Coin and HealthPotion classes by creating a shared Pickup parent class that both can inherit from!

**Big Revelation Coming**: You'll see how inheritance solves the repetitive code problem you've been experiencing and makes adding new pickup types much easier!

## Troubleshooting

**"Nothing spawns when I open the chest"**
- Check that you preloaded the scene files correctly
- Verify the paths to your scene files are correct
- Make sure you're calling `add_child()` on a valid parent node
- Check console for error messages about missing scenes

**"Spawned objects don't work like manually placed ones"**
- Verify you're setting the object's properties after instantiation
- Check that you're calling configuration methods if needed
- Make sure the spawned objects are being added to the scene tree

**"Can't track spawned objects"**
- Ensure you're adding created objects to your tracking array
- Use `is_instance_valid()` to check if objects still exist
- Check if objects are being freed when collected

**"Random generation not working"**
- Verify your random number ranges are correct
- Test with fixed values first, then add randomness
- Make sure you're using the right random functions (`randi()`, `randf()`, etc.)

**"Too many/too few items spawn"**
- Check your min_items and max_items values
- Verify the random range calculation is correct
- Debug by printing how many items should spawn vs. how many actually do

Amazing work! You've learned to create and manage objects dynamically - a crucial skill for any game developer! 📦✨