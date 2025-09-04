# Lesson 1 - Teacher Guide: What is a Class?

## Overview for Teachers
This lesson introduces the fundamental concept of classes using a simple, concrete example (coins in a game). Students create their first custom class and see multiple instances of it in action. This is appropriate for students with no prior Godot experience.

## Learning Objectives (Teacher Notes)
- **Conceptual**: Students understand class vs instance (blueprint vs actual object)
- **Technical**: Students can create a basic GDScript class with `class_name`
- **Practical**: Students can create scenes, attach scripts, and instance objects
- **Foundation**: Sets up for properties (Lesson 2) and methods (Lesson 3)

## Setup Required Before Class
1. **Test the project**: Run it, make sure player moves with arrow keys
2. **Prepare examples**: You may want to gather simple coin sprites (optional)
3. **Check file structure**: Ensure the `scripts/` and `scenes/` folders exist
4. **Optional**: Create a sample coin ahead of time to show students

## Expected Student Discoveries

### Part 1: Understanding Player Class
**Key Answers Students Should Find:**
- `class_name Player` declares this as a class
- `extends CharacterBody2D` means it inherits from Godot's CharacterBody2D class
- Properties: `move_speed` (export variable)
- Methods: `_ready()`, `_physics_process()`, `handle_movement()`

**If Students Struggle:** Point them to the first few lines of player.gd

### Part 2: Class vs Instance Concept
**Help Students Connect:**
- **Class = Recipe**, **Instance = Cake made from recipe**
- **Class = Pokemon species**, **Instance = Your specific Pikachu**
- **Class = Car manufacturer design**, **Instance = The car in your driveway**

## Solution Code and Setup

### Complete coin.gd Script
```gdscript
extends Area2D
class_name Coin

func _ready():
    print("A coin has been created!")
```

### Coin Scene Structure (coin.tscn)
```
Coin (Area2D) [with coin.gd script attached]
├── Sprite2D [with texture/placeholder]
└── CollisionShape2D [with RectangleShape2D]
```

### Setting Up the Coin Scene (Step-by-Step for Teachers)
1. **Scene > New Scene**
2. **Add Area2D node**, rename to "Coin"
3. **Right-click Coin > Attach Script**, choose `res://scripts/coin.gd`
4. **Add Sprite2D as child** of Coin
5. **Add CollisionShape2D as child** of Coin
6. **Select Sprite2D**: 
   - In Inspector, click "Texture" dropdown
   - Choose "New PlaceholderTexture2D" for simple colored square
   - OR load a coin sprite if you have one
7. **Select CollisionShape2D**:
   - In Inspector, click "Shape" dropdown
   - Choose "New RectangleShape2D"
   - Drag corners to match sprite size
8. **Save scene** as `coin.tscn`

### Adding Coins to Main Scene
1. **Open main.tscn**
2. **Drag coin.tscn from FileSystem** into the scene
3. **Position the coin** somewhere visible
4. **Duplicate the coin** (Ctrl+D) to create more instances
5. **Position each coin** in different locations

## Common Student Questions & Answers

**Q: "Why do we use Area2D instead of just a Node2D?"**
A: Area2D can detect when other objects enter or leave its area. We'll use this for collision detection when the player collects coins in future lessons.

**Q: "What's the difference between `extends` and `class_name`?"**
A: `extends` means "inherit from" (we get all of Area2D's functionality). `class_name` gives our class a name that we can reference elsewhere.

**Q: "Why do I need a CollisionShape2D if we're not using collision yet?"**
A: Good preparation for future lessons. Also, Area2D nodes need a collision shape to function properly, even if we're not using collision detection yet.

**Q: "Can I change the print message after I've already created instances?"**
A: Yes! The script code affects ALL instances. Change the message in coin.gd and run again - all coins will print the new message.

## Answers to Reflection Questions

### 1. Class vs Instance
**Good Student Answers:**
- "The Coin class is like a recipe, each coin in the game is like a cake made from that recipe"
- "The class is the blueprint, instances are the actual houses built from it"
- "The class describes what coins can do, instances are the actual coins doing it"

### 2. Benefits of Classes
**Key Points Students Should Identify:**
- Don't have to write the same code multiple times
- Can easily create many coins
- If we want to change all coins, we only change the class once
- Organized and easier to maintain

### 3. Real-World Analogy Examples
**Good Student Examples:**
- Cookie cutter (class) and cookies (instances)  
- House blueprint (class) and actual houses (instances)
- Pokemon species (class) and individual Pokemon (instances)
- Phone model design (class) and actual phones (instances)

### 4. Prediction for Next Lesson
**What Students Might Predict:**
- Different types of coins
- Coins worth different points
- Making coins do different things
- Player being able to collect coins

## Extension Activities (for Advanced Students)
1. **Different Coin Types**: Create silver coins and gold coins using the same class
2. **Coin Animation**: Make coins rotate or bounce
3. **Random Positioning**: Write code to place coins in random locations
4. **Coin Counter**: Add a simple UI element that shows how many coins exist

## Assessment Rubric
- **Novice**: Creates basic coin class, understands class vs instance concept
- **Proficient**: Successfully creates multiple coin instances, explains benefits of classes
- **Advanced**: Answers all reflection questions thoughtfully, makes connections to real-world examples  
- **Expert**: Completes extension activities, helps other students

## Time Management
- **10 min**: Investigation of existing Player class
- **15 min**: Class vs instance concept discussion  
- **25 min**: Creating coin script and scene
- **10 min**: Testing with multiple instances
- **10 min**: Reflection and discussion

## Common Mistakes and How to Help

**Mistake: Student tries to put coin.gd in the main scene**
*Fix:* Explain that scripts attach to specific node types. The coin script goes on the Coin scene's root node.

**Mistake: Student doesn't see their coin in game**  
*Fix:* Check that the coin was actually added to main.tscn and is positioned within camera view.

**Mistake: Student confuses "class" and "scene"**
*Fix:* Explain that the scene (.tscn) is the visual structure, the script (.gd) contains the class code. They work together.

**Mistake: CollisionShape2D has no shape assigned**
*Fix:* Students need to click the "Shape" dropdown in Inspector and create a new RectangleShape2D.

## Preparation for Lesson 2
Students will need their working coin class for Lesson 2, where we'll add properties (coin value, coin type, etc.). Make sure all students have:
- Working coin.gd script
- Saved coin.tscn scene  
- At least one coin instance in main.tscn
- Understanding of class vs instance

## Optional Homework/Extension
Ask students to think about other game objects that could be classes:
- Enemies
- Power-ups  
- Weapons
- Buildings

This prepares them for the broader concept that most game objects are instances of classes.
