# Lesson 2: Adding Properties to Classes

## Learning Objectives
By the end of this lesson, you will:
- Understand what class properties are and why we use them
- Add properties to your Coin class
- Create different types of coins with different values
- Learn about `@export` and how it helps in the editor

## Getting Started

### What You Need From Lesson 1
Make sure you have:
- [ ] A working `coin.gd` script with the Coin class
- [ ] A `coin.tscn` scene file
- [ ] At least one coin instance in your main scene
- [ ] The coin shows up and prints a message when the game runs

### Quick Review: Run Your Game
Test your current project - you should see your coins and the print messages in the output.

## Part 1: What Are Properties?

### Think About Real Objects
Consider a real coin:
- What **characteristics** does it have? (size, color, value, material)
- Do all coins have the same value? (penny vs quarter vs dollar)
- What makes one coin different from another?

In programming, these characteristics are called **properties** (or variables).

### Current Coin Limitations
Right now, ALL of our coins are exactly the same. But what if we want:
- Gold coins worth 10 points
- Silver coins worth 5 points  
- Bronze coins worth 1 point

We need to add **properties** to our Coin class!

## Part 2: Adding Your First Property

### Step 1: Add a Value Property
Open your `coin.gd` file and modify it:

```gdscript
extends Area2D
class_name Coin

# Properties of our coin
var value: int = 1

func _ready():
    print("A coin worth ", value, " points has been created!")
```

### Understanding the Code
- `var value: int = 1` creates a property called `value`
- `int` means it stores whole numbers (1, 2, 10, etc.)
- `= 1` sets the default value to 1
- We use the `value` in our print statement

### Step 2: Test Your Changes  
1. Save your script
2. Run the game
3. **What do you see in the output now?**

## Part 3: Making Properties Editable

### The Problem with Our Current Code
All coins still have the same value (1). We want to make different coins with different values WITHOUT changing our code each time.

### Solution: Export Variables
**Export variables** can be edited in the Godot editor for each instance.

### Step 3: Make Value Exportable
Change your coin.gd script:

```gdscript
extends Area2D
class_name Coin

# Properties of our coin  
@export var value: int = 1

func _ready():
    print("A coin worth ", value, " points has been created!")
```

### Step 4: Test the Export Feature
1. Save your script
2. Open `main.tscn`
3. **Select one of your coin instances**
4. **Look at the Inspector panel** - you should see a "Value" field!
5. **Change the value** for different coins (try 5, 10, 25)
6. **Run the game** - what messages do you see now?

## Part 4: Adding More Properties

### Step 5: Add Coin Type
Let's add another property for the type of coin:

```gdscript
extends Area2D
class_name Coin

# Properties of our coin
@export var value: int = 1
@export var coin_type: String = "Bronze"

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
```

### Step 6: Customize Your Coins
1. Save your script
2. In `main.tscn`, select each coin instance
3. In the Inspector, set different combinations:
   - Bronze coin, value 1
   - Silver coin, value 5  
   - Gold coin, value 10
4. Run the game and check the output

## Part 5: Understanding Data Types

### Research Challenge
Look up these GDScript data types and answer the questions:

**Documentation Link**: [GDScript Built-in Types](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#built-in-types)

1. **int**: What kind of numbers can this store? Give examples.
2. **String**: What does this store? How do you write String values?
3. **float**: How is this different from int? When might you use it?
4. **bool**: What two values can this store?

### Step 7: Experiment with Different Data Types
Try adding these properties to your coin (one at a time, test each):

```gdscript
@export var is_rare: bool = false
@export var size: float = 1.0
```

**Questions to Answer:**
- What interface do you see in the Inspector for `bool` values?
- What happens when you set `size` to 1.5 or 0.5?
- How might these properties be useful in a game?

## Part 6: Organizing Properties with Groups

### Step 8: Group Related Properties
For better organization, we can group our properties:

```gdscript
extends Area2D
class_name Coin

# Coin Value Properties
@export_group("Coin Value")
@export var value: int = 1
@export var coin_type: String = "Bronze"

# Coin Appearance Properties  
@export_group("Coin Appearance")
@export var is_rare: bool = false
@export var size: float = 1.0

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
```

**Test this:** Check the Inspector - your properties should now be organized into groups!

## Part 7: Making Properties Affect Behavior

### Step 9: Use Size Property Visually
Let's make the `size` property actually change how big the coin looks:

```gdscript
extends Area2D
class_name Coin

# Coin Value Properties
@export_group("Coin Value")
@export var value: int = 1
@export var coin_type: String = "Bronze"

# Coin Appearance Properties
@export_group("Coin Appearance")  
@export var is_rare: bool = false
@export var size: float = 1.0

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    
    # Make the size property affect the visual size
    scale = Vector2(size, size)
```

### Step 10: Test Size Changes
1. Save your script
2. In `main.tscn`, set different `size` values for your coins (try 0.5, 1.0, 1.5, 2.0)
3. Run the game - **What do you notice about the coins?**

## Part 8: Creative Challenges

### Challenge 1: Rare Coin Indicator
Make rare coins look different! Add this to your `_ready()` function:

```gdscript
func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    
    # Make the size property affect the visual size
    scale = Vector2(size, size)
    
    # TODO: Make rare coins a different color
    # Research: How do you change a Sprite2D's color?
    # Hint: Look up "modulate" property
```

**Your Task:** Figure out how to make rare coins a different color (gold, bright yellow, etc.)

### Challenge 2: Value-Based Sizing
Instead of manually setting size, make it automatic based on value:

**Your Task:** Modify the `_ready()` function so that:
- Coins worth 1-5 points are normal size (1.0)
- Coins worth 6-10 points are bigger (1.5)  
- Coins worth more than 10 points are huge (2.0)

### Challenge 3: Coin Categories
Add a new property that uses an enum (predefined choices):

**Research:** Look up "GDScript enums" and try to implement this:
```gdscript
enum CoinRarity { COMMON, UNCOMMON, RARE, LEGENDARY }
@export var rarity: CoinRarity = CoinRarity.COMMON
```

## Part 9: Reflection Questions

Write down your answers to these questions:

1. **Property Purpose**: Explain in your own words what properties are and why they're useful in classes.

2. **Export Benefits**: What's the advantage of using `@export` instead of just regular variables?

3. **Instance Differences**: You have one Coin class but multiple coin instances. How can they be different from each other?

4. **Real-World Connection**: Think of another real-world object. What properties would its class have? List 3-5 properties.

5. **Data Type Choices**: Why do you think we use `int` for coin value instead of `String`?

## Deliverables
By the end of this lesson, you should have:
- [ ] A Coin class with at least 3 different properties
- [ ] Multiple coin instances with different values and types
- [ ] Properties organized using `@export_group`
- [ ] At least one property that affects visual appearance
- [ ] Completed at least one creative challenge
- [ ] Written answers to reflection questions

## Next Lesson Preview
In Lesson 3, we'll add **methods** (functions) to our Coin class. We'll create a `collect()` method that the player can call to pick up coins, and learn how classes can have their own behaviors.

## Troubleshooting

**"I don't see the export properties in Inspector"**
- Make sure you saved the coin.gd script
- Try selecting a different node and then selecting the coin again
- Check that your script is properly attached to the coin scene

**"My size changes aren't showing up"**
- Make sure you're testing with the `scale = Vector2(size, size)` line in _ready()
- Check that you set different size values for different coin instances
- Try more extreme values like 0.3 or 3.0 to make the difference obvious

**"My print messages look weird"**
- Check your string concatenation - make sure you have spaces in the right places
- Remember that you join strings and numbers with commas in print statements

## Additional Resources
- [GDScript Variables and Properties](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#variables)  
- [Export Annotations](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html)
- [Built-in Types Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#built-in-types)
