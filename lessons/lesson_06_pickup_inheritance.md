# Lesson 6: Pickup Inheritance - Refactoring Items

## Learning Objectives
By the end of this lesson, you will:
- Apply inheritance to a completely different system (pickups instead of characters)
- Refactor existing code into an inheritance hierarchy without breaking functionality
- Recognize inheritance patterns in various game systems
- Create multiple pickup types rapidly using a base class
- Experience how inheritance makes game systems more scalable and maintainable

## Getting Started

### The Inheritance Pattern Recognition
**You've learned inheritance** with characters:
- Character → Player, Enemy, NPC

**Today's challenge**: Apply the same pattern to **pickup items**:
- Pickup → HealthPotion, Coin, ExperienceGem, PowerUp

**The Goal**: Transform your single health potion script into a flexible pickup system that can handle any type of collectable item!

### What We're Refactoring
**Look at your current** `scripts/health_potion.gd` - it works great for healing, but what if you want:
- **Coins** that give currency
- **Experience gems** that give XP
- **Power-ups** that temporarily boost stats
- **Keys** that unlock doors

**The Problem**: You'd copy the collision detection, pickup logic, and area setup over and over (sound familiar from Lesson 3?).

**The Solution**: Create a **Pickup** base class with shared functionality, then inherit from it!

## Part 1: Analyzing the Existing Code

### Step 1: Understand What's Shared vs Unique
**Open** `scripts/health_potion.gd` and identify:

**Shared Pickup Behavior** (all items need this):
- ✅ Extends Area2D for collision detection
- ✅ Connects to body_entered signal  
- ✅ Checks if colliding body is Player
- ✅ Has auto_pickup functionality
- ✅ Removes itself after pickup (queue_free)
- ✅ Prints pickup messages

**Unique HealthPotion Behavior** (only healing items need this):
- ❌ heal_amount property
- ❌ Calls player.heal() method
- ❌ Healing-specific messages

**Inheritance Planning**: Which parts should go in the Pickup base class?

### Step 2: Design the Pickup Inheritance System
**Before coding**, plan the structure:

```
Area2D (Godot's built-in class)
    ↑
Pickup (our base class - shared pickup behavior)
    ↑         ↑           ↑          ↑
HealthPotion  Coin  ExperienceGem  PowerUp
```

**Each pickup type** gets collision detection, player checking, and auto-pickup for free!

## Part 2: Creating the Pickup Base Class

### Step 3: Create the Pickup Base Class
1. **Create** a new script: `scripts/pickup.gd`
2. **Start with** the inheritance foundation:

```gdscript
extends Area2D
class_name Pickup

# Base pickup properties - all pickups need these
@export var auto_pickup: bool = true
@export var pickup_sound: String = ""  # For future sound effects

func _ready():
    print("Pickup created: " + get_script().get_global_name())
    # Connect the collision signal
    body_entered.connect(_on_body_entered)
    
    # Call child class setup
    setup_pickup()

# Base collision handling - all pickups use this
func _on_body_entered(body):
    # Check if it's the player
    if body is Player:
        print("Player found " + get_pickup_name() + "!")
        
        # Let the child class handle the specific pickup effect
        if can_pickup(body):
            apply_pickup_effect(body)
            
            # Play pickup sound (future feature)
            if pickup_sound != "":
                print("*" + pickup_sound + " sound effect*")
            
            # Remove the pickup after use
            if auto_pickup:
                print(get_pickup_name() + " consumed!")
                queue_free()

# Methods that child classes MUST override (abstract methods)
func get_pickup_name() -> String:
    return "Unknown Pickup"  # Child classes should override this

func apply_pickup_effect(player: Player):
    print("Base pickup effect - this should be overridden!")

# Methods that child classes CAN override (virtual methods)  
func can_pickup(player: Player) -> bool:
    return true  # Default: any player can pick up any item

func setup_pickup():
    pass  # Default: no special setup needed
```

**Understanding the Pattern**: 
- **Base class** handles collision detection and pickup flow
- **Child classes** customize the pickup name and effects
- **Polymorphism**: Same pickup code works for all item types!

### Step 4: Test the Base Class
**Save** your `pickup.gd` file and make sure it compiles without errors before continuing.

## Part 3: Converting HealthPotion to Use Inheritance

### Step 5: Backup and Refactor HealthPotion
1. **Copy** `scripts/health_potion.gd` to `scripts/health_potion_backup.gd` (just in case)
2. **Open** `scripts/health_potion.gd` for refactoring

### Step 6: Refactor HealthPotion to Inherit from Pickup
**Replace** your entire `health_potion.gd` with this refactored version:

```gdscript
extends Pickup  # ← The magic inheritance line!
class_name HealthPotion

# HealthPotion-specific properties
@export var heal_amount: int = 30

# Override: What should this pickup be called?
func get_pickup_name() -> String:
    return "Health Potion"

# Override: Set up HealthPotion-specific properties
func setup_pickup():
    print("Health Potion setup - heals " + str(heal_amount) + " HP")

# Override: Can this player pick up this health potion?
func can_pickup(player: Player) -> bool:
    # Only allow pickup if player has heal method and isn't at full health
    if not player.has_method("heal"):
        print("Player doesn't have heal() method yet!")
        return false
    
    if player.current_health >= player.max_health:
        print("Player is already at full health!")
        return false
    
    return true

# Override: Apply the healing effect
func apply_pickup_effect(player: Player):
    player.heal(heal_amount)
    print("Player healed for " + str(heal_amount) + " HP!")
```

**The Magic**: HealthPotion is now **much shorter** but has **the same functionality**!

### Step 7: Test the Refactored HealthPotion
1. **Save** all files
2. **Run the game**
3. **Test the health potion**:
   - Does it still heal the player?
   - Does it still disappear after use?
   - Are the messages still clear and helpful?

**If everything works the same**, your refactoring was successful! 🎉

## Part 4: Creating New Pickup Types

### Step 8: Create a Coin Pickup
**Now for the fun part** - creating new pickup types is super easy with inheritance!

**Create** `scripts/coin.gd`:

```gdscript
extends Pickup
class_name Coin

# Coin-specific properties
@export var coin_value: int = 10

# Override: What should this pickup be called?
func get_pickup_name() -> String:
    return "Gold Coin"

# Override: Set up Coin-specific properties  
func setup_pickup():
    print("Coin created - worth " + str(coin_value) + " gold")

# Override: Apply the coin collection effect
func apply_pickup_effect(player: Player):
    # Add currency to player (we'll need to add this property to Player)
    if player.has_method("add_currency"):
        player.add_currency(coin_value)
        print("Player gained " + str(coin_value) + " gold!")
    else:
        print("Player needs add_currency() method - let's add it!")
        # For now, just show the collection
        print("*Collected " + str(coin_value) + " gold coins*")
```

**Challenge**: How many lines is this compared to if you had to write collision detection from scratch?

### Step 9: Add Currency System to Player
**Quick enhancement** - let's add currency to the Player class so coins actually work:

**Open** `scripts/player.gd` and add these additions:

```gdscript
# Add this property with your other character properties in _ready():
# (This goes in the _ready() method where you set other values)
var currency: int = 0

# Add this method anywhere in your Player class:
func add_currency(amount: int):
    currency += amount
    print(character_name + " now has " + str(currency) + " gold!")

# Add this to your debug controls (if you have them)
func debug_show_currency():
    print("Current gold: " + str(currency))
```

### Step 10: Create an Experience Gem Pickup
**Create** `scripts/experience_gem.gd`:

```gdscript
extends Pickup
class_name ExperienceGem

# ExperienceGem-specific properties
@export var exp_value: int = 25

# Override: What should this pickup be called?
func get_pickup_name() -> String:
    return "Experience Gem"

# Override: Set up ExperienceGem-specific properties
func setup_pickup():
    print("Experience Gem created - gives " + str(exp_value) + " XP")

# Override: Apply the experience boost effect  
func apply_pickup_effect(player: Player):
    if player.has_method("gain_experience"):
        player.gain_experience(exp_value)
        print("Player gained " + str(exp_value) + " experience!")
    else:
        print("Player needs gain_experience() method!")
        print("*Gained " + str(exp_value) + " experience points*")
```

**Pattern Recognition**: Notice how similar the structure is? That's inheritance working!

## Part 5: Testing Your Pickup System

### Step 11: Create Pickup Scenes
**For each pickup type**, create a scene:

**Coin Scene** (`scenes/coin.tscn`):
1. **Root node**: Area2D
2. **Add**: CollisionShape2D (CircleShape2D)
3. **Add**: ColorRect or Sprite2D (make it yellow/gold colored)
4. **Attach**: `coin.gd` script
5. **Save** scene

**Experience Gem Scene** (`scenes/experience_gem.tscn`):
1. **Root node**: Area2D
2. **Add**: CollisionShape2D (CircleShape2D)  
3. **Add**: ColorRect or Sprite2D (make it blue/purple colored)
4. **Attach**: `experience_gem.gd` script
5. **Save** scene

### Step 12: Add Pickups to Game World
1. **Open** `scenes/main.tscn`
2. **Instance** Coin and ExperienceGem scenes
3. **Position them** around the world
4. **Run the game** and test all pickup types:
   - HealthPotion (should work the same as before)
   - Coin (should give currency)
   - ExperienceGem (should give experience)

## Part 6: Advanced Pickup Types

### Challenge: Create a PowerUp Pickup
**Try creating** a temporary power-up that boosts player damage:

```gdscript
extends Pickup
class_name PowerUp

@export var damage_boost: int = 10
@export var duration: float = 10.0

func get_pickup_name() -> String:
    return "Power Crystal"

func setup_pickup():
    print("Power Crystal created - +" + str(damage_boost) + " damage for " + str(duration) + "s")

func apply_pickup_effect(player: Player):
    print("Player gains temporary power boost!")
    # Apply damage boost (you'll need to implement this in Player)
    # player.apply_temporary_damage_boost(damage_boost, duration)
    print("*+" + str(damage_boost) + " damage for " + str(duration) + " seconds*")
```

### Challenge: Create a Key Pickup
**Design a key** that unlocks doors (foundation for future lessons):

```gdscript
extends Pickup
class_name Key

@export var key_id: String = "red_key"

func get_pickup_name() -> String:
    return key_id.capitalize() + " Key"

func apply_pickup_effect(player: Player):
    print("Player obtained " + get_pickup_name() + "!")
    # Add key to player inventory (future implementation)
    # player.add_key(key_id)
```

## Part 7: Inheritance System Benefits

### Code Comparison Analysis
**Before inheritance** (what you would have had):
- HealthPotion: ~40 lines
- Coin: ~40 lines (copying collision code)
- ExperienceGem: ~40 lines (copying collision code)
- **Total**: 120 lines with lots of duplication

**After inheritance** (what you have now):
- Pickup: ~45 lines (base functionality)
- HealthPotion: ~25 lines (unique code only)
- Coin: ~20 lines (unique code only)
- ExperienceGem: ~20 lines (unique code only)
- **Total**: 110 lines with zero duplication

### Maintenance Benefits
**Test this**: Change the pickup message format in `pickup.gd`:

1. **Open** `scripts/pickup.gd`
2. **Find** the line: `print("Player found " + get_pickup_name() + "!")`
3. **Change** it to: `print(">>> COLLECTED: " + get_pickup_name() + " <<<")`
4. **Save** and **run the game**
5. **Test all pickup types** - they ALL use the new message format automatically!

**Before inheritance**: You'd have to update this in 3+ different files!

### Scalability Benefits
**Add a new pickup type** in under 5 minutes:

```gdscript
extends Pickup
class_name MagicScroll

@export var spell_name: String = "Fireball"

func get_pickup_name() -> String:
    return spell_name + " Scroll"

func apply_pickup_effect(player: Player):
    print("Player learned " + spell_name + " spell!")
    # Future: player.learn_spell(spell_name)
```

**That's it!** Full collision detection, pickup logic, and cleanup for free!

## Part 8: Understanding Pickup Inheritance

### Key Concepts Reinforced
- **Base Class** (Pickup): Common pickup behavior
- **Derived Classes** (HealthPotion, Coin, etc.): Specific pickup effects
- **Method Overriding**: Each pickup type customizes `apply_pickup_effect()`
- **Polymorphism**: Same pickup system works for all item types

### Inheritance Hierarchy
```
Area2D (Godot's built-in class)
    ↑
Pickup (collision detection, auto-pickup, player checking)
    ↑         ↑           ↑          ↑
HealthPotion  Coin  ExperienceGem  PowerUp
```

### Abstract vs Virtual Methods
**Abstract methods** (child MUST override):
- `get_pickup_name()` - each pickup needs a unique name
- `apply_pickup_effect()` - each pickup does something different

**Virtual methods** (child CAN override):
- `can_pickup()` - most pickups work for any player
- `setup_pickup()` - most pickups need no special setup

## Deliverables
By the end of this lesson, you should have:
- [ ] A Pickup base class with shared pickup functionality
- [ ] HealthPotion refactored to inherit from Pickup (same functionality, less code)
- [ ] Coin class that gives currency to players
- [ ] ExperienceGem class that gives XP to players
- [ ] At least one additional pickup type (PowerUp, Key, MagicScroll)
- [ ] Working pickup scenes that can be placed in game world
- [ ] Currency system added to Player class
- [ ] Understanding of how inheritance applies to different game systems

## Next Lesson Preview - Advanced Pickup Features!
**In the next lesson**, we'll enhance our pickup system with:
- **Rarity system** (common, rare, epic pickups)
- **Conditional pickups** (keys that only work on specific doors)
- **Pickup effects** (particle systems, sound effects)
- **Inventory management** (pickups that go into inventory instead of immediate use)

**The best part**: All these features will be added to the Pickup base class, so ALL pickup types get them automatically!

## Reflection Questions
Write down or discuss:

1. **Pattern Recognition**: How was pickup inheritance similar to character inheritance?
2. **Code Quality**: How much less code did you write compared to duplicating collision logic?
3. **Maintenance**: How easy was it to change pickup behavior for ALL pickup types?
4. **Scalability**: How quickly could you create new pickup types now?
5. **System Thinking**: What other game systems might benefit from inheritance? (UI elements? Weapons? Spells?)

## Troubleshooting

**"HealthPotion doesn't work after refactoring"**
- Check that pickup.gd compiles without errors first
- Verify HealthPotion extends Pickup (not Area2D)
- Make sure you're calling the parent methods correctly

**"New pickup types don't detect collisions"**
- Verify the scene has Area2D as root with CollisionShape2D child
- Check that the script extends Pickup
- Make sure collision layers/masks are set correctly

**"Pickup effects aren't working"**
- Check that Player class has the required methods (heal, add_currency, gain_experience)
- Verify method names match exactly
- Look for error messages in the console

**"I don't understand method overriding"**
- Review how HealthPotion overrides apply_pickup_effect()
- Each pickup type provides its own version of what happens when picked up
- The base class calls the override method automatically

## The Growing Mastery
**You've now applied inheritance to**:
- ✅ Character system (Player, Enemy, NPC)
- ✅ Pickup system (HealthPotion, Coin, ExperienceGem)

**You understand**:
- ✅ How inheritance eliminates code duplication
- ✅ How base classes provide shared functionality
- ✅ How derived classes customize behavior through overriding
- ✅ How the same pattern applies to different game systems

**You're thinking like a professional game developer!** 🎮
