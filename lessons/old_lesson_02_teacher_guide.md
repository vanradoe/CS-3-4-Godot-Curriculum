# Lesson 2 - Teacher Guide: Adding Properties to Classes

## Overview for Teachers
This lesson builds directly on Lesson 1 by introducing class properties (variables). Students learn the difference between regular variables and exported variables, and see how the same class can create different instances with different characteristics.

## Learning Objectives (Teacher Notes)
- **Conceptual**: Students understand properties as characteristics of objects
- **Technical**: Students can add variables to classes and use @export
- **Visual**: Students see how properties can affect object appearance and behavior
- **Editor Skills**: Students learn to use the Inspector to modify instance properties

## Setup Required Before Class
1. **Verify Lesson 1 completion**: All students should have working coin classes and scenes
2. **Test export functionality**: Make sure @export variables show up in Inspector
3. **Prepare examples**: Consider having different coin types ready to show

## Lesson Progression and Expected Outcomes

### Part 1: Understanding Properties
**Help Students Connect:**
- Properties are like characteristics or traits
- Same species (class), different individuals (instances) with different traits
- **Example**: All dogs are from Dog class, but each dog has different: size, color, age, name

### Part 2: First Property (Value)
**Students Should Discover:**
- Adding `var value: int = 1` gives every coin a value property
- All coins still have the same value (1) initially
- The print statement now includes the value

### Part 3: Export Variables
**This is the Key Concept:**
- `@export` makes properties editable in the Inspector
- Same class, different instances can have different values
- No need to modify code for each instance

## Solution Code Progression

### Step 1: Basic Property
```gdscript
extends Area2D
class_name Coin

var value: int = 1

func _ready():
    print("A coin worth ", value, " points has been created!")
```

### Step 2: Export Property  
```gdscript
extends Area2D
class_name Coin

@export var value: int = 1

func _ready():
    print("A coin worth ", value, " points has been created!")
```

### Step 3: Multiple Properties
```gdscript
extends Area2D
class_name Coin

@export var value: int = 1
@export var coin_type: String = "Bronze"

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
```

### Step 4: Organized with Groups
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
```

### Step 5: Complete Solution with Visual Effects
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
    
    # Apply size
    scale = Vector2(size, size)
    
    # Make rare coins golden
    if is_rare:
        $Sprite2D.modulate = Color.YELLOW
```

## Challenge Solutions

### Challenge 1: Rare Coin Indicator
```gdscript
# Add to _ready() function:
if is_rare:
    $Sprite2D.modulate = Color.YELLOW  # or Color.GOLD
```

### Challenge 2: Value-Based Sizing  
```gdscript
# Add to _ready() function:
if value <= 5:
    scale = Vector2(1.0, 1.0)
elif value <= 10:
    scale = Vector2(1.5, 1.5)
else:
    scale = Vector2(2.0, 2.0)
```

### Challenge 3: Coin Categories with Enums
```gdscript
extends Area2D
class_name Coin

enum CoinRarity { COMMON, UNCOMMON, RARE, LEGENDARY }

@export_group("Coin Value")
@export var value: int = 1
@export var coin_type: String = "Bronze"
@export var rarity: CoinRarity = CoinRarity.COMMON

func _ready():
    print("A ", coin_type, " coin worth ", value, " points has been created!")
    
    # Different colors for different rarities
    match rarity:
        CoinRarity.COMMON:
            $Sprite2D.modulate = Color.WHITE
        CoinRarity.UNCOMMON:
            $Sprite2D.modulate = Color.GREEN
        CoinRarity.RARE:
            $Sprite2D.modulate = Color.BLUE
        CoinRarity.LEGENDARY:
            $Sprite2D.modulate = Color.PURPLE
```

## Common Student Questions & Answers

**Q: "What's the difference between `var` and `@export var`?"**
A: Both create properties, but `@export` makes them editable in the Inspector. Regular `var` properties can only be changed in code.

**Q: "Why do we use `int` for value instead of `String`?"** 
A: Because we might want to do math with coin values (add them up, compare them). You can't do math with strings like "five".

**Q: "Can I have the same property with different names in different instances?"**
A: No, the property NAME is the same for all instances (defined by the class), but each instance can have a different VALUE for that property.

**Q: "What does `scale = Vector2(size, size)` do?"**
A: `scale` changes how big something appears. `Vector2(size, size)` creates a 2D vector where both X and Y scaling are set to the `size` value.

**Q: "My coin disappeared when I set size to 0!"**  
A: A scale of 0 makes objects invisible! Try values between 0.1 and 3.0 for visible results.

## Data Type Teaching Notes

### int (Integer)
- Whole numbers: ..., -2, -1, 0, 1, 2, 3, ...
- Good for: counts, IDs, levels, health points
- Cannot store decimal places

### String  
- Text in quotes: "Bronze", "Hello World", "123"
- Good for: names, descriptions, messages
- Can contain numbers but can't do math with them

### float
- Decimal numbers: 1.5, 3.14159, 0.25, -2.7
- Good for: positions, speeds, percentages, time
- More memory than int, use when you need decimals

### bool
- Only two values: `true` or `false`
- Good for: on/off states, yes/no questions, conditions
- Inspector shows as checkbox

## Assessment Rubric
- **Novice**: Adds basic properties, understands export concept
- **Proficient**: Uses multiple data types, organizes with groups, makes properties affect appearance
- **Advanced**: Completes challenges, explains property benefits clearly
- **Expert**: Creates creative property combinations, helps others debug

## Time Management
- **15 min**: Properties concept and first value property
- **15 min**: Export variables and Inspector editing
- **20 min**: Multiple properties and data types
- **10 min**: Visual effects (size, color)
- **15 min**: Challenges and experimentation
- **10 min**: Reflection and discussion

## Common Mistakes and How to Help

**Mistake: Student forgets to save script before testing**
*Fix:* Establish habit: Save (Ctrl+S) → Test → Repeat

**Mistake: Student changes wrong coin's properties**
*Fix:* Show how to select specific coin instances in scene tree, check that Inspector shows the right node name

**Mistake: Student tries to change class code for each instance**
*Fix:* Emphasize that @export lets you customize instances WITHOUT changing the class code

**Mistake: String concatenation issues in print**
*Fix:* Show proper comma usage: `print("Text ", variable, " more text")`

**Mistake: Inspector doesn't show export variables**
*Fix:* Check script attachment, try reselecting node, verify @export syntax

## Extension Activities (Advanced Students)
1. **Color Property**: Add an export Color property that changes coin tint
2. **Speed Property**: Add a rotation speed that makes coins spin
3. **Sound Property**: Add a String property for different pickup sound names
4. **Stats Property**: Create a coin that affects player stats when collected

## Preparation for Lesson 3
Students will need their enhanced coin class with properties for Lesson 3, where we add methods (behaviors) to coins. Key concepts from this lesson that feed into Lesson 3:
- Understanding that instances can have different property values
- Familiarity with accessing properties in code
- Experience with the Inspector for testing

## Answers to Reflection Questions

### 1. Property Purpose
**Good Student Answer**: "Properties are characteristics that objects have. They let us make different instances of the same class have different traits, like making some coins worth more than others."

### 2. Export Benefits  
**Key Points**: Can change values without editing code, easy to test different values, designers can tweak gameplay without programming.

### 3. Instance Differences
**Good Understanding**: "All coins use the same Coin class, but each coin instance can have its own values for the properties. It's like all people are from the 'Human' class but each person has different height, weight, name, etc."

### 4. Real-World Connection Examples
- **Car Class**: color, speed, fuel_capacity, number_of_doors, brand
- **Book Class**: title, author, page_count, genre, is_hardcover
- **Phone Class**: brand, screen_size, battery_life, storage_capacity, color

### 5. Data Type Choice
**Good Answer**: "We use int for coin value because we want to do math with it - add up total score, compare values, etc. Strings are for text, not numbers we calculate with."

This lesson effectively bridges the gap between static classes (Lesson 1) and interactive behaviors (Lesson 3), giving students hands-on experience with one of the most important OOP concepts.
