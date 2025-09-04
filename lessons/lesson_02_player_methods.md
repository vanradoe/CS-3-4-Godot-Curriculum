# Lesson 2: Adding Methods to Our Player Character

## Learning Objectives
By the end of this lesson, you will:
- Understand what methods (functions) are and how they work in classes
- Read and analyze existing code to understand method calling
- Implement essential character methods: `take_damage()`, `heal()`, `level_up()`
- See immediate results as your methods interact with game objects
- Understand the relationship between method calls and object behavior

## Getting Started

### What We're Building Today
We're going to add **behavior** to our Player character by creating methods that:
- **Respond to damage** from the red spike
- **Handle healing** from the green potion  
- **Manage leveling up** when gaining experience
- **Display current status** for debugging

### Discovering the Test Objects
Before we write methods, let's explore what's already in our game world.

## Part 1: Code Investigation - Understanding Existing Methods

### Step 1: Run and Explore
1. **Run your game** (F5)
2. **Move your player** into the **red spike** - what happens?
3. **Move your player** into the **green potion** - what happens?
4. **Press SPACE** - what debug information appears?
5. **Look at the console output** - what messages do you see?

### Step 2: Read the Spike Code
Open `scripts/spike.gd` and examine the code. **Don't change anything** - just read and understand.

**Code Analysis Questions - Answer These:**

1. **Method Identification**: 
   - What methods (functions) does the Spike class have?
   - Which method runs when the game starts?
   - Which method runs when something touches the spike?

2. **Method Calling**:
   - Look at line `body.take_damage(damage_amount)` - what is this doing?
   - What does `body.has_method("take_damage")` check for?
   - Why do you think the code checks if the method exists before calling it?

3. **Data Flow**:
   - What property controls how much damage the spike deals?
   - What prevents the spike from dealing damage multiple times per second?
   - What type of object can take damage from this spike?

4. **Conditional Logic**:
   - What two conditions must be true for the spike to deal damage?
   - What happens if the player doesn't have a `take_damage()` method?

### Step 3: Read the Health Potion Code  
Open `scripts/health_potion.gd` and examine it.

**Code Analysis Questions - Answer These:**

1. **Method Purpose**:
   - What does the health potion's `_on_body_entered()` method do?
   - What method is the potion trying to call on the player?
   - What happens to the potion after it's used successfully?

2. **Method Parameters**:
   - What parameter does the `heal()` method expect?
   - Where does `heal_amount` come from?

3. **Object Destruction**:
   - What does `queue_free()` do?
   - When does the potion get destroyed?

4. **Alternative Usage**:
   - What is the `use_potion()` method for?
   - How is it different from the automatic pickup system?

### Step 4: Understanding the Pattern
Both objects are trying to call methods on the Player that **don't exist yet**:
- Spike wants to call: `player.take_damage(25)`
- Health Potion wants to call: `player.heal(30)`

**Your job**: Create these methods so the objects will work!

## Part 2: Implementing take_damage() Method

### Step 5: Add the take_damage() Method
Add this method to your `player.gd` file, right after the `handle_movement()` method:

```gdscript
func take_damage(amount: int):
    print("Player taking " + str(amount) + " damage!")
    
    # Reduce current health
    current_health -= amount
    
    # Make sure health doesn't go below 0
    if current_health < 0:
        current_health = 0
    
    # Display current status
    print("Player health: " + str(current_health) + "/" + str(max_health))
    
    # Check if player is defeated
    if current_health <= 0:
        print("💀 Player has been defeated!")
        die()
    else:
        # Calculate health percentage for feedback
        var health_percent = (current_health * 100) / max_health
        if health_percent <= 25:
            print("⚠️ Player is badly hurt!")
        elif health_percent <= 50:
            print("🤕 Player is injured!")
```

### Understanding the take_damage() Method
**Method Breakdown Questions:**

1. **Parameter**: What does `amount: int` mean?
2. **Health Calculation**: Why do we check if `current_health < 0`?
3. **Method Calling**: What method gets called when health reaches 0?
4. **User Feedback**: How does the player know their current health status?

### Step 6: Add the die() Method
The `take_damage()` method calls `die()` when health reaches 0. Add this method:

```gdscript
func die():
    print("=== GAME OVER ===")
    print(character_name + " has fallen in battle!")
    print("Final Stats:")
    print("Level: " + str(level))
    print("Experience: " + str(experience_points))
    print("================")
    
    # TODO: Add actual game over logic later
    # For now, just restart the scene
    get_tree().reload_current_scene()
```

## Part 3: Implementing heal() Method

### Step 7: Add the heal() Method
Add this method after your `die()` method:

```gdscript
func heal(amount: int):
    print("Player healing " + str(amount) + " HP!")
    
    # Store old health for comparison
    var old_health = current_health
    
    # Add health, but don't exceed maximum
    current_health += amount
    if current_health > max_health:
        current_health = max_health
    
    # Calculate actual healing done
    var actual_healing = current_health - old_health
    
    # Display results
    print("Player healed " + str(actual_healing) + " HP!")
    print("Player health: " + str(current_health) + "/" + str(max_health))
    
    # Special message if fully healed
    if current_health == max_health:
        print("✨ Player is fully healed!")
```

### Understanding the heal() Method
**Method Analysis Questions:**

1. **Health Cap**: Why don't we let current_health go above max_health?
2. **Actual Healing**: Why do we calculate `actual_healing` separately?
3. **Edge Case**: What happens if you use a health potion when already at full health?
4. **User Feedback**: How does this method inform the player about the healing?

## Part 4: Testing Your Damage and Healing

### Step 8: Test the Basic Methods
1. **Save** your player.gd file
2. **Run the game**
3. **Test the spike**: Move into the red spike multiple times
   - Watch your health decrease in the console
   - See what happens when health reaches 0
4. **Test healing**: Touch the green potion
   - Watch your health increase
   - Notice the potion disappears after use

### Step 9: Debug Information
Press **SPACE** to see your debug information. You should now see:
- ✅ Player has take_damage() method
- ✅ Player has heal() method
- ❌ Player missing level_up() method (we'll add this next!)

## Part 5: Implementing level_up() Method

### Step 10: Add Experience and Leveling System
Add these methods to complete your character system:

```gdscript
func gain_experience(amount: int):
    print("Player gained " + str(amount) + " experience!")
    experience_points += amount
    
    # Calculate experience needed for next level
    var exp_needed = level * 100  # Simple formula: level 1 needs 100, level 2 needs 200, etc.
    
    print("Experience: " + str(experience_points) + "/" + str(exp_needed))
    
    # Check if player should level up
    if experience_points >= exp_needed:
        level_up()

func level_up():
    print("🎉 LEVEL UP! 🎉")
    print(character_name + " reached level " + str(level + 1) + "!")
    
    # Increase level
    level += 1
    
    # Reset experience (remove what was used to level up)
    experience_points -= (level - 1) * 100
    
    # Increase player power
    max_health += 20
    damage += 5
    
    # Heal player completely on level up
    current_health = max_health
    
    print("New Stats:")
    print("Level: " + str(level))
    print("Max Health: " + str(max_health))
    print("Damage: " + str(damage))
    print("Health fully restored!")
```

### Step 11: Add Manual Testing Method
Add this method for testing the leveling system:

```gdscript
func debug_gain_exp():
    """Debug method to test leveling - gives 50 exp"""
    gain_experience(50)
```

## Part 6: Complete Method Testing

### Step 12: Update _ready() for Better Display
Replace your `_ready()` method with this enhanced version:

```gdscript
func _ready():
    print("=== PLAYER CHARACTER CREATED ===")
    print("Name: " + character_name)
    print("Level: " + str(level))
    print("Health: " + str(current_health) + "/" + str(max_health))
    print("Damage: " + str(damage))
    print("Experience: " + str(experience_points))
    print("Move Speed: " + str(move_speed))
    print("")
    print("🎮 CONTROLS:")
    print("Arrow Keys: Move")
    print("Space: Debug info")
    print("Touch red spike: Take damage")
    print("Touch green potion: Heal")
    print("================================")
```

### Step 13: Add Debug Controls to Game World
Open `scripts/game_world.gd` and update the `_unhandled_input` method:

```gdscript
func _unhandled_input(event):
    # Debug commands for testing character systems
    if event.is_action_pressed("ui_select"):  # Space key
        print("=== DEBUG INFO ===")
        print("Player Name: " + player.character_name)
        print("Player Health: " + str(player.current_health) + "/" + str(player.max_health))
        print("Player Level: " + str(player.level))
        print("Player Experience: " + str(player.experience_points))
        print("Player Damage: " + str(player.damage))
        
        # Check which methods exist
        if player.has_method("take_damage"):
            print("✅ Player has take_damage() method")
        else:
            print("❌ Player missing take_damage() method")
            
        if player.has_method("heal"):
            print("✅ Player has heal() method")  
        else:
            print("❌ Player missing heal() method")
            
        if player.has_method("level_up"):
            print("✅ Player has level_up() method")
        else:
            print("❌ Player missing level_up() method")
            
        print("==================")
    
    # Secret debug command for testing experience
    if event.is_action_pressed("ui_accept"):  # Enter key
        print("🧪 DEBUG: Giving player 50 experience")
        player.gain_experience(50)
```

### Step 14: Final Testing Sequence
**Complete Test Walkthrough:**

1. **Run the game** and read the enhanced startup message
2. **Press SPACE** - verify all methods show ✅
3. **Test damage**: Touch the spike several times, watch health decrease
4. **Test healing**: Touch the potion, watch health increase
5. **Test leveling**: Press ENTER multiple times to gain experience and level up
6. **Test death**: Take enough damage to reach 0 health
7. **Test level benefits**: After leveling up, notice increased max health and damage

## Part 7: Understanding Method Relationships

### Method Calling Chain Analysis
Look at how your methods work together:

1. **Spike calls** → `take_damage()` → **might call** → `die()`
2. **Potion calls** → `heal()` → **displays status**
3. **Debug calls** → `gain_experience()` → **might call** → `level_up()`
4. **level_up()** → **calls** → `heal()` indirectly (sets current_health = max_health)

**Critical Thinking Questions:**
1. Which of your methods call other methods?
2. What would happen if `take_damage()` didn't check for health <= 0?
3. Why does `level_up()` fully heal the player?
4. How do the spike and potion "know" to call your methods?

## Part 8: Reflection and Analysis

### Code Review Questions
Write down or discuss your answers:

1. **Method Design**: Why do we pass parameters to `take_damage()` and `heal()` instead of hard-coding the amounts?

2. **Error Prevention**: What safeguards did we build into our methods? (Hint: think about health limits)

3. **User Experience**: How do our methods provide feedback to the player?

4. **Code Reusability**: How could other objects in the game use these same methods?

5. **Method Relationships**: Draw a diagram showing which methods call which other methods.

6. **Future Expansion**: What other methods might a character need? How would they interact with existing methods?

## Deliverables
By the end of this lesson, you should have:
- [ ] A working `take_damage()` method that responds to the spike
- [ ] A working `heal()` method that responds to the potion  
- [ ] A complete leveling system with `gain_experience()` and `level_up()`
- [ ] Enhanced debug information accessible with SPACE and ENTER
- [ ] Completed all code analysis questions
- [ ] Successfully tested the complete damage → death → restart cycle
- [ ] Successfully tested the healing and leveling systems
- [ ] Written reflection answers about method design

## Next Lesson Preview
In Lesson 3, we'll create an **Enemy** class! We'll need to give enemies their own health, damage, and combat methods. As you start thinking about enemies, consider this question: 

*What properties and methods will an Enemy need? How might they be similar to what we just built for the Player?*

Keep this in mind - you might notice some interesting patterns emerging! 🤔

## Troubleshooting

**"The spike/potion still says method not found"**
- Make sure you saved the player.gd file
- Check that your method names are exactly `take_damage` and `heal`
- Verify the methods are inside the Player class, not outside it

**"My player takes damage but nothing else happens"**
- Check the console output - you should see detailed messages
- Verify you added the `die()` method
- Make sure current_health is actually decreasing

**"Level up isn't working"**
- Press ENTER (not SPACE) to gain experience
- Check that you added both `gain_experience()` AND `level_up()` methods
- Look at console output to see experience progression

**"Player dies immediately"**
- Check that your current_health starts above 0
- Make sure you're not calling take_damage with huge amounts
- Verify the spike damage_amount is reasonable (should be around 25)

## Advanced Challenges (Optional)
If you finish early, try these challenges:

1. **Smart Healing**: Modify the potion so it only heals if player is actually injured
2. **Damage Types**: Add a parameter to `take_damage()` for different damage types
3. **Critical Hits**: Add a chance for double damage in combat
4. **Experience Sources**: Make the spike give experience when you survive its damage
5. **Health Regeneration**: Add a method that slowly heals the player over time

These challenges will prepare you for the complex systems we'll build in future lessons!
