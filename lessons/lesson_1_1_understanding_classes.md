# Lesson 1.1: Understanding Classes Through Game Objects

## Learning Objectives
By the end of this lesson, you will:
- Understand what a class is and how it defines an object's structure
- Analyze how the existing HealthPotion class works with the Player
- Predict what properties and methods a new class needs
- Create your first Coin class that follows the same patterns
- Experience how classes enable code reuse and organization

## What We're Building
Today we're creating a **Coin pickup system** by studying how the existing HealthPotion works. You'll learn that classes are like "blueprints" that define what objects can do and what information they store. By the end, players will be able to collect coins that increase their gold total!

## Part 1: Code Investigation

### Step 1: Examine the HealthPotion Class
First, let's understand what we already have in our game world.

1. **Run the game** (F5) and move your player into the green health potion
2. **Watch the output console** - what messages appear?
3. **Try touching it multiple times** - what happens?

Now let's look at the code that creates this behavior:

4. **Open** `scripts/health_potion.gd`
5. **Read through the entire file** carefully

### Step 2: Predict Behavior
Before we analyze the code, answer these prediction questions:

**Class Structure Questions:**
- What does `extends Area2D` tell us about this class?
- What does `class_name HealthPotion` accomplish?
- Why might the class extend Area2D instead of Node2D?

**Properties Questions:**
- What information does each HealthPotion store about itself?
- How does `@export` change how we can use these properties?
- What would happen if `heal_amount` was 0?

**Method Questions:**
- Which method runs automatically when the game starts?
- Which method runs when something touches the potion?
- What does `body.has_method("heal")` check for before healing?

### Step 3: Test Current State
Let's see what happens when the HealthPotion tries to work:

1. **Touch the health potion** with your player
2. **Read the console message** - what does it say about missing methods?
3. **Press SPACE** to see debug info - notice the ❌ for missing heal method

The HealthPotion is trying to call `player.heal()`, but that method doesn't exist yet! We'll add it in a future lesson.

## Part 2: Understanding Classes

### What is a Class?
A **class** is like a blueprint or template that defines:
- **What data** an object can store (properties/variables)
- **What actions** an object can perform (methods/functions)
- **How objects** of this type behave in the game world

### Code Examples
Here's how the pattern works in our HealthPotion:

```gdscript
# This creates a new type of object called "HealthPotion"
extends Area2D
class_name HealthPotion

# These are PROPERTIES - data that each potion stores
@export var heal_amount: int = 30
@export var auto_pickup: bool = true

# This is a METHOD - an action the potion can perform
func _on_body_entered(body):
	# Code that runs when something touches this potion
	if body is Player:
		# Try to heal the player
		if body.has_method("heal"):
			body.heal(heal_amount)  # Call the player's heal method
```

### Key Concepts
- **Class Declaration**: `class_name HealthPotion` makes this a reusable blueprint
- **Properties**: `heal_amount` and `auto_pickup` store data about each potion
- **Methods**: `_on_body_entered()` defines what happens during collisions
- **Object Communication**: The potion calls methods on other objects (the player)

## Part 3: Building Your Coin Class

### Step 4: Create the Coin Script
Now you'll create a similar class for coins that players can collect for gold.

1. **Create** a new script: `scripts/coin.gd`
2. **Start with this foundation**:

```gdscript
extends Area2D
class_name Coin

# TODO: Add coin properties here
# Hint: What information should each coin store?
# Look at HealthPotion's properties for inspiration


func _ready():
    print("Coin created - worth ??? gold")  # TODO: Fix this message
    # TODO: Connect the collision signal
    # Hint: Look at how HealthPotion connects its signal

func _on_body_entered(body):
    # TODO: Check if the touching object is a Player
    # TODO: Try to give the player gold (similar to how potion gives health)
    # TODO: Print appropriate messages
    # TODO: Remove the coin after pickup (if successful)
    pass

# TODO: Add a manual coin collection method
# Hint: HealthPotion has use_potion() - what would be similar for coins?
```

### Step 5: Add Coin Properties
Based on the HealthPotion pattern, add these properties after the `class_name` line:

```gdscript
# Coin properties - what data should each coin store?
@export var gold_value: int = 10
@export var auto_pickup: bool = true
```

**Think about it**: Why do we use `@export` for these properties? What will this let us do in the Godot editor?

### Step 6: Implement _ready() Method
Complete the `_ready()` method to match the HealthPotion pattern:

```gdscript
func _ready():
	# TODO: Print a message showing the coin's gold value
	# TODO: Connect the collision signal to _on_body_entered
	# Hint: Copy the pattern from HealthPotion but change method name
```

**Remember**: Functions should return something when possible. What should `_ready()` return? In this case, `_ready()` is a special Godot method that doesn't need a return value.

### Step 7: Complete the Collision Method
Fill in the `_on_body_entered()` method. Follow the same pattern as HealthPotion:

```gdscript
func _on_body_entered(body):
    # TODO: Check if body is Player
    # TODO: Print message about finding coin
    # TODO: Check if player has method for receiving gold (similar to heal check)
    # TODO: If method exists, call it with gold_value
    # TODO: Print success message
    # TODO: Remove coin if auto_pickup is true
	# TODO: If method doesn't exist, print helpful message
```

**Key Question**: What method should the coin try to call on the player? If HealthPotion calls `player.heal()`, what should Coin call?

### Step 8: Add Manual Collection Method
Following the HealthPotion's `use_potion()` pattern, create a similar method:

```gdscript
func collect_coin(player: Player) -> bool:
    # TODO: Check if player has the gold-receiving method
    # TODO: If yes, give gold and remove coin, return true
    # TODO: If no, return false
    # Hint: This should return bool to indicate success/failure
```

**Why return bool?** This follows our function design philosophy - the caller can check if collection was successful!

## Part 4: Testing Your Coin Class

### Step 9: Create the Coin Scene
1. **Create** a new scene: `scenes/coin.tscn`
2. **Add** these nodes:
   - **Area2D** (root node, rename to "Coin")
   - **CollisionShape2D** (child of Area2D)
   - **Sprite2D** (child of Area2D) or **ColorRect** for simple visualization

3. **Configure the nodes**:
   - **CollisionShape2D**: Add a CircleShape2D or RectangleShape2D
   - **Sprite2D**: Add a coin texture, or use ColorRect with yellow color
   - **Root Area2D**: Attach your `coin.gd` script

4. **Save** the scene

### Step 10: Add Coin to Game World
1. **Open** `scenes/main.tscn`
2. **Instance** your coin scene (Scene → Instance Child Scene)
3. **Position** the coin away from the player and health potion
4. **Save** the main scene

### Step 11: Test the Current State
1. **Run the game**
2. **Move to the coin** and touch it
3. **Check the console output** - what messages appear?
4. **Compare** the coin messages to the health potion messages

You should see a message about the player missing a gold/coin collection method - just like the health potion!

## Part 5: Understanding Object Communication

### Step 12: Analyze the Pattern
Look at both your Coin class and the HealthPotion class side by side.

**Similarities you should notice**:
- Both extend Area2D for collision detection
- Both have @export properties for their values
- Both connect collision signals in _ready()
- Both check if the player has appropriate methods
- Both try to call methods on the player object
- Both remove themselves after successful use

**Differences**:
- HealthPotion works with health, Coin works with gold
- Different property names (heal_amount vs gold_value)
- Different method calls (heal vs add_gold or receive_gold)

### Communication Pattern
Both classes follow this pattern:
1. **Detect collision** with player
2. **Check if player can respond** (`has_method()`)
3. **Call appropriate player method** if it exists
4. **Handle the result** (remove item, show messages)

This is called **object communication** - objects calling methods on other objects to make things happen in the game.

## Reflection Questions

Write down or discuss your answers:

1. **Class Purpose**: What is the main job of the Coin class? How is it similar to and different from HealthPotion?

2. **Property Design**: Why do we store `gold_value` as a property instead of hard-coding the value in the method?

3. **Method Naming**: What method name did you choose for the player to receive gold? Why?

4. **Return Values**: Why does `collect_coin()` return a bool? How could this be useful?

5. **Code Reuse**: How much code is similar between Coin and HealthPotion? What does this suggest about class design?

6. **Future Thinking**: If we wanted to create a MagicPotion class, what would it have in common with HealthPotion and Coin?

## Deliverables
By the end of this lesson, you should have:
- [ ] A complete Coin class with properties and methods
- [ ] A working coin scene that can be placed in the game world
- [ ] Console messages showing coin detection (even though pickup doesn't work yet)
- [ ] Understanding of the class structure pattern used by both HealthPotion and Coin
- [ ] Written answers to all reflection questions
- [ ] Recognition that both classes are waiting for player methods to be completed

## Next Lesson Preview
In Lesson 1.2, we'll add **more properties** to our classes! We'll give coins different values (copper, silver, gold coins), add rarity levels to health potions, and learn how properties make each instance of a class unique. We'll also start adding the missing player methods so our pickups actually work!

**Sneak Peek**: You'll create a Silver Coin worth 25 gold and a Rare Health Potion that heals 50 HP, all using the same class blueprints but with different property values!

## Troubleshooting

**"My coin scene won't run"**
- Check that you attached the coin.gd script to the root Area2D node
- Make sure you saved both the script and the scene
- Verify the CollisionShape2D has an actual shape assigned

**"No collision detection happening"**
- Ensure the collision signal is connected in `_ready()`
- Check that your CollisionShape2D has a shape (not empty)
- Make sure the coin scene is actually instantiated in main.tscn

**"Console shows no messages"**
- Verify you have print statements in your methods
- Check that `_ready()` is actually running
- Make sure the script is attached to the correct node

**"Code looks too similar to HealthPotion"**
- This is intentional! You're learning the class pattern
- The similarity shows you understand the structure
- Later lessons will show you how to reduce duplication with inheritance

Great work creating your first class! You've discovered the fundamental pattern that powers object-oriented game development. 🪙✨
