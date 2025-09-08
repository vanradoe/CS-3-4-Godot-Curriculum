# Lesson 2.1: Implementing Pickup Base Class

## Learning Objectives
By the end of this lesson, you will:
- Create your first base class with shared functionality
- Understand how to design methods that will be overridden by subclasses
- Implement common pickup behaviors that all pickups will share
- Experience the foundation of inheritance before refactoring existing code

## What We're Building
Today we're **creating the Pickup base class** that you designed in Lesson 1.6. This will contain all the shared functionality between coins, potions, and future pickups. You'll build this class step-by-step, using your existing coin code as a reference guide.

## Part 1: Code Investigation

### Step 1: Review Your Design
Look back at your Pickup base class design from Lesson 1.6:

1. **Open** the stub `scripts/pickup.gd` file you created (if it doesn't exist, create it)
2. **Review** your notes about what properties and methods should be shared
3. **Look at** your existing `scripts/health_potion.gd` as a reference for common patterns

### Step 2: Analyze Coin Implementation
Let's examine a coin implementation as our reference. Here's what a typical coin class looks like:

```gdscript
extends Area2D
class_name Coin

@export var gold_value: int = 10
@export var auto_pickup: bool = true
@export var coin_type: String = "copper"

func _ready():
    print("🪙 Coin created - Type: " + coin_type + ", Value: " + str(gold_value))
    body_entered.connect(_on_body_entered)
    
func _on_body_entered(body):
    if body is Player:
        print("🎯 Player touched coin!")
        
        if not body.has_method("add_gold"):
            print("⚠️ Player missing add_gold method!")
            return
            
        var pickup_successful: bool = body.add_gold(gold_value)
        if pickup_successful:
            print("✅ Player gained " + str(gold_value) + " gold")
            queue_free()
        else:
            print("❌ Pickup failed")
            
func configure_coin_type() -> bool:
    match coin_type.to_lower():
        "copper":
            gold_value = 10
            return true
        "silver": 
            gold_value = 25
            return true
        "gold":
            gold_value = 50
            return true
        _:
            print("⚠️ Unknown coin type: " + coin_type)
            gold_value = 1
            return false
```

### Step 3: Identify Common Patterns
Compare this coin code with your `health_potion.gd`:

**Common Pattern Questions:**
- What parts of the `_ready()` method are identical?
- What parts of `_on_body_entered()` follow the same structure?
- What kind of validation happens in both classes?
- What properties appear in both classes?

## Part 2: Understanding Base Class Design

### Documentation: Base Class Principles

A base class should contain:

```gdscript
# Example of a well-designed base class
extends Area2D
class_name Item

# Properties that ALL items have
@export var item_name: String = "Generic Item"
@export var auto_pickup: bool = true
@export var pickup_sound: String = "pickup"

# Methods that ALL items need
func _ready():
    # Common setup for all items
    body_entered.connect(_on_body_entered)
    print("📦 Item created: " + item_name)

func _on_body_entered(body):
    # Common collision logic
    if body is Player:
        apply_item_effect(body)

# Method that subclasses MUST implement  
func apply_item_effect(player: Player) -> bool:
    # This is "abstract" - subclasses override it
    print("⚠️ Base item effect - override this!")
    return false
    
# Method that subclasses CAN customize
func get_item_info() -> String:
    return "Item: " + item_name
```

**Key Concepts:**
- **Shared Properties**: Things every subclass needs
- **Shared Methods**: Behavior that's identical across all subclasses  
- **Abstract Methods**: Methods that subclasses must implement differently
- **Virtual Methods**: Methods subclasses can override if needed

## Part 3: Building the Pickup Base Class

### Step 4: Create the Base Class Structure
Create or update `scripts/pickup.gd` with the basic structure:

```gdscript
extends Area2D
class_name Pickup

# TODO: Add properties that ALL pickups need
# Look at coin example: what properties do coin and potion both have?
# Think about: auto_pickup, some kind of type/name, debug info

# TODO: Add any other shared properties you identified in Lesson 1.6

func _ready():
    # TODO: Add setup that EVERY pickup needs
    # Look at coin example: what happens in _ready() for all pickups?
    # Think about: connecting signals, printing debug info
    pass

func _on_body_entered(body):
    # TODO: Add collision logic that ALL pickups share
    # Look at coin example: what validation happens for all pickups?
    # Think about: checking if body is Player, calling pickup effect
    pass

func apply_pickup_effect(player: Player) -> bool:
    # TODO: This method will be overridden by subclasses
    # Each pickup type (coin, potion, etc.) implements its own effect
    # For now, just print a warning that this should be overridden
    return false

func get_pickup_info() -> String:
    # TODO: Return debug information about this pickup
    # Subclasses can override this to add specific info
    # For now, return basic info that works for any pickup
    return "Generic pickup"
```

### Step 5: Implement Shared Properties
Based on your analysis of coin and potion classes, add shared properties:

```gdscript
# TODO: Look at both coin and potion classes
# What properties appear in both? Add them here.

# Hint: Both classes have:
# - Some kind of auto_pickup boolean
# - Some kind of type string (coin_type, potion_type)
# - Both extend Area2D

# TODO: Add @export var declarations for shared properties
# Use names that make sense for ANY pickup, not just coins or potions
```

### Step 6: Implement the _ready() Method
Fill in the `_ready()` method with shared initialization:

```gdscript
func _ready():
    # TODO: Connect the collision signal
    # Look at coin example: what signal gets connected?
    
    # TODO: Print debug information
    # Create debug output that works for any pickup type
    # Use get_pickup_info() to get the specific info
    
    # TODO: Call any setup methods that all pickups need
    # Look at your design from Lesson 1.6
    pass
```

### Step 7: Implement Collision Detection
Fill in the `_on_body_entered()` method:

```gdscript
func _on_body_entered(body):
    # TODO: Check if the collision is with a Player
    # Look at coin example: how is this validated?
    
    # TODO: Call the pickup effect method
    # This should call apply_pickup_effect() and handle the result
    
    # TODO: Handle successful pickup
    # What should happen if apply_pickup_effect() returns true?
    
    # TODO: Handle failed pickup  
    # What should happen if apply_pickup_effect() returns false?
    pass
```

### Step 8: Implement get_pickup_info() Method
Create a method that provides debug information:

```gdscript
func get_pickup_info() -> String:
    # TODO: Return a string with basic pickup information
    # This should work for any pickup type
    # Include information that all pickups have in common
    # Subclasses can override this to add specific details
    return "TODO: Add basic pickup info"
```

## Part 4: Testing the Base Class

### Step 9: Create a Test Instance
To test your base class, create a simple test instance:

```gdscript
# TODO: In your game world or test scene, try creating a Pickup instance
# Add this temporarily to test your base class:

func test_pickup_base_class():
    var test_pickup = Pickup.new()
    print("Testing pickup info: " + test_pickup.get_pickup_info())
    
    # TODO: Add more tests for your base class methods
    # What should you test to make sure your base class works?
```

### Step 10: Predict Behavior
Before running your code, predict what will happen:

**Prediction Questions:**
- What will happen when you create a Pickup instance?
- What will the `get_pickup_info()` method return?
- What will happen if a Player touches a base Pickup?
- What error messages might you see?

### Step 11: Test and Debug
Run your game and test the base class:

1. **Create a pickup instance** and see what debug output appears
2. **Test the collision detection** - what happens when the player touches it?
3. **Check the console output** - do you see the expected messages?
4. **Look for errors** - what needs to be fixed?

**Common Issues to Debug:**
- Missing signal connections
- Incorrect method signatures
- Properties not properly initialized
- Abstract methods not properly implemented

## Part 5: Understanding Virtual Methods

### Documentation: Virtual vs Abstract Methods

```gdscript
# Example showing different types of methods in base classes

extends Node
class_name GameEntity

# Concrete method - all subclasses use exactly this implementation
func get_position() -> Vector2:
    return global_position

# Virtual method - subclasses CAN override, but don't have to
func get_display_name() -> String:
    return "Generic Entity"
    
# Abstract method - subclasses MUST override this
func update_behavior(delta: float) -> void:
    print("⚠️ update_behavior not implemented - override in subclass!")
```

**In Your Pickup Class:**
- Which methods should be concrete (same for all pickups)?
- Which methods should be virtual (subclasses can customize)?
- Which methods should be abstract (subclasses must implement)?

### Step 12: Refine Your Method Design
Review your Pickup class methods and categorize them:

```gdscript
# TODO: For each method in your Pickup class, decide:

func _ready():
    # Is this concrete, virtual, or abstract?
    # Should all pickups do exactly the same setup?

func _on_body_entered(body):
    # Is this concrete, virtual, or abstract?
    # Should all pickups handle collision the same way?

func apply_pickup_effect(player: Player) -> bool:
    # Is this concrete, virtual, or abstract?
    # Should all pickups have the same effect?

func get_pickup_info() -> String:
    # Is this concrete, virtual, or abstract?
    # Should all pickups return the same debug info?
```

## Part 6: Documentation and Planning

### Step 13: Document Your Base Class
Write comments explaining your design decisions:

```gdscript
# TODO: Add class documentation at the top of your file
# Explain what the Pickup class is for and how it should be used

# TODO: Add comments to each method explaining:
# - What the method does
# - Whether subclasses should override it
# - What it returns and why

# TODO: Add comments to properties explaining:
# - What each property represents
# - What values are valid
# - How subclasses should use them
```

### Step 14: Plan for Inheritance
Think ahead to how subclasses will use your base class:

**Coin Class Planning:**
- What will `extends Pickup` instead of `extends Area2D`?
- What methods will Coin override?
- What properties will Coin add?
- How will `apply_pickup_effect()` work in Coin?

**HealthPotion Class Planning:**
- How will HealthPotion use the same base class?
- What will be different between Coin and HealthPotion implementations?
- What code will be eliminated from both classes?

## Reflection Questions

Write down or discuss your answers:

1. **Base Class Design**: What was most challenging about designing methods that work for all pickup types?

2. **Abstract Methods**: Why do you think `apply_pickup_effect()` should be abstract rather than concrete?

3. **Code Reuse**: What specific code will be eliminated from future subclasses by having this base class?

4. **Method Categories**: How did you decide which methods should be concrete vs. virtual vs. abstract?

5. **Testing Approach**: What surprised you when testing the base class? What worked differently than expected?

6. **Future Expansion**: How will this base class make it easier to add new pickup types like scrolls or keys?

## Deliverables
By the end of this lesson, you should have:
- [ ] Complete Pickup base class with all shared properties
- [ ] Implemented `_ready()` method with common initialization
- [ ] Implemented `_on_body_entered()` with shared collision logic
- [ ] Abstract `apply_pickup_effect()` method for subclasses to override
- [ ] Virtual `get_pickup_info()` method with base implementation
- [ ] Tested the base class and fixed any immediate errors
- [ ] Documentation explaining design decisions
- [ ] Understanding of concrete vs. virtual vs. abstract methods
- [ ] Plan for how subclasses will use inheritance

## Next Lesson Preview
In Lesson 2.2, we'll **refactor your existing Coin class** to inherit from your new Pickup base class! You'll see inheritance eliminate code duplication and experience how subclasses customize base class behavior.

**Exciting Transformation**: You'll convert working code to use inheritance and watch duplicated code disappear while functionality improves!

## Troubleshooting

**"My base class has errors when I test it"**
- Check that all method signatures are correct
- Ensure signal connections use the right signal names
- Verify that properties are properly exported
- Make sure abstract methods have placeholder implementations

**"I'm not sure what should be shared vs. specific"**
- Start with what's obviously identical between coin and potion
- Focus on the structure and flow rather than specific values
- When in doubt, make it concrete first, then refactor to virtual later
- Ask: "Would every pickup type need this?"

**"The apply_pickup_effect method seems weird"**
- This is intentionally abstract - it's meant to be overridden
- Each pickup type will have completely different effects
- The base class just defines the interface (method signature)
- Don't worry about implementing the actual effect yet

**"Testing the base class is confusing"**
- You're testing the structure, not the complete functionality
- Focus on whether methods exist and can be called
- Check that signals connect without errors
- Verify that debug output appears as expected