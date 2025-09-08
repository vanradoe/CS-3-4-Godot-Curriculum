# Lesson 2.2: Refactoring Coin to Use Inheritance

## Learning Objectives
By the end of this lesson, you will:
- Convert an existing class to use inheritance instead of duplication
- Experience the process of refactoring working code safely
- Understand how subclasses override base class methods
- See code duplication eliminated while preserving all functionality
- Gain confidence in inheritance through hands-on refactoring

## What We're Building
Today we're **refactoring your Coin class** to inherit from the Pickup base class you created in Lesson 2.1. You'll systematically remove duplicated code and replace it with inheritance, while ensuring all coin functionality continues to work perfectly.

## Part 1: Pre-Refactoring Investigation

### Step 1: Document Current Coin Behavior
Before making any changes, thoroughly document how your coin currently works:

1. **Create a new coin** in your test scene
2. **Test all coin functionality** and record what happens:
   - What console output appears when the coin is created?
   - What happens when the player touches the coin?
   - How do different coin types (copper, silver, gold) behave?
   - What debug information is displayed?

**Pre-Refactoring Checklist:**
```
[ ] Coin creates successfully and shows in scene
[ ] Console shows coin creation debug message
[ ] Player collision detection works
[ ] Gold is added to player when picked up
[ ] Coin disappears after successful pickup
[ ] Different coin types have correct values
[ ] Error messages appear for invalid coin types
[ ] Auto-pickup functionality works if implemented
```

### Step 2: Analyze Current Coin Code
Let's assume your current coin class looks something like this:

```gdscript
extends Area2D
class_name Coin

@export var gold_value: int = 10
@export var auto_pickup: bool = true
@export var coin_type: String = "copper"

func _ready():
    print("🪙 Coin created - Type: " + coin_type + ", Value: " + str(gold_value))
    body_entered.connect(_on_body_entered)
    configure_coin_type()
    
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

**Code Analysis Questions:**
- Which parts of this code are identical to your HealthPotion class?
- Which parts are specific to coins only?
- Which methods will be handled by the base class?
- Which methods will Coin need to override or add?

### Step 3: Compare with Base Class
Open your `scripts/pickup.gd` base class and compare it with your coin code:

**Comparison Questions:**
- What functionality is now handled by the Pickup base class?
- What coin-specific functionality needs to remain in the Coin class?
- Which properties can be removed from Coin (now inherited)?
- Which methods can be removed from Coin (now inherited)?

## Part 2: Understanding Inheritance Refactoring

### Documentation: Refactoring to Inheritance

Here's the general process for converting a class to use inheritance:

```gdscript
# BEFORE: Standalone class with duplicated code
extends Area2D
class_name OldCoin

@export var gold_value: int = 10
@export var auto_pickup: bool = true  # This is duplicated!

func _ready():  # This logic is duplicated!
    body_entered.connect(_on_body_entered)
    print("Coin created")

func _on_body_entered(body):  # This structure is duplicated!
    if body is Player:
        # Apply coin-specific effect
        pass

# AFTER: Inherits shared code, keeps only unique functionality  
extends Pickup  # Now inherits shared functionality!
class_name NewCoin

@export var gold_value: int = 10  # Coin-specific property
# auto_pickup is now inherited from Pickup!

# _ready() is now inherited from Pickup!
# _on_body_entered() is now inherited from Pickup!

func apply_pickup_effect(player: Player) -> bool:  # Override abstract method
    # Coin-specific effect implementation
    return player.add_gold(gold_value)
```

**Key Refactoring Principles:**
- **Remove duplicated code**: Delete what's now inherited
- **Keep unique functionality**: Only coin-specific properties and methods remain
- **Override abstract methods**: Implement methods the base class requires
- **Customize inherited behavior**: Override virtual methods if needed

## Part 3: Step-by-Step Refactoring

### Step 4: Create Backup and Plan
Before starting, create a backup of your working coin:

```gdscript
# TODO: Save a copy of your current working coin.gd as coin_backup.gd
# This way you can restore if something goes wrong

# TODO: Plan your refactoring steps:
# 1. Change extends declaration
# 2. Remove duplicated properties
# 3. Remove duplicated methods  
# 4. Add coin-specific overrides
# 5. Test each step
```

### Step 5: Change the Base Class
Start by changing what your Coin class extends:

```gdscript
# TODO: Change the first line from:
# extends Area2D
# to:
# extends Pickup

# Keep the class_name declaration:
class_name Coin
```

### Step 6: Remove Duplicated Properties
Remove properties that are now inherited from Pickup:

```gdscript
# TODO: Look at your Pickup base class properties
# Remove any properties from Coin that are now inherited

# Keep coin-specific properties like:
@export var gold_value: int = 10
@export var coin_type: String = "copper"

# TODO: Remove properties that exist in Pickup base class
# Common candidates: auto_pickup, pickup_type, etc.
```

### Step 7: Remove Duplicated Methods
Remove methods that are now inherited:

```gdscript
# TODO: Remove methods that are now handled by Pickup base class
# Common methods to remove:
# - _ready() (if Pickup handles all setup)
# - _on_body_entered() (if Pickup handles collision detection)

# TODO: Keep methods that are coin-specific:
# - configure_coin_type()
# - Any other coin-only functionality
```

### Step 8: Implement Required Abstract Methods
Add implementations for abstract methods from the base class:

```gdscript
func apply_pickup_effect(player: Player) -> bool:
    # TODO: Implement the coin's specific pickup effect
    # This should contain the logic for giving gold to the player
    
    # Hint: This is where the coin-specific behavior goes
    # What should happen when a player picks up THIS coin?
    # Return true if pickup was successful, false otherwise
    
    pass
```

### Step 9: Override Virtual Methods (If Needed)
Customize inherited methods for coin-specific behavior:

```gdscript
func get_pickup_info() -> String:
    # TODO: Override this method to provide coin-specific debug info
    # Call the base class method and add coin details
    
    # Hint: Use super() to call the base class version first
    # Then add coin-specific information like type and value
    
    return "TODO: Add coin-specific debug info"
```

## Part 4: Testing the Refactored Code

### Step 10: Test Basic Functionality
Test your refactored coin step by step:

1. **Compilation Test**: Does the code compile without errors?
2. **Creation Test**: Can you create a coin instance?  
3. **Debug Output Test**: What console output appears?
4. **Collision Test**: Does player collision work?
5. **Pickup Test**: Does the coin give gold and disappear?

**Testing Approach:**
```gdscript
# TODO: Add temporary test code to verify your refactoring
func test_refactored_coin():
    print("=== Testing Refactored Coin ===")
    
    # Test that coin can be created
    var test_coin = Coin.new()
    
    # Test debug info
    print("Coin info: " + test_coin.get_pickup_info())
    
    # TODO: Add more tests to verify all functionality works
```

### Step 11: Compare with Original Behavior
Run your pre-refactoring checklist again:

**Post-Refactoring Verification:**
```
[ ] Coin creates successfully and shows in scene (same as before?)
[ ] Console shows coin creation debug message (same message?)
[ ] Player collision detection works (same behavior?)
[ ] Gold is added to player when picked up (same amount?)
[ ] Coin disappears after successful pickup (same timing?)
[ ] Different coin types have correct values (same values?)
[ ] Error messages appear for invalid coin types (same messages?)
[ ] Auto-pickup functionality works (if it was working before)
```

### Step 12: Debug and Fix Issues
If something isn't working, systematically debug:

**Common Refactoring Issues:**
```gdscript
# TODO: If coin creation fails:
# - Check that base class Pickup is properly implemented
# - Verify that required methods exist in base class
# - Check for typos in method names

# TODO: If pickup effect doesn't work:
# - Verify apply_pickup_effect() is properly implemented
# - Check that it returns the correct boolean value
# - Ensure player.add_gold() is being called correctly

# TODO: If debug info is missing:
# - Check that get_pickup_info() is implemented
# - Verify the base class _ready() method calls it correctly
# - Look for print statement formatting issues
```

## Part 5: Understanding the Refactoring Results

### Step 13: Measure Code Reduction
Compare your before and after code:

**Line Count Analysis:**
```
TODO: Count the lines of code in your refactored Coin class
TODO: Compare with the lines in your original coin (or coin_backup.gd)
TODO: Calculate the percentage reduction in duplicated code

Before refactoring: ___ lines of code
After refactoring: ___ lines of code  
Code reduction: ___ lines (___% reduction)
```

**Functionality Analysis:**
- How many methods did you remove from Coin class?
- How many properties did you remove from Coin class?
- What new methods did you have to implement?
- What coin-specific functionality remains?

### Step 14: Explore Inherited Behavior
Test that you're actually using inherited functionality:

```gdscript
# TODO: Add debug prints to verify inheritance is working
func test_inheritance():
    var coin = Coin.new()
    
    # Test that inherited methods exist
    print("Has _ready method: " + str(coin.has_method("_ready")))
    print("Has _on_body_entered: " + str(coin.has_method("_on_body_entered")))
    print("Has apply_pickup_effect: " + str(coin.has_method("apply_pickup_effect")))
    
    # Test that inherited properties exist  
    # TODO: Check for properties that should be inherited from Pickup
```

### Step 15: Verify Polymorphism
Test that your Coin can be treated as a Pickup:

```gdscript
# TODO: Create a function that accepts any Pickup
func handle_any_pickup(pickup: Pickup):
    print("Handling pickup: " + pickup.get_pickup_info())
    # This should work with Coin instances too!

# TODO: Test that this function works with your refactored Coin
func test_polymorphism():
    var coin = Coin.new()
    handle_any_pickup(coin)  # Should work because Coin extends Pickup!
```

## Part 6: Advanced Inheritance Features

### Step 16: Using super() for Method Extension
Learn to extend inherited methods rather than completely overriding them:

```gdscript
func get_pickup_info() -> String:
    # TODO: Call the base class method first
    var base_info = super()  # Gets basic pickup info from base class
    
    # TODO: Add coin-specific information
    var coin_info = " | Coin: " + coin_type + " (Value: " + str(gold_value) + ")"
    
    return base_info + coin_info
```

**super() Usage Questions:**
- When should you use `super()` vs. completely overriding a method?
- What happens if you forget to call `super()` in an overridden method?
- How does `super()` help maintain base class functionality?

### Step 17: Customize Inherited Behavior
Sometimes you need to modify inherited behavior slightly:

```gdscript
# TODO: If you need to customize the base class _ready() behavior:
func _ready():
    # Call base class setup first
    super()
    
    # Add coin-specific setup
    configure_coin_type()
    
    # TODO: Add any other coin-specific initialization
```

## Part 7: Reflection and Documentation

### Step 18: Document Your Changes
Add comments explaining your inheritance decisions:

```gdscript
# TODO: Add class documentation explaining the inheritance
# Coin class inherits from Pickup base class
# Provides gold-giving functionality for pickup system

# TODO: Document each override
func apply_pickup_effect(player: Player) -> bool:
    # Override abstract method from Pickup
    # Implements coin-specific effect: giving gold to player
    
# TODO: Document any customizations
func get_pickup_info() -> String:
    # Extends base class method to include coin-specific info
```

### Step 19: Plan Future Inheritance
Think about how this pattern will apply to other classes:

**HealthPotion Refactoring Planning:**
- Which methods will HealthPotion override?
- How will `apply_pickup_effect()` work differently for potions?
- What potion-specific properties will remain?
- How much code duplication will be eliminated?

**Future Pickup Types:**
- How would you add a MagicScroll pickup using this inheritance?
- What would a Key pickup need to implement?
- How does the inheritance make adding new types easier?

## Reflection Questions

Write down or discuss your answers:

1. **Refactoring Experience**: What was most challenging about converting working code to use inheritance?

2. **Code Quality**: How does the refactored Coin class compare to the original in terms of readability and maintainability?

3. **Inheritance Benefits**: What specific benefits did you experience from using inheritance instead of code duplication?

4. **Method Overriding**: What did you learn about when to completely override vs. extend inherited methods?

5. **Debugging Process**: How did you approach debugging when the refactored code didn't work as expected?

6. **Design Insights**: What would you do differently if you were designing the base class now that you've used it?

## Deliverables
By the end of this lesson, you should have:
- [ ] Successfully refactored Coin class to inherit from Pickup
- [ ] Eliminated all duplicated code between Coin and base class
- [ ] Implemented required abstract methods (`apply_pickup_effect`)
- [ ] Verified that all original coin functionality still works
- [ ] Added coin-specific overrides where needed
- [ ] Tested inheritance features like polymorphism
- [ ] Measured the code reduction achieved through inheritance
- [ ] Documented inheritance decisions and overrides
- [ ] Understanding of super() usage and method extension
- [ ] Plan for refactoring HealthPotion class in next lesson

## Next Lesson Preview
In Lesson 2.3, we'll **refactor the HealthPotion class** to also inherit from Pickup! You'll see how the same base class supports completely different pickup types, and experience how inheritance makes code maintenance much easier.

**Coming Benefits**: After refactoring HealthPotion, you'll be able to add new pickup types with just a few lines of code!

## Troubleshooting

**"My refactored coin doesn't compile"**
- Check that Pickup base class exists and compiles first
- Verify all abstract methods are implemented in Coin
- Look for typos in method names and signatures
- Ensure you're using `extends Pickup` correctly

**"The coin works but behaves differently"**
- Compare console output before and after refactoring
- Check that apply_pickup_effect() returns the right values
- Verify that all coin-specific logic is preserved
- Test edge cases like invalid coin types

**"I'm confused about which methods to keep vs. remove"**
- Keep anything that's specific to coins only
- Remove anything that's identical to base class functionality  
- When in doubt, keep it first, then refactor incrementally
- Focus on the unique coin behavior (giving gold)

**"Inheritance seems more complicated than duplication"**
- This complexity pays off when maintaining multiple similar classes
- Remember you're learning a pattern used in professional game development
- The benefits become clear when adding new pickup types
- Focus on how much less code you have to maintain now

**"My debug output is different after refactoring"**
- This is expected - the base class may format output differently
- Customize get_pickup_info() to match your preferred format
- Use super() to extend base class output rather than replacing it
- Focus on preserving functionality over exact output formatting