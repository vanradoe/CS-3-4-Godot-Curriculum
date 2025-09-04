# Lesson 3: Adding Methods to Classes

## Learning Objectives
By the end of this lesson, you will:
- Understand what methods (functions) are and why classes need them
- Add your first method to the Coin class
- Learn the difference between properties (what objects have) and methods (what objects do)
- Create interactive behavior between objects

## Getting Started

### What You Need From Lesson 2
Make sure you have:
- [ ] A Coin class with properties (`value`, `coin_type`, `size`, etc.)
- [ ] Multiple coin instances with different property values
- [ ] Coins that visually look different based on their properties

### Quick Review: Run Your Game
Test your current project - you should see different coins with different sizes, types, and values.

## Part 1: What Are Methods?

### Properties vs Methods Review
**Properties** (what we learned in Lesson 2):
- Characteristics objects **have**
- Examples: `value`, `size`, `coin_type`
- Like adjectives: "The coin is golden" or "The coin is worth 10 points"

**Methods** (what we're learning today):
- Actions objects can **do**  
- Examples: `collect()`, `bounce()`, `sparkle()`
- Like verbs: "The coin bounces" or "The player collects the coin"

### Think About Real Objects
Consider a real coin:
- **Properties**: size, weight, material, value
- **Methods**: flip(), drop(), exchange(), polish()

What **actions** should our game coins be able to do?

## Part 2: Creating Your First Method

### Step 1: Add a Simple Method
Open your `coin.gd` file and add a method:

```gdscript
extends Area2D
class_name Coin

@export_group("Coin Value")
@export var value: int = 1
@export var coin_type: String = "Bronze"

@export_group("Coin Appearance")
@export var is_rare: bool = false
@export var size: float = 1.0

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    scale = Vector2(size, size)
    
    if is_rare:
        $Sprite2D.modulate = Color.YELLOW

# Our first custom method!
func collect():
    print("Coin collected! You earned ", value, " points!")
    queue_free()  # Remove the coin from the game
```

### Understanding the New Code
- `func collect():` declares a new method called "collect"
- Inside the method, we can use the coin's properties (`value`)
- `queue_free()` is a Godot method that removes the object from the game

### Step 2: Test the Method (Temporarily)
Let's test our method by calling it automatically. Add this to `_ready()`:

```gdscript
func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    scale = Vector2(size, size)
    
    if is_rare:
        $Sprite2D.modulate = Color.YELLOW
    
    # Temporary: collect the coin after 3 seconds
    await get_tree().create_timer(3.0).timeout
    collect()
```

**Run your game** - what happens after 3 seconds?

## Part 3: Methods with Parameters

### Step 3: Improve the Collect Method
Let's make our method more flexible by accepting who collected the coin:

```gdscript
# Better collect method with parameter
func collect(collector_name: String):
    print(collector_name, " collected a ", coin_type, " coin worth ", value, " points!")
    queue_free()
```

And update the test call:
```gdscript
# In _ready(), change the test line to:
collect("Player")
```

### Understanding Parameters
- `collector_name: String` is a **parameter** - information passed to the method
- We can call `collect("Player")` or `collect("Enemy")` or `collect("Magic Spell")`
- Same method, different behavior based on the parameter

### Step 4: Remove the Automatic Collection
Once you've tested it works, **remove the automatic collection lines** from `_ready()`:
```gdscript
func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    scale = Vector2(size, size)
    
    if is_rare:
        $Sprite2D.modulate = Color.YELLOW
    
    # Remove these lines:
    # await get_tree().create_timer(3.0).timeout
    # collect("Player")
```

Now your coins should stay in the game permanently (until we connect them to the player).

## Part 4: Adding Visual Effect Methods

### Step 5: Create a Bounce Method
Let's add a fun visual method that makes coins bounce:

```gdscript
# Visual effect method
func bounce():
    # Create a tween for smooth animation
    var tween = create_tween()
    tween.tween_property(self, "position", position + Vector2(0, -20), 0.2)
    tween.tween_property(self, "position", position, 0.2)
```

### Step 6: Test the Bounce Method
Add this to `_ready()` to test it:
```gdscript
func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    scale = Vector2(size, size)
    
    if is_rare:
        $Sprite2D.modulate = Color.YELLOW
    
    # Test the bounce every 2 seconds
    bounce()
    var timer = Timer.new()
    timer.wait_time = 2.0
    timer.timeout.connect(bounce)
    timer.autostart = true
    add_child(timer)
```

**Run your game** - your coins should bounce every 2 seconds!

### Research Challenge: Understanding Tweens
**Documentation Link**: [Tween Class](https://docs.godotengine.org/en/stable/classes/class_tween.html)

- What is a tween and why do we use it?
- What does `tween_property()` do?
- How could you make the bounce higher or faster?

## Part 5: Methods That Use Properties

### Step 7: Create Value-Based Effects
Let's create methods that behave differently based on the coin's properties:

```gdscript
# Method that changes behavior based on coin value
func special_effect():
    if value >= 10:
        # High-value coins sparkle
        sparkle()
    elif value >= 5:
        # Medium-value coins glow
        glow()
    else:
        # Low-value coins just bounce
        bounce()

func sparkle():
    print("✨ ", coin_type, " coin sparkles! ✨")
    var tween = create_tween()
    tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.3)
    tween.tween_property($Sprite2D, "modulate", Color.YELLOW, 0.3)
    tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.3)

func glow():
    print("💫 ", coin_type, " coin glows! 💫")
    var tween = create_tween()
    tween.tween_property($Sprite2D, "scale", Vector2(1.2, 1.2), 0.5)
    tween.tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.5)
```

### Step 8: Test Special Effects
Replace your bounce timer with this:
```gdscript
# In _ready(), replace the timer code with:
special_effect()
var timer = Timer.new()
timer.wait_time = 3.0
timer.timeout.connect(special_effect)
timer.autostart = true
add_child(timer)
```

**Test with coins of different values** - what different effects do you see?

## Part 6: Creative Challenges

### Challenge 1: Return Values
Methods can also **return** information. Try this:

```gdscript
# Method that returns information
func get_description() -> String:
    var description = "A " + coin_type + " coin worth " + str(value) + " points"
    if is_rare:
        description += " (RARE!)"
    return description
```

**Your Task**: Use this method in another method to create better messages.

### Challenge 2: Method Chaining  
Create methods that work together:

```gdscript
# Method that calls other methods
func collect_with_fanfare(collector_name: String):
    special_effect()  # Play visual effect first
    await get_tree().create_timer(0.5).timeout  # Wait a bit
    collect(collector_name)  # Then collect the coin
```

### Challenge 3: Conditional Methods
Create a method that only works sometimes:

**Your Task**: Create a `try_collect()` method that only works if the coin isn't rare, or if a special condition is met.

## Part 7: Understanding Method Organization

### Why Put Methods in the Class?
Answer these questions:
1. Why is it better to put `collect()` in the Coin class instead of somewhere else?
2. What would happen if we had the collection code in the Player class instead?
3. How do methods help organize our code?

### Method Categories
Look at your methods and categorize them:
- **Action methods**: `collect()`, `bounce()`
- **Effect methods**: `sparkle()`, `glow()`, `special_effect()`
- **Information methods**: `get_description()`
- **Helper methods**: Methods that help other methods work

## Part 8: Reflection Questions

Write down your answers to these questions:

1. **Properties vs Methods**: In your own words, explain the difference between properties and methods.

2. **Method Benefits**: Why is it useful to put actions like `collect()` inside the Coin class?

3. **Parameters**: Explain what method parameters are and give an example of when they're useful.

4. **Real-World Connection**: Think of a real-world object. List 3 properties and 3 methods it might have.

5. **Design Thinking**: If you were creating a `Gem` class, what methods would it need? How might they be different from coin methods?

## Deliverables
By the end of this lesson, you should have:
- [ ] A `collect()` method that removes coins and prints messages
- [ ] At least 2 visual effect methods (`bounce()`, `sparkle()`, etc.)
- [ ] A method that uses coin properties to change behavior
- [ ] Completed at least one creative challenge
- [ ] Working timer system that demonstrates method calling
- [ ] Written answers to reflection questions

## Next Lesson Preview
In Lesson 4, we'll create different types of collectible classes (Gems, Power-ups) and see how they can have similar methods but different behaviors. This will set us up for learning about inheritance in future lessons.

## Troubleshooting

**"My tween animations aren't working"**
- Make sure you're calling `create_tween()` not `Tween.new()`
- Check that your position calculations are correct
- Try simpler animations first (just changing modulate color)

**"queue_free() isn't removing the coin"**
- `queue_free()` removes the object at the end of the frame
- The coin might still be visible briefly - this is normal
- Use print statements to verify the method is being called

**"My timer keeps calling the old method"**
- Make sure you disconnected the old signal: `timer.timeout.disconnect(old_method)`
- Or create a new timer instead of reusing the old one

**"I get errors about missing nodes"**
- Check that `$Sprite2D` exists - it should be a child of your coin
- Verify the exact name matches (case-sensitive)

## Additional Resources
- [GDScript Functions](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#functions)
- [Tween Class Documentation](https://docs.godotengine.org/en/stable/classes/class_tween.html)  
- [Timer Class Documentation](https://docs.godotengine.org/en/stable/classes/class_timer.html)
- [Understanding Signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)
