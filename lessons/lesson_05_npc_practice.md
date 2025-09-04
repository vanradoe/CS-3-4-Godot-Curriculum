# Lesson 5: NPC Practice - Applying Inheritance

## Learning Objectives
By the end of this lesson, you will:
- Practice creating classes that inherit from Character with less guidance
- Build confidence in applying inheritance patterns independently  
- Create an NPC character that will serve as foundation for future quest systems
- Understand how to override parent methods while still using parent functionality
- Experience the speed and ease of creating new character types with inheritance

## Getting Started

### What We're Building Today
Now that you understand inheritance, it's time to practice! You'll create a **Non-Player Character (NPC)** that:
- **Inherits** all the health and combat functionality from Character
- **Has its own unique** appearance, stats, and behavior
- **Doesn't move around** like Player or patrol like Enemy
- **Can interact** with the Player (foundation for future quest system)
- **Dies differently** than Player or Enemy when defeated

### The Confidence Builder
**Remember Lesson 3?** Creating Enemy took forever because you had to copy all that code from Player.

**Today's Goal**: Create a complete NPC character in **less than 20 minutes** using inheritance! You'll see how much faster character creation becomes when you understand the pattern.

## Part 1: Planning Your NPC

### Step 1: Analyze What You Need
**Before writing code**, think about what makes an NPC different from Player and Enemy:

**NPC Characteristics**:
- ✅ Has health (same as Player/Enemy) → **Inherit from Character**
- ✅ Can take damage (same as Player/Enemy) → **Inherit from Character**  
- ✅ Can be healed (same as Player/Enemy) → **Inherit from Character**
- ❌ Doesn't move around → **Override `_physics_process()`**
- ❌ Dies differently → **Override `die()` method**
- ✅ Has unique stats → **Set in `_ready()` method**
- ✅ Can talk to player → **Add new `interact()` method**

**Planning Question**: Which parts will you inherit and which parts will you create from scratch?

### Step 2: Design Your NPC
Choose what kind of NPC you want to create:

**Village Elder** (Wise, Fragile):
- High wisdom, low health
- Gives good advice but can't fight
- Dies with dignity

**Shopkeeper** (Merchant, Cautious):
- Medium health, focuses on commerce
- Has items to sell (future lesson!)
- Dies worried about their shop

**Guard** (Strong, Protective):
- High health, medium damage
- Protects the village
- Dies heroically

**Your Choice**: Pick one or create your own NPC concept!

## Part 2: Creating the NPC Class

### Step 3: Set Up the NPC File
1. **Create** a new script: `scripts/npc.gd`
2. **Start with** the inheritance structure (remember the pattern from Player/Enemy):

```gdscript
extends Character
class_name NPC

# What properties does an NPC need that Character doesn't provide?
# Think about this before adding properties!

func _ready():
    # TODO: Set NPC-specific values
    # TODO: Call parent _ready()
    pass

func _physics_process(delta):
    # TODO: How should NPCs handle physics? (Hint: they don't move!)
    pass

# TODO: Override die() method for NPC-specific death
# TODO: Add interact() method for player communication
```

**Planning Challenge**: Before writing the TODO sections, write down:
1. What properties should this NPC have different from the Character defaults?
2. How should the NPC's death be different from Player (restart game) or Enemy (give EXP)?
3. What should happen when the player interacts with this NPC?

### Step 4: Configure NPC Properties and Behavior
**Now fill in your TODOs**. Here's guidance, but try to write the code yourself first:

**For `_ready()` method** - Set your NPC's unique characteristics:
```gdscript
func _ready():
    # Set NPC-specific values (choose your own!)
    character_name = "Village Elder"  # Pick your own name
    max_health = 60                   # NPCs might be more fragile
    current_health = 60
    damage = 5                        # NPCs aren't fighters  
    move_speed = 50.0                 # Slow and steady
    level = 3                         # Older and wiser
    experience_points = 0             # NPCs don't give EXP when killed
    
    # Don't forget this important line!
    super._ready()
```

**For `_physics_process()` method** - How should NPCs move?
```gdscript
func _physics_process(delta):
    # NPCs don't move around - they stay in one place
    # What should you put here? (Hint: NPCs are stationary)
    pass
```

**Challenge**: Can you figure out what goes in `_physics_process()` for a stationary NPC?

### Step 5: Override the die() Method
**Think about** how NPCs should die differently:
- **Player dies** → Game restarts
- **Enemy dies** → Gives EXP to player  
- **NPC dies** → What should happen?

**Try writing the `die()` method yourself** before looking at the hint:

<details>
<summary>💡 Click for hint if you're stuck</summary>

```gdscript
func die():
    print("=== NPC DEATH ===")
    print("Oh no! " + character_name + " has been killed!")
    print("The village mourns the loss of " + character_name)
    print("NPCs are peaceful - why would you do this?")
    print("================")
    
    # NPCs don't restart the game or give EXP - they just disappear sadly
    queue_free()
```

</details>

### Step 6: Add NPC Interaction
**Create a method** that lets the player talk to the NPC:

```gdscript
func interact():
    print("=== TALKING TO " + character_name.to_upper() + " ===")
    
    # Different NPCs can say different things
    match character_name:
        "Village Elder":
            print(character_name + ": 'Welcome, young adventurer!'")
            print(character_name + ": 'This village has been peaceful for many years.'")
            print(character_name + ": 'But lately, strange creatures have appeared...'")
        "Shopkeeper":
            print(character_name + ": 'Welcome to my shop!'")
            print(character_name + ": 'I have many fine wares, but times are dangerous.'")
            print(character_name + ": 'Please, help keep our village safe!'")
        "Guard":
            print(character_name + ": 'Halt! State your business!'")
            print(character_name + ": '...Oh, you're here to help? Good!'")
            print(character_name + ": 'We need brave adventurers like you.'")
        _:  # Default case for any other NPC name
            print(character_name + ": 'Hello there, traveler!'")
            print(character_name + ": 'I hope you can help our village.'")
    
    print("========================================")
```

**Customization Challenge**: Change the dialogue to match your NPC concept!

## Part 3: Creating and Testing Your NPC

### Step 7: Create the NPC Scene
1. **Create** a new scene (`scenes/npc.tscn`)
2. **Add** a CharacterBody2D as root node
3. **Add** a CollisionShape2D child (with a RectangleShape2D or CircleShape2D)
4. **Add** a visual representation:
   - ColorRect (make it a different color - maybe blue or yellow?)
   - OR add a Sprite2D if you have an NPC image
5. **Attach** your `npc.gd` script to the root node
6. **Save** the scene

### Step 8: Add NPC to Game World
1. **Open** `scenes/main.tscn`
2. **Instance** your NPC scene in the world
3. **Position it** somewhere safe (away from the spike!)
4. **Add the NPC to a group** (for easy finding later):
   - Select the NPC node
   - Go to Groups tab (next to Inspector)  
   - Add "npcs" group

### Step 9: Test Your NPC
1. **Save** all files and **run the game**
2. **Check the console** - does your NPC introduce itself?
3. **Move the player** near the NPC - does it stay still?
4. **Test damage** (if you're brave):
   - Push the NPC into the spike
   - Does it take damage using Character's `take_damage()` method?
   - Does it die with your custom message?

## Part 4: Adding Player-NPC Interaction

### Step 10: Add Interaction Detection
**Add this method** to your NPC to detect when the player is nearby:

```gdscript
func _physics_process(delta):
    # NPCs don't move, but they can detect nearby players
    check_for_player_interaction()

func check_for_player_interaction():
    # Look for player within talking distance
    var player = get_tree().get_first_node_in_group("players")
    if player:
        var distance = global_position.distance_to(player.global_position)
        
        # If player is close and presses a key, start talking
        if distance < 80.0:  # Talking distance
            if Input.is_action_just_pressed("ui_accept"):  # Enter/Space key
                interact()
```

### Step 11: Test the Interaction
1. **Run the game**
2. **Move your player** close to the NPC
3. **Press ENTER or SPACE** when near the NPC
4. **Does the NPC start talking?**

**Bonus Challenge**: Add a visual hint when the player can interact (like "Press SPACE to talk" message).

## Part 5: Inheritance Verification

### Step 12: Prove Inheritance is Working
**Test these scenarios** to verify your NPC properly inherits from Character:

**Health System Test**:
1. **Run the game**
2. **Push your NPC into the spike** (sorry, NPC!)
3. **Verify** that:
   - ✅ NPC takes damage using Character's `take_damage()` method
   - ✅ Health decreases and messages appear
   - ✅ NPC dies with YOUR custom death message

**Healing Test** (if your NPC survives the spike):
1. **Push your NPC into the health potion**
2. **Verify** that:
   - ✅ NPC heals using Character's `heal()` method
   - ✅ Health increases and healing messages appear

**Property Test**:
1. **Select your NPC** in the main scene
2. **Look at the Inspector**
3. **Verify** you can see:
   - ✅ Max Health, Current Health (inherited from Character)
   - ✅ Character Name, Level (inherited from Character)
   - ✅ Damage, Move Speed (inherited from Character)

### Step 13: Code Comparison
**Open both files** side by side: `character.gd` and `npc.gd`

**Count the code**:
- **Lines in NPC**: ~40-50 lines
- **Inherited functionality**: Health system, take_damage(), heal(), character properties
- **Original code**: Only interact(), die() override, and property customization

**Compare to Lesson 3**: How much less code did you write compared to creating Enemy?

## Part 6: Creating NPC Variations

### Challenge: Create Different NPC Types
**Now that you understand the pattern**, create variations quickly:

**Wise Sage** (High-level, Fragile):
```gdscript
# In _ready() method:
character_name = "Ancient Sage"
max_health = 40
current_health = 40
damage = 3
level = 15
move_speed = 30.0
```

**Tough Blacksmith** (Strong, Slow):
```gdscript
# In _ready() method:
character_name = "Master Smith"
max_health = 120
current_health = 120
damage = 25
level = 8
move_speed = 60.0
```

**Quick Messenger** (Fast, Nervous):
```gdscript
# In _ready() method:
character_name = "Village Runner"
max_health = 70
current_health = 70
damage = 8
level = 4
move_speed = 150.0  # Even though NPCs don't move, this shows character concept
```

**Speed Test**: How fast can you create a new NPC variant? (Should be under 5 minutes!)

## Part 7: Reflection and Understanding

### Understanding What You Accomplished
**You just**:
- ✅ Created a complete character class in ~20 minutes (vs 1+ hours in Lesson 3)
- ✅ Reused ALL the health/damage/healing logic without copying code
- ✅ Added unique behavior (interaction) without breaking inheritance
- ✅ Customized character stats through property overrides
- ✅ Practiced method overriding (`die()`) while using parent methods (`_ready()`)

### Inheritance Confidence Check
**Rate your confidence** (1-10) on:
- Understanding what `extends Character` does: ___/10
- Knowing when to use `super._ready()`: ___/10  
- Creating new character types quickly: ___/10
- Overriding methods while keeping parent functionality: ___/10

**If any score is below 7**, review the relevant section or ask questions!

## Part 8: Future Quest System Foundation

### Step 14: Add Quest-Ready Methods (Optional Advanced)
**Your NPC is ready** to become a quest giver! Add these foundation methods:

```gdscript
# Quest system foundation (we'll expand this in future lessons)
var has_quest: bool = true
var quest_completed: bool = false

func give_quest():
    if has_quest and not quest_completed:
        print(character_name + " has a quest for you!")
        print("Quest: 'Clear the village of dangerous creatures'")
        print("Reward: The gratitude of our people!")
        return true
    elif quest_completed:
        print(character_name + ": 'Thank you for your help, hero!'")
        return false
    else:
        print(character_name + ": 'I have no quests right now.'")
        return false

# Modify your interact() method to include quest giving:
func interact():
    print("=== TALKING TO " + character_name.to_upper() + " ===")
    
    # Show dialogue first
    print(character_name + ": 'Welcome, young adventurer!'")
    print(character_name + ": 'Our village needs your help!'")
    
    # Then offer quest
    give_quest()
    
    print("========================================")
```

**Future Lesson Preview**: This foundation will let us build a complete quest system!

## Deliverables
By the end of this lesson, you should have:
- [ ] A complete NPC class that inherits from Character
- [ ] NPC with custom stats, behavior, and dialogue
- [ ] Working player-NPC interaction system
- [ ] NPC that properly uses inherited health/damage/healing systems
- [ ] At least 2 different NPC variants tested
- [ ] Confidence in creating new character types using inheritance
- [ ] Foundation code ready for future quest system

## Next Lesson Preview - Pickup Items Inheritance!
**Get ready for** the next major inheritance practice! We'll take that health potion you've been using and refactor it into a **Pickup inheritance system**:

- **Pickup** base class (shared pickup behavior)
- **HealthPotion** inherits from Pickup (healing items)
- **Coin** inherits from Pickup (currency items)  
- **ExperienceGem** inherits from Pickup (XP boost items)

**This time**: You'll have even LESS scaffolding because you're getting good at inheritance!

## Troubleshooting

**"NPC won't talk to player"**
- Check that Player is in the "players" group
- Verify `ui_accept` input map exists (Project → Project Settings → Input Map)
- Make sure distance check (<80.0) is reasonable for your game scale

**"NPC doesn't inherit properties"**
- Verify `extends Character` is the first line
- Check that `character.gd` has `class_name Character`
- Make sure you're calling `super._ready()`

**"NPC moves when it shouldn't"**
- Check `_physics_process()` method - should be empty or just have `pass`
- Don't call `move_and_slide()` in NPC physics process

**"Inheritance not working"**
- Save all files and reload project if necessary
- Check console for error messages
- Verify Character class compiles without errors first

## Reflection Questions
Write down or discuss:

1. **Speed**: How much faster was creating NPC compared to creating Enemy in Lesson 3?
2. **Confidence**: Do you feel more comfortable with inheritance after this practice?
3. **Code Quality**: How much code did you NOT have to write thanks to inheritance?
4. **Understanding**: Can you explain to someone else how NPC inherits from Character?
5. **Future Planning**: What other character types could you create using this same pattern?

## The Growing Pattern
**You've now mastered**:
- ✅ Creating base classes with shared functionality
- ✅ Inheriting properties and methods from parent classes  
- ✅ Overriding parent methods while still calling parent functionality
- ✅ Customizing inherited classes with unique behavior
- ✅ Building new character types rapidly and efficiently

**You're ready** for the next inheritance challenge - Pickup Items! 🎮
