# Lesson 1.6: Identifying Code Duplication and Base Class Design

## Learning Objectives
By the end of this lesson, you will:
- Systematically identify duplicated code between similar classes
- Understand the problems that code duplication creates for maintenance
- Design a base class that contains shared functionality
- Experience the "code smell" that leads developers to seek better solutions
- Prepare for implementing inheritance to solve duplication problems

## What We're Discovering
Today we're **analyzing the duplication** between your Coin and HealthPotion classes. You'll experience firsthand why code duplication is problematic and design a solution using a shared base class called Pickup.

## Part 1: Duplication Investigation

### Step 1: Side-by-Side Code Analysis
Let's systematically examine what code is repeated between your classes:

1. **Open** `scripts/coin.gd` and `scripts/health_potion.gd` in separate windows
2. **Arrange them side by side** so you can compare easily
3. **Read through both files** line by line
4. **Make a list** of everything that looks similar or identical

### Step 2: Property Comparison
Create a comparison chart of properties:

**Coin Properties:**
- `@export var gold_value: int`
- `@export var auto_pickup: bool`  
- `@export var coin_type: String`

**HealthPotion Properties:**
- `@export var heal_amount: int`
- `@export var auto_pickup: bool`
- `@export var potion_type: String`

**Duplication Questions:**
- Which properties appear in both classes?
- Which properties are unique to each class?
- What pattern do you see in the property names?

### Step 3: Method Structure Analysis
Compare the methods between both classes:

**Similar Method Patterns:**
- Both have `_ready()` methods that print debug info
- Both connect collision signals in `_ready()`
- Both have `_on_body_entered()` methods that check for Player
- Both have configuration methods (`configure_coin_type()` vs `configure_potion_type()`)
- Both validate player methods before calling them

**Code Comparison Exercise:**
Look at these method signatures and identify what's identical vs. what's different:

```gdscript
# Coin class
func configure_coin_type() -> bool:
func _on_body_entered(body):

# HealthPotion class  
func configure_potion_type() -> bool:
func _on_body_entered(body):
```

## Part 2: Understanding the Duplication Problem

### Documentation: The Cost of Code Duplication
Here's why code duplication becomes problematic:

```gdscript
# Example: Two classes with duplicated validation logic
extends Node
class_name Sword

@export var durability: int = 100
@export var auto_repair: bool = false

func validate_durability() -> bool:
    if durability < 0:
        print("⚠️ Invalid durability: " + str(durability))
        durability = 0
        return false
    if durability > 100:
        print("⚠️ Durability too high: " + str(durability))  
        durability = 100
        return false
    return true

extends Node
class_name Shield

@export var durability: int = 100
@export var auto_repair: bool = false

func validate_durability() -> bool:
    if durability < 0:
        print("⚠️ Invalid durability: " + str(durability))
        durability = 0
        return false
    if durability > 100:
        print("⚠️ Durability too high: " + str(durability))
        durability = 100  
        return false
    return true
```

**Problems with This Duplication:**
1. **Bug Multiplication**: If there's a bug in validation, you must fix it in multiple places
2. **Maintenance Nightmare**: Changing validation logic requires updating every class
3. **Inconsistency Risk**: Easy to update one class but forget the others
4. **Testing Complexity**: Must test the same logic in multiple classes
5. **Code Bloat**: More lines of code without adding functionality

### Step 4: Calculate Your Duplication
Count the duplication in your classes:

1. **Count similar lines** between Coin and HealthPotion
2. **Estimate percentage** - what percent of each class is duplicated?
3. **List specific duplications**:
   - Property declarations that are nearly identical
   - Method structures that follow the same pattern
   - Validation and error handling code
   - Player interaction patterns

**Duplication Reality Check:**
- If you wanted to add a new pickup type (like MagicScroll), how much code would you copy?
- If you found a bug in the player detection logic, how many files would you need to fix?
- How confident are you that both classes handle edge cases identically?

## Part 3: Designing the Solution

### Step 5: Identify Common Elements
Based on your analysis, identify what should be shared:

**Shared Properties (appear in both classes):**
```gdscript
# These exist in both Coin and HealthPotion:
@export var auto_pickup: bool = true
# Both classes extend Area2D
# Both classes have some kind of "type" property
# Both classes have some kind of "value" property
```

**Shared Methods (similar structure in both):**
```gdscript
# Both classes have methods like this:
func _ready()  # Sets up the object and connects signals
func _on_body_entered(body)  # Handles player collision
func configure_type() -> bool  # Sets values based on type
# Both validate player has required methods
```

### Step 6: Design Base Class Structure  
Design a Pickup base class that contains the common elements:

```gdscript
# Proposed Pickup base class design:
extends Area2D
class_name Pickup

# TODO: What properties should ALL pickups have?
# Think about what Coin and HealthPotion both need

# TODO: What methods should ALL pickups have?  
# Think about what behavior is shared

# TODO: How should subclasses customize behavior?
# Think about what's different between coins and potions
```

**Design Questions:**
- What properties does every pickup need regardless of type?
- What methods should every pickup have?
- How can subclasses (Coin, HealthPotion) add their specific behavior?
- What should the base class do vs. what should subclasses do?

### Step 7: Plan the Inheritance Hierarchy
Sketch out the class relationships:

```
Pickup (base class)
├── Common properties: auto_pickup, pickup_type
├── Common methods: _ready(), _on_body_entered()
├── Abstract methods: apply_effect(), get_debug_info()
│
├── Coin (inherits from Pickup)
│   ├── Unique properties: gold_value, coin_type  
│   └── Implements: apply_effect() to give gold
│
└── HealthPotion (inherits from Pickup)
    ├── Unique properties: heal_amount, potion_type
    └── Implements: apply_effect() to heal player
```

## Part 4: Testing Your Understanding

### Step 8: Predict Inheritance Benefits
Before implementing, predict what inheritance will solve:

**Maintenance Predictions:**
- If you fix a bug in player detection, how many files will you need to change with inheritance?
- If you want to add a new pickup type, how much code will you need to write?
- If you change how auto_pickup works, where will you make the change?

### Step 9: Create Base Class Stub
Create the beginning of your base class in `scripts/pickup.gd`:

```gdscript
extends Area2D
class_name Pickup

# TODO: Add properties that ALL pickups need
# Consider: auto_pickup, pickup_type, some kind of value

# TODO: Add methods that ALL pickups need
# Consider: _ready(), _on_body_entered(), debug methods

func _ready():
    # TODO: What setup does EVERY pickup need?
    # Print debug info, connect signals, etc.
    pass

func _on_body_entered(body):
    # TODO: What should happen when ANY pickup is touched?
    # Check for player, validate, call specific pickup effect
    pass

func apply_pickup_effect(player: Player) -> bool:
    # TODO: This will be overridden by subclasses
    # Each pickup type implements its own effect
    print("⚠️ Base pickup effect - this should be overridden!")
    return false

func get_pickup_info() -> String:
    # TODO: Return debug information about this pickup
    # Subclasses can override to add specific info
    return "Generic pickup"
```

**Design Challenge:** Don't implement everything yet - just create the structure!

## Part 5: Understanding the Inheritance Concept

### Documentation: Inheritance Fundamentals
Here's how inheritance works in programming:

```gdscript
# Example: Vehicle inheritance hierarchy
extends Node
class_name Vehicle

@export var speed: float = 100.0
@export var fuel: float = 50.0

func move_forward():
    print("Moving at " + str(speed) + " speed")
    fuel -= 1.0

func get_info() -> String:
    return "Vehicle - Speed: " + str(speed) + ", Fuel: " + str(fuel)

# Car inherits from Vehicle
extends Vehicle
class_name Car

@export var doors: int = 4

func honk_horn():
    print("Beep beep!")

func get_info() -> String:
    # Override parent method to add car-specific info
    return super() + ", Doors: " + str(doors)

# Boat inherits from Vehicle  
extends Vehicle
class_name Boat

@export var anchors: int = 1

func drop_anchor():
    print("Anchor dropped!")

func get_info() -> String:
    return super() + ", Anchors: " + str(anchors)
```

**Key Inheritance Concepts:**
- **Base Class**: Defines common properties and methods (Vehicle)
- **Derived Classes**: Inherit common features and add specific ones (Car, Boat)
- **Code Reuse**: Common functionality written once in base class
- **Polymorphism**: Can treat Car and Boat as Vehicle when needed
- **Override**: Subclasses can customize inherited methods
- **super()**: Call parent class method from overridden method

## Part 6: Preparing for Implementation

### Step 10: Plan the Refactoring Steps
Plan how you'll convert your existing classes to use inheritance:

**Phase 1: Create Base Class**
1. Implement Pickup base class with shared functionality
2. Test that it compiles and basic structure works

**Phase 2: Convert Coin Class**  
1. Change `extends Area2D` to `extends Pickup`
2. Move duplicated code to base class
3. Keep coin-specific functionality in Coin class

**Phase 3: Convert HealthPotion Class**
1. Change `extends Area2D` to `extends Pickup`  
2. Remove duplicated code (now inherited from Pickup)
3. Keep potion-specific functionality in HealthPotion class

**Phase 4: Test Everything**
1. Verify both pickup types still work
2. Test that shared functionality works correctly  
3. Confirm no functionality was lost in the conversion

### Step 11: Document Current Behavior
Before making changes, document how your pickups currently work:

1. **Test each pickup type** and record what happens
2. **Document the console output** from each pickup
3. **List all current functionality** that must still work after inheritance
4. **Create a checklist** to verify nothing breaks during refactoring

**Pre-Inheritance Checklist:**
- [ ] Coins give correct gold amounts based on type
- [ ] Potions heal correct amounts based on type
- [ ] Both types handle invalid types appropriately
- [ ] Player interaction works for both types
- [ ] Debug information prints correctly
- [ ] Auto_pickup functionality works
- [ ] Dynamically created pickups work correctly

## Reflection Questions

Write down or discuss your answers:

1. **Duplication Problems**: What specific problems did you identify with the duplicated code between Coin and HealthPotion?

2. **Maintenance Difficulty**: If you had to change how player detection works, how many files would you need to modify currently?

3. **Base Class Design**: What properties and methods do you think should go in the Pickup base class vs. the specific subclasses?

4. **Inheritance Benefits**: What benefits do you expect inheritance to provide for your pickup system?

5. **Testing Concerns**: What are you worried about when converting existing working code to use inheritance?

6. **Future Expansion**: How would inheritance make it easier to add new pickup types like MagicScroll or PowerUpItem?

## Deliverables
By the end of this lesson, you should have:
- [ ] Completed side-by-side analysis of Coin and HealthPotion duplication
- [ ] Documented specific duplicated properties and methods
- [ ] Created a duplication percentage estimate 
- [ ] Designed the structure for a Pickup base class
- [ ] Created a stub Pickup class with planned method signatures
- [ ] Documented current pickup behavior to preserve during refactoring
- [ ] Understanding of inheritance concepts and benefits
- [ ] Plan for converting existing classes to use inheritance

## Next Lesson Preview
In Lesson 2.1, we'll **implement the Pickup base class** and convert your Coin class to inherit from it! You'll see inheritance in action and experience how it eliminates code duplication while preserving all functionality.

**Exciting Transformation Coming**: You'll convert working classes to use inheritance and see the duplicated code disappear while everything still works perfectly!

## Troubleshooting

**"I can't see much duplication"**
- Compare method by method, line by line
- Look for similar patterns even if variable names are different  
- Focus on structure and logic flow, not just identical text
- Consider the player interaction patterns in both classes

**"Designing the base class seems hard"**
- Start with what's obviously identical between classes
- Focus on the most common properties first
- Don't worry about getting it perfect - it can be refined
- Think about what EVERY pickup needs, not what might be useful

**"I'm worried about breaking existing code"**
- This is a valid concern and shows good development instincts
- Document current behavior thoroughly before changing anything
- Plan to make small, testable changes rather than big rewrites
- Remember you can always revert changes if something breaks

**"The inheritance concept is confusing"**
- Focus on the practical benefits: less duplicated code
- Think of it as moving shared code to a common parent
- Don't worry about understanding everything at once
- The next lesson will make it more concrete with actual implementation

Excellent analysis work! You've identified the problem that inheritance solves and planned the solution. 🔍✨