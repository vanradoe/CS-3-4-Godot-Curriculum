# Lesson 7: Static Typing & Code Quality

## Learning Objectives
By the end of this lesson, you will:
- Understand the difference between dynamic and static typing
- Apply strong typing practices to prevent bugs and improve code clarity
- Use custom enums to create readable, maintainable code
- Implement type hints for functions to catch errors before runtime
- Establish code style standards that scale to larger projects

## Getting Started

### Why Static Typing Matters
**Look at your current Player code** - you might see lines like:
```gdscript
var health = 100          # What type is this? int? float?
var damage = 15           # Could this accidentally become a string?
var character_name = "Hero" # What if someone assigns a number?
```

**The Problem**: Without explicit types, bugs can hide until runtime:
- Someone assigns a string to health: `health = "low"`
- Math operations fail: `health * 2` crashes
- Function parameters get wrong types: `take_damage("lots")`

**The Solution**: Static typing catches these errors immediately!

### Static vs Dynamic Typing
**Dynamic Typing** (what you might have been doing):
```gdscript
var health = 100          # Type inferred from value
var name = "Hero"         # Type inferred from value
```

**Static Typing** (what we'll do today):
```gdscript
var health: int = 100     # Explicitly an integer
var name: String = "Hero" # Explicitly a string
```

## Part 1: Converting to Static Types

### Step 1: Add Static Types to Player Properties
**Open** `scripts/player.gd` and let's convert your properties to use explicit types.

**Find your property declarations** and update them:

```gdscript
# Health System - Now with explicit types!
@export var max_health: int = 100
@export var current_health: int = 100

# Character Identity - Type-safe character info
@export var character_name: String = "Hero"
@export var level: int = 1

# Combat Stats - No more accidental type mixing
@export var damage: int = 15
@export var experience_points: int = 0

# Movement - Precise floating-point control
@export var move_speed: float = 200.0

# Internal state - typed for clarity
var facing: Vector2 = Vector2.ZERO
```

### Step 2: Add Function Type Hints
**Update your function signatures** to specify parameter and return types:

```gdscript
func take_damage(amount: int) -> void:
    print("Player taking " + str(amount) + " damage!")
    # ... rest of function stays the same

func heal(amount: int) -> void:
    print("Player healing " + str(amount) + " HP!")
    # ... rest of function stays the same

func gain_experience(amount: int) -> void:
    print("Player gained " + str(amount) + " experience!")
    # ... rest of function stays the same

func level_up() -> void:
    print("🎉 LEVEL UP! 🎉")
    # ... rest of function stays the same

func debug_gain_exp() -> void:
    """Debug method to test leveling - gives 50 exp"""
    gain_experience(50)
```

### Understanding Function Type Hints
**Function signature breakdown**:
```gdscript
func take_damage(amount: int) -> void:
#    ^function   ^param ^type  ^return type
```

- **Parameter type** (`amount: int`): What type this parameter expects
- **Return type** (`-> void`): What type this function returns
- **`void`**: Means "returns nothing" (like Python's `None`)

## Part 2: Custom Enums for Game States

### Step 3: Create Character States Enum
**Add this enum** at the top of your Player class (after `class_name Player`):

```gdscript
# Character state management - typed and readable
enum CharacterState {
    IDLE,
    MOVING,
    ATTACKING,
    DEAD,
    LEVEL_UP_ANIMATION
}

# Current state with explicit type
var current_state: CharacterState = CharacterState.IDLE
```

### Step 4: Use Enums in State Management
**Add state management** to your movement function:

```gdscript
func handle_movement() -> void:
    # Don't move if dead
    if current_state == CharacterState.DEAD:
        return
    
    # Get input direction from arrow keys
    var direction: Vector2 = Vector2.ZERO
    direction.x = Input.get_axis("ui_left", "ui_right")
    direction.y = Input.get_axis("ui_up", "ui_down")
    
    # Update state based on movement
    if direction == Vector2.ZERO:
        current_state = CharacterState.IDLE
    else:
        current_state = CharacterState.MOVING
    
    handle_sprite(direction)
    
    # Normalize diagonal movement to prevent speed boost
    if direction.length() > 0:
        direction = direction.normalized()
    
    # Apply movement using Godot's built-in physics
    velocity = direction * move_speed
    move_and_slide()
```

### Step 5: Update Die Function with State
**Modify your `die()` function** to use the state system:

```gdscript
func die() -> void:
    current_state = CharacterState.DEAD
    
    print("=== GAME OVER ===")
    print(character_name + " has fallen in battle!")
    print("Final Stats:")
    print("Level: " + str(level))
    print("Experience: " + str(experience_points))
    print("================")
    
    # Restart the scene
    get_tree().reload_current_scene()
```

## Part 3: Advanced Type Safety

### Step 6: Create Custom Type for Player Stats
**Add a custom data structure** for organized stats:

```gdscript
# Custom type for character statistics
class_name PlayerStats
extends Resource

@export var max_health: int = 100
@export var damage: int = 15
@export var move_speed: float = 200.0
@export var level: int = 1

func get_health_percentage() -> float:
    return float(current_health) / float(max_health) * 100.0

func apply_level_up_bonuses() -> void:
    max_health += 20
    damage += 5
```

### Step 7: Type-Safe Error Handling
**Add validation functions** with proper return types:

```gdscript
func can_take_damage(amount: int) -> bool:
    if amount < 0:
        print("Error: Damage amount cannot be negative!")
        return false
    if current_state == CharacterState.DEAD:
        print("Error: Cannot damage a dead character!")
        return false
    return true

func can_heal(amount: int) -> bool:
    if amount < 0:
        print("Error: Heal amount cannot be negative!")
        return false
    if current_health >= max_health:
        print("Info: Character is already at full health!")
        return false
    return true
```

### Step 8: Update Methods with Validation
**Modify your damage and healing functions** to use validation:

```gdscript
func take_damage(amount: int) -> bool:
    if not can_take_damage(amount):
        return false
    
    print("Player taking " + str(amount) + " damage!")
    
    # Reduce current health
    current_health -= amount
    if current_health < 0:
        current_health = 0
    
    # Display current status
    print("Player health: " + str(current_health) + "/" + str(max_health))
    
    # Check if player is defeated
    if current_health <= 0:
        print("💀 Player has been defeated!")
        die()
        return true
    else:
        # Calculate health percentage for feedback
        var health_percent: float = (float(current_health) / float(max_health)) * 100.0
        if health_percent <= 25.0:
            print("⚠️ Player is badly hurt!")
        elif health_percent <= 50.0:
            print("🤕 Player is injured!")
        return true

func heal(amount: int) -> bool:
    if not can_heal(amount):
        return false
    
    print("Player healing " + str(amount) + " HP!")
    
    # Store old health for comparison
    var old_health: int = current_health
    
    # Add health, but don't exceed maximum
    current_health += amount
    if current_health > max_health:
        current_health = max_health
    
    # Calculate actual healing done
    var actual_healing: int = current_health - old_health
    
    # Display results
    print("Player healed " + str(actual_healing) + " HP!")
    print("Player health: " + str(current_health) + "/" + str(max_health))
    
    # Special message if fully healed
    if current_health == max_health:
        print("✨ Player is fully healed!")
    
    return true
```

## Part 4: Code Style Standards

### Step 9: Establish Naming Conventions
**Apply consistent naming throughout your code**:

```gdscript
# Constants - SCREAMING_SNAKE_CASE
const MAX_LEVEL: int = 100
const BASE_EXP_REQUIREMENT: int = 100

# Variables - snake_case
var current_health: int = 100
var experience_points: int = 0

# Functions - snake_case
func take_damage(amount: int) -> bool:
func gain_experience(amount: int) -> void:

# Classes - PascalCase
class_name Player
class_name GameWorld

# Enums - PascalCase
enum CharacterState { IDLE, MOVING, ATTACKING }
```

### Step 10: Add Documentation Comments
**Document your functions** with proper descriptions:

```gdscript
## Applies damage to the character and handles death
## @param amount: The amount of damage to apply (must be positive)
## @return: true if damage was applied successfully, false if invalid
func take_damage(amount: int) -> bool:
    if not can_take_damage(amount):
        return false
    
    # ... function implementation

## Heals the character by the specified amount
## Will not exceed max_health
## @param amount: The amount of healing to apply (must be positive)
## @return: true if healing was applied, false if invalid or unnecessary
func heal(amount: int) -> bool:
    if not can_heal(amount):
        return false
    
    # ... function implementation

## Grants experience points and checks for level up
## Automatically triggers level_up() if enough experience is gained
## @param amount: Experience points to grant (must be positive)
func gain_experience(amount: int) -> void:
    if amount <= 0:
        print("Error: Experience amount must be positive!")
        return
    
    # ... function implementation
```

## Part 5: Testing Type Safety

### Step 11: Test Type Safety
**Try these experiments** to see how static typing helps:

1. **In your Player class, try adding this line temporarily**:
   ```gdscript
   # This should cause a type error!
   current_health = "low"  # String assigned to int variable
   ```

2. **Try calling a function with wrong types**:
   ```gdscript
   # This should cause a type error!
   take_damage("lots")  # String passed to int parameter
   ```

3. **Try assigning wrong enum values**:
   ```gdscript
   # This should cause a type error!
   current_state = "dead"  # String assigned to enum
   ```

**Remove these test lines** after seeing the errors they generate!

### Step 12: Add Type-Safe Debug Information
**Update your debug display** with proper typing:

```gdscript
func get_debug_info() -> String:
    var debug_text: String = ""
    debug_text += "=== PLAYER DEBUG INFO ===\n"
    debug_text += "Name: " + character_name + "\n"
    debug_text += "Health: " + str(current_health) + "/" + str(max_health) + "\n"
    debug_text += "Level: " + str(level) + "\n"
    debug_text += "Experience: " + str(experience_points) + "\n"
    debug_text += "Damage: " + str(damage) + "\n"
    debug_text += "State: " + CharacterState.keys()[current_state] + "\n"
    debug_text += "========================="
    return debug_text

func print_debug_info() -> void:
    print(get_debug_info())
```

## Deliverables
By the end of this lesson, you should have:
- [ ] All Player properties converted to explicit static types
- [ ] All Player methods using parameter and return type hints
- [ ] Custom CharacterState enum implemented and used
- [ ] Type-safe validation functions for damage and healing
- [ ] Consistent naming conventions throughout the code
- [ ] Documentation comments for all major functions
- [ ] Understanding of how static typing prevents runtime errors

## Next Lesson Preview - Data Structures & Collections
**In the next lesson**, we'll explore:
- **Arrays for inventories**: Type-safe item storage
- **Dictionaries for game data**: Player preferences, game settings
- **Custom data classes**: Complex game systems organization
- **Collection operations**: Searching, filtering, sorting game data

**The benefit**: More sophisticated game systems with better organization!

## Troubleshooting

**"I'm getting type errors everywhere!"**
- Check that all variable assignments match their declared types
- Make sure function calls pass the correct parameter types
- Verify that return statements match the function's return type

**"My enum isn't working"**
- Make sure the enum is declared inside the class
- Use the full enum name: `CharacterState.IDLE` not just `IDLE`
- Check that you're comparing enums with `==` not `=`

**"Type hints are confusing"**
- Start simple: just add types to variables first
- Then add parameter types: `func my_function(param: int)`
- Finally add return types: `func my_function(param: int) -> bool`

## Reflection Questions
1. **Error Prevention**: How many potential bugs did static typing help you catch?
2. **Code Clarity**: Is it easier to understand what functions do with type hints?
3. **IDE Support**: Does your code editor provide better autocomplete with types?
4. **Maintenance**: How much easier is it to modify typed code?
5. **Team Development**: How would static typing help when working with others?

**You're now writing more professional, maintainable code!** 🎯
