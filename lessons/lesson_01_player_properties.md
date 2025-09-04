# Lesson 1: Building Our Player Character - Adding Properties

## Learning Objectives
By the end of this lesson, you will:
- Understand what properties (variables) are and why they're essential in game characters
- Add multiple properties to the Player class with proper naming conventions
- Use @export to make properties visible in the Godot editor
- Understand the difference between different data types (int, float, String, bool)
- See how properties store the "state" of your game character

## Getting Started

### What We're Building Today
We're going to transform our basic Player class into a proper game character with:
- **Health System**: Current health and maximum health
- **Character Stats**: Name, level, damage, and experience
- **Player-Specific Features**: Experience points for leveling up

**Bonus Discovery**: As you test your character, you might notice some mysterious objects in the game world - a red spike and a green potion. Try walking into them and see what messages appear! These will become very important in our next lesson when we add methods to our Player class.

### Why Properties Matter
Think of properties like the "stats" on a character sheet in a role-playing game:
- **Health**: How much damage can the character take?
- **Level**: How powerful is the character?
- **Name**: What should we call this character?
- **Damage**: How much damage does the character deal in combat?

## Part 1: Understanding Our Current Player

### Investigation: What's Already There
Let's examine our current `player.gd` file:

1. **Open** `scripts/player.gd`
2. **Run the game** (F5) and test the movement
3. **Answer these questions:**
   - What property does our Player already have?
   - What does `@export` do to that property?
   - Where can you see/change this property in Godot?

### Current State Analysis
Right now our player can only:
- ✅ Move around the screen
- ❌ Take damage
- ❌ Attack enemies  
- ❌ Level up
- ❌ Have a name or identity

We're going to fix all of that!

## Part 2: Adding Health Properties

### Step 1: Add Health System
We're going to add a health system to our player. **Copy this code exactly** and add it to your `player.gd` file right after the `move_speed` line:

```gdscript
# Health System - Every character needs health!
@export var max_health: int = 100
@export var current_health: int = 100
```

**Your complete player.gd should now look like this:**
```gdscript
extends CharacterBody2D
class_name Player

# Movement
@export var move_speed: float = 200.0

# Health System - Every character needs health!
@export var max_health: int = 100
@export var current_health: int = 100

func _ready():
    print("Player is ready!")

func _physics_process(delta):
    handle_movement()

func handle_movement():
    # Get input direction
    var direction = Vector2.ZERO
    direction.x = Input.get_axis("ui_left", "ui_right") 
    direction.y = Input.get_axis("ui_up", "ui_down")
    
    # Normalize diagonal movement
    if direction.length() > 0:
        direction = direction.normalized()
    
    # Apply movement
    velocity = direction * move_speed
    move_and_slide()
```

### Step 2: Test the Health Properties
1. **Save** your file
2. **Go to the Main scene** (`scenes/main.tscn`)
3. **Click on the Player node** in the scene tree
4. **Look at the Inspector panel** on the right
5. **You should see**: Move Speed, Max Health, and Current Health properties!
6. **Try changing** the Max Health to 150 and Current Health to 75
7. **Run the game** - the changes should be saved!

### Understanding What We Just Did
- `@export` makes properties visible in the Godot editor
- `int` means "integer" - whole numbers only (1, 2, 100, etc.)
- `float` means numbers with decimals (200.0, 3.14, etc.)
- We set **default values** (100) that can be changed per instance

## Part 3: Adding Character Identity

### Step 3: Add Character Name and Level
Add these lines right after your health properties:

```gdscript
# Character Identity - Who is this character?
@export var character_name: String = "Hero"
@export var level: int = 1
```

**Question Time**: Why do you think we use `String` for the name? What other data type could we use for level besides `int`?

### Step 4: Add Combat Stats
Every character in a game needs combat statistics. Add these properties:

```gdscript
# Combat Stats - How strong is this character?
@export var damage: int = 15
@export var experience_points: int = 0
```

**Your player.gd properties section should now look like this:**
```gdscript
# Movement
@export var move_speed: float = 200.0

# Health System - Every character needs health!
@export var max_health: int = 100
@export var current_health: int = 100

# Character Identity - Who is this character?
@export var character_name: String = "Hero"
@export var level: int = 1

# Combat Stats - How strong is this character?
@export var damage: int = 15
@export var experience_points: int = 0
```

## Part 4: Displaying Our Character Info

### Step 5: Add Debug Display in _ready()
Let's make our character introduce themselves when the game starts. **Replace** your `_ready()` function with this:

```gdscript
func _ready():
    print("=== PLAYER CHARACTER CREATED ===")
    print("Name: " + character_name)
    print("Level: " + str(level))
    print("Health: " + str(current_health) + "/" + str(max_health))
    print("Damage: " + str(damage))
    print("Experience: " + str(experience_points))
    print("Move Speed: " + str(move_speed))
    print("================================")
```

### Step 6: Test Your Character Stats
1. **Save** your file
2. **Go to the Player node** in the Main scene
3. **In the Inspector**, try changing some values:
   - Change the character name to your name
   - Set the level to 5
   - Change max_health to 120
   - Set current_health to 80
4. **Run the game** and check the Output tab
5. **You should see** all your character information printed out!

## Part 5: Understanding Data Types

### Data Type Investigation
Look at the properties we created and identify their data types:

| Property | Data Type | Why This Type? |
|----------|-----------|----------------|
| move_speed | `float` | Needs decimal precision for smooth movement |
| max_health | `int` | Health is usually whole numbers |
| current_health | `int` | Health is usually whole numbers |
| character_name | `String` | Names are text |
| level | `int` | Levels are whole numbers |
| damage | `int` | Damage is usually whole numbers |
| experience_points | `int` | Experience is usually whole numbers |

### Data Type Challenge
**What would happen if we used the wrong data type?**
- What if `character_name` was an `int`?
- What if `level` was a `String`?
- What if `move_speed` was an `int` instead of `float`?

**Try this experiment:**
1. Temporarily change `level: int = 1` to `level: String = "1"`
2. Save and run the game
3. What happens in the output? 
4. Change it back to `int`!

## Part 6: Customizing Your Character

### Step 7: Create Different Character Builds
Let's create a few different "character builds" by changing the properties:

**Tank Build** (high health, low speed):
- max_health: 200
- current_health: 200
- damage: 10
- move_speed: 150.0

**Speedster Build** (fast, low health):
- max_health: 60
- current_health: 60
- damage: 20
- move_speed: 350.0

**Balanced Build** (middle ground):
- max_health: 100
- current_health: 100
- damage: 15
- move_speed: 200.0

**Try each build and see how they feel when you play!**

## Part 7: Reflection and Understanding

### Critical Thinking Questions
Write down or discuss your answers:

1. **Property Purpose**: Why do you think we separate `max_health` and `current_health` instead of just having one `health` property?

2. **Data Types**: Give an example of when you'd use each data type:
   - `int`: ________________
   - `float`: ________________
   - `String`: ________________
   - `bool`: ________________ (We haven't used this yet, but can you guess?)

3. **Default Values**: Why do we set default values for our properties? What would happen if we didn't?

4. **Export Benefits**: What's the advantage of using `@export` on our properties?

5. **Future Thinking**: What other properties do you think a player character might need? (We'll add some of these in future lessons!)

## Deliverables
By the end of this lesson, you should have:
- [ ] A Player class with 7 properties (movement, health, identity, combat)
- [ ] All properties properly exported and visible in the Inspector
- [ ] A detailed character introduction that prints when the game starts
- [ ] Tested at least 2 different character builds
- [ ] Written answers to the reflection questions
- [ ] A screenshot showing your character stats in the Output panel

## Next Lesson Preview
In Lesson 2, we'll add **methods** (functions) to our Player class! We'll create:
- `take_damage()` - so our player can be hurt by the red spike
- `heal()` - so our player can recover health from the green potion
- `level_up()` - so our player can gain experience and grow stronger
- `attack()` - so our player can fight back!

**Sneak Peek**: If you explore the game world, you might find a red spike and green potion already waiting for you. Try touching them - you'll see messages about missing methods that we'll add in Lesson 2!

## Troubleshooting

**"I don't see the properties in the Inspector"**
- Make sure you saved the script file
- Check that you used `@export` (not just `export`)
- Try selecting a different node and then the Player node again

**"My output shows weird text"**
- Make sure you used `str()` around numbers when printing
- Check that all your quotes are matched properly
- Verify there are no typos in your variable names

**"The game won't run"**
- Check the Errors tab at the bottom of Godot
- Make sure all lines end with proper punctuation
- Verify you didn't accidentally delete any existing code

## Looking Ahead
As we continue this series, think about this question: *If we wanted to create an Enemy character, what properties would it need?* 

Keep this in mind - we'll revisit this question very soon! 🎮
