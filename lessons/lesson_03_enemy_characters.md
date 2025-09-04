# Lesson 3: Creating Enemy Characters - Building Game Opponents

## Learning Objectives
By the end of this lesson, you will:
- Create a new Enemy class using the patterns you learned with Player
- Understand how different classes can share similar properties and methods
- Implement AI behavior methods for enemy movement and combat
- Experience the relationship between classes in a game system
- Begin to recognize patterns in class design (setting up for inheritance!)

## Getting Started

### What We're Building Today
Remember how we built our Player character with properties and methods? Well, every game needs opponents! We're going to create **Enemy** characters that can:
- **Have health and take damage** (just like Player!)
- **Deal damage to the player** (opposite of Player!)
- **Move and patrol areas** (different from Player)
- **Detect and follow the player** (unique Enemy behavior)

### The Pattern Recognition Challenge
As you work through this lesson, pay attention to similarities between Enemy and Player. Ask yourself:
- *"Didn't I write something like this before?"*
- *"Why am I copying similar code?"*
- *"Is there a better way to handle shared features?"*

Keep these questions in mind - they'll become very important soon! 🤔

## Part 1: Creating the Enemy Class

### Step 1: Create the Enemy Script
1. **Right-click** in the `scripts` folder
2. **Create** a new script called `enemy.gd`
3. **Set it up** with this basic structure:

```gdscript
extends CharacterBody2D
class_name Enemy

# TODO: Add properties here (similar to Player, but for enemies!)

func _ready():
    print("Enemy is ready!")
    # TODO: Add enemy introduction

func _physics_process(delta):
    handle_ai()

func handle_ai():
    # TODO: Add AI behavior here
    pass
```

## Part 2: Adding Enemy Properties - The Familiar Pattern

### Step 2: Add Health System (Sound Familiar?)
**Think back to Lesson 1** - what properties did our Player need for health? Enemies need the same thing!

Add these properties to your Enemy class:

```gdscript
# Health System - Every character needs health! (just like Player)
@export var max_health: int = 80
@export var current_health: int = 80
```

**Reflection Question**: Why might enemies have different default health than players?

### Step 3: Add Character Identity (Getting Repetitive?)
**Remember** how we gave our Player a name and level? Enemies need identity too:

```gdscript
# Character Identity - Who is this enemy?
@export var character_name: String = "Goblin"
@export var level: int = 1
```

### Step 4: Add Combat Stats (Definitely Repetitive!)
**Think about** the Player's combat properties - enemies need these too:

```gdscript
# Combat Stats - How dangerous is this enemy?
@export var damage: int = 20
@export var experience_points: int = 50  # How much EXP player gains when defeating this enemy
```

**Notice anything?** You just wrote almost the exact same properties as your Player class! Keep this feeling in mind...

## Part 3: Adding Enemy-Specific Properties

### Step 5: Add AI Properties
Unlike players (controlled by humans), enemies need AI behavior properties:

```gdscript
# AI Behavior - How does this enemy think?
@export var patrol_range: float = 200.0
@export var detection_radius: float = 150.0
@export var ai_speed: float = 120.0

# AI State Tracking
var target_player: Player = null
var ai_state: String = "patrol"  # patrol, chase, attack
var patrol_center: Vector2
var patrol_direction: int = 1
```

### Step 6: Add Enemy Introduction
**Similar to Player**, let's make enemies introduce themselves. Replace your `_ready()` function:

```gdscript
func _ready():
    print("=== ENEMY CHARACTER CREATED ===")
    print("Name: " + character_name)
    print("Level: " + str(level))
    print("Health: " + str(current_health) + "/" + str(max_health))
    print("Damage: " + str(damage))
    print("Detection Radius: " + str(detection_radius))
    print("Patrol Range: " + str(patrol_range))
    print("===================================")
    
    # Remember starting position for patrol
    patrol_center = global_position
```

## Part 4: Adding Methods - More Familiar Territory

### Step 7: Add take_damage() Method (Definitely Done This Before!)
**Think back to Lesson 2** - what did the Player's `take_damage()` method do? Enemies need the exact same functionality:

```gdscript
func take_damage(amount: int):
    print(character_name + " takes " + str(amount) + " damage!")
    
    # Reduce health (just like Player)
    current_health -= amount
    if current_health < 0:
        current_health = 0
    
    # Display current status
    print(character_name + " health: " + str(current_health) + "/" + str(max_health))
    
    # Check if enemy is defeated
    if current_health <= 0:
        print("💀 " + character_name + " has been defeated!")
        die()
    else:
        # Calculate health percentage for feedback
        var health_percent = (current_health * 100) / max_health
        if health_percent <= 25:
            print("⚠️ " + character_name + " is badly hurt!")
        elif health_percent <= 50:
            print("🤕 " + character_name + " is injured!")
```

### Step 8: Add die() Method (Copy-Paste Much?)
**Remember** the Player's `die()` method? Enemies need this too (with slight differences):

```gdscript
func die():
    print("=== ENEMY DEFEATED ===")
    print(character_name + " has fallen!")
    print("Player gains " + str(experience_points) + " experience!")
    print("==================")
    
    # Find the player and give them experience
    var player = get_tree().get_first_node_in_group("players")
    if player and player.has_method("gain_experience"):
        player.gain_experience(experience_points)
    
    # Remove this enemy from the game
    queue_free()
```

### Step 9: Add heal() Method (Because Enemies Might Find Potions Too!)
**Just like Player**, enemies might need healing:

```gdscript
func heal(amount: int):
    print(character_name + " healing " + str(amount) + " HP!")
    
    # Store old health for comparison
    var old_health = current_health
    
    # Add health, but don't exceed maximum (same logic as Player)
    current_health += amount
    if current_health > max_health:
        current_health = max_health
    
    # Calculate actual healing done
    var actual_healing = current_health - old_health
    
    # Display results
    print(character_name + " healed " + str(actual_healing) + " HP!")
    print(character_name + " health: " + str(current_health) + "/" + str(max_health))
```

**Stop and Think**: How much code did you just copy from Player? Does this feel efficient? 🤔

## Part 5: Adding Enemy-Specific Methods

### Step 10: Add Player Detection
Now for something uniquely enemy-like:

```gdscript
func detect_player():
    # Look for the player in detection radius
    var space_state = get_world_2d().direct_space_state
    var query = PhysicsRayQueryParameters2D.create(global_position, global_position)
    
    # Simple detection - look for player in group
    var player = get_tree().get_first_node_in_group("players")
    if player:
        var distance = global_position.distance_to(player.global_position)
        if distance <= detection_radius:
            target_player = player
            ai_state = "chase"
            return true
        else:
            if ai_state == "chase":
                ai_state = "patrol"
            target_player = null
    return false
```

### Step 11: Add Movement Methods
```gdscript
func patrol():
    # Simple back-and-forth patrol
    var target_pos = patrol_center + Vector2(patrol_range * patrol_direction, 0)
    var direction = (target_pos - global_position).normalized()
    
    # Move toward patrol target
    velocity = direction * ai_speed
    move_and_slide()
    
    # Change direction when reaching patrol boundary
    if global_position.distance_to(target_pos) < 20:
        patrol_direction *= -1

func chase_player():
    if target_player:
        var direction = (target_player.global_position - global_position).normalized()
        velocity = direction * (ai_speed * 1.5)  # Faster when chasing
        move_and_slide()

func attack_player():
    if target_player and target_player.has_method("take_damage"):
        print(character_name + " attacks " + target_player.character_name + "!")
        target_player.take_damage(damage)
```

### Step 12: Complete the AI System
Update your `handle_ai()` function:

```gdscript
func handle_ai():
    # Always look for the player
    detect_player()
    
    # Behave based on current state
    match ai_state:
        "patrol":
            patrol()
        "chase":
            chase_player()
            # Attack if close enough
            if target_player and global_position.distance_to(target_player.global_position) < 50:
                ai_state = "attack"
        "attack":
            attack_player()
            # Return to chase if player moves away
            if target_player and global_position.distance_to(target_player.global_position) > 80:
                ai_state = "chase"
```

## Part 6: Creating and Testing Your Enemy

### Step 13: Create Enemy Scene
1. **Create** a new scene (`scenes/enemy.tscn`)
2. **Add** a CharacterBody2D as root node
3. **Add** a CollisionShape2D child (with a RectangleShape2D)
4. **Add** a ColorRect child for visual representation (make it red!)
5. **Attach** your `enemy.gd` script to the root node
6. **Save** the scene

### Step 14: Add Enemy to Game World
1. **Open** `scenes/main.tscn`
2. **Instance** your Enemy scene in the world
3. **Move it** to a different location from the player
4. **Add the Player to the "players" group**:
   - Select Player node
   - Go to Groups tab (next to Inspector)
   - Add "players" group

### Step 15: Test Your Enemy
1. **Run the game**
2. **Observe** the enemy patrol behavior
3. **Get close** to trigger chase mode
4. **Let the enemy attack** you - does it work?
5. **Attack the enemy** (if you implemented Player attack in Lesson 2)

## Part 7: The Duplication Realization

### Reflection Exercise: Code Comparison
**Open both files side by side**: `player.gd` and `enemy.gd`

**Count the duplicated code**:
1. How many properties are identical between Player and Enemy?
2. How many methods have identical logic?
3. What percentage of Enemy code is copied from Player?

**Properties Shared**:
- [ ] max_health, current_health
- [ ] character_name, level  
- [ ] damage, experience_points

**Methods Shared**:
- [ ] take_damage() - nearly identical
- [ ] heal() - nearly identical
- [ ] die() - very similar logic

### The Big Questions
1. **Maintenance Problem**: If you wanted to change how health works, how many files would you need to update?
2. **New Character Problem**: If you wanted to add an NPC class, how much code would you copy again?
3. **Bug Problem**: If there's a bug in the take_damage() logic, where all would you need to fix it?

### The "Copy-Paste Code Smell"
What you're experiencing is called "code duplication" - it's a sign that there might be a better way to structure your code. Keep this feeling in mind! 

**The frustrating questions**:
- *"Why am I writing the same code over and over?"*
- *"Isn't there a way to share this common functionality?"*
- *"What if I want to add 10 more character types?"*

## Part 8: Extending the Pattern

### Challenge: Create Different Enemy Types
Create variations of your enemy with different properties:

**Tank Enemy**:
- max_health: 150
- damage: 25
- ai_speed: 80.0
- character_name: "Orc Warrior"

**Fast Enemy**:
- max_health: 40
- damage: 15
- ai_speed: 200.0
- character_name: "Shadow Runner"

**Strong Enemy**:
- max_health: 100
- damage: 35
- ai_speed: 90.0
- character_name: "Stone Giant"

**Notice**: You're copying the same class structure for each type! This is getting repetitive...

## Part 9: Advanced AI Behaviors (Optional)

### Step 16: Add Group Behavior (Optional Challenge)
```gdscript
func call_for_help():
    # Alert nearby enemies when taking damage
    var nearby_enemies = get_tree().get_nodes_in_group("enemies")
    for enemy in nearby_enemies:
        var distance = global_position.distance_to(enemy.global_position)
        if distance < 300 and enemy != self:
            enemy.ai_state = "chase"
            enemy.target_player = target_player

# Add this to your take_damage() method:
func take_damage(amount: int):
    # ... existing code ...
    
    # Call for help when injured
    if current_health < max_health * 0.5:
        call_for_help()
```

## Deliverables
By the end of this lesson, you should have:
- [ ] A complete Enemy class with health, combat, and identity properties
- [ ] Enemy-specific AI properties for patrol and detection
- [ ] Methods for damage, healing, and death (copied from Player!)
- [ ] AI methods for patrol, chase, and attack behavior
- [ ] A working enemy that can be placed in your game world
- [ ] Recognition of code duplication between Player and Enemy
- [ ] At least 2 different enemy variants tested

## Next Lesson Preview - The Solution to Duplication!
In our next lessons, we'll learn about **inheritance** - a programming concept that will solve the code duplication problem you just experienced! 

**Spoiler alert**: Instead of copying health and damage methods between Player and Enemy, we'll create a **Character** base class that both Player and Enemy can **inherit** from. This means:
- ✅ Write health system **once**
- ✅ Write take_damage() method **once**  
- ✅ Add new character types **easily**
- ✅ Fix bugs in **one place**

The duplication pain you felt today was intentional - it's setting up the "ah-ha!" moment when inheritance saves the day!

## Troubleshooting

**"Enemy won't chase the player"**
- Check that Player is in the "players" group
- Verify detection_radius is large enough
- Make sure enemy isn't stuck on collision

**"Methods aren't working"**
- Check spelling of method names carefully
- Make sure Player has the methods Enemy is trying to call
- Verify class_name is set for both Player and Enemy

**"Too much copied code!"**
- This feeling is **correct**! Keep it in mind for the next lesson
- Document what code is duplicated - this will help in inheritance lesson

## Reflection Questions
Write down or discuss:

1. **Code Quality**: How did it feel to copy-paste so much code from Player?
2. **Maintenance**: What would happen if you needed to change how health works?
3. **Scalability**: How would you feel about creating 10 more character types this way?
4. **Solutions**: Can you think of any ways to reduce the code duplication?
5. **Patterns**: What similarities do you see between Player and Enemy classes?

**Keep these questions in mind** - they're leading somewhere important! 🎯
