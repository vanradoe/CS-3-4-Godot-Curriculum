# Setup Instructions: Spike and Health Potion

## Quick Setup for Testing Objects

To prepare the game for Lesson 2 (where students add methods), you need to create two simple test objects:

### 1. Creating the Spike Scene

**Create spike.tscn:**
1. Create new scene in Godot
2. Add **Area2D** as root node, rename to "Spike"
3. Add child nodes:
   - **Sprite2D** (for visual)
   - **CollisionShape2D** (for collision detection)

**Setup Spike Visual:**
- For **Sprite2D**: Create a new **PlaceholderTexture2D**
- Set the texture size to 64x64
- Set the color to **RED** (255, 0, 0, 255)
- Or use any spiky/dangerous looking sprite you have

**Setup Collision:**
- For **CollisionShape2D**: Create new **RectangleShape2D**
- Size it to match your sprite (about 64x64)

**Attach Script:**
- Select the "Spike" root node
- Attach the `scripts/spike.gd` script
- Save scene as `scenes/spike.tscn`

### 2. Creating the Health Potion Scene

**Create health_potion.tscn:**
1. Create new scene in Godot  
2. Add **Area2D** as root node, rename to "HealthPotion"
3. Add child nodes:
   - **Sprite2D** (for visual)
   - **CollisionShape2D** (for collision)

**Setup Potion Visual:**
- For **Sprite2D**: Create a new **PlaceholderTexture2D** 
- Set the texture size to 48x48
- Set the color to **GREEN** (0, 255, 0, 255)
- Or use any health/potion sprite you have

**Setup Collision:**
- For **CollisionShape2D**: Create new **RectangleShape2D**
- Size it to match your sprite (about 48x48)

**Attach Script:**
- Select the "HealthPotion" root node
- Attach the `scripts/health_potion.gd` script  
- Save scene as `scenes/health_potion.tscn`

### 3. Adding to Main Scene

**Update main.tscn:**
1. Open `scenes/main.tscn`
2. **Instance** the spike scene:
   - Drag `spike.tscn` into the main scene
   - Position it somewhere visible (maybe bottom-left)
3. **Instance** the health potion scene:
   - Drag `health_potion.tscn` into the main scene  
   - Position it somewhere visible (maybe top-right)
4. **Save** the main scene

### 4. Test the Setup

**Run the game and verify:**
- ✅ You see a red square (spike) and green square (potion)
- ✅ Console shows creation messages for both objects
- ✅ Moving player into spike shows damage message
- ✅ Moving player into potion shows heal message  
- ✅ Both show "method not found" messages (this is correct!)
- ✅ Pressing SPACE shows debug method info

### Expected Console Output:
```
=== GAME WORLD LOADED ===
Use arrow keys to move the player
Touch the RED spike to take damage
Touch the GREEN potion to heal
Press SPACE for debug info
========================
Player is ready!
Spike created - deals 25 damage
Health Potion created - heals 30 HP
```

### When Player Touches Objects:
```
Player touched spike! Dealing 25 damage
Player doesn't have take_damage() method yet - coming in Lesson 2!
```

```
Player found health potion!
Player doesn't have heal() method yet - coming in Lesson 2!
```

This creates the perfect setup for Lesson 2 where students will implement these methods and see immediate results!

### Visual Layout Suggestion:
```
    [HealthPotion]
         🟢


    [Player]                [Spike]  
       👤                     🟥
```

The objects are spread out so students can test movement and deliberately touch each one to see what happens.
