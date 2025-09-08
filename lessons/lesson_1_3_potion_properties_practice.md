# Lesson 1.3: Potion Properties Practice

## Learning Objectives
By the end of this lesson, you will:
- Apply the property configuration pattern from Lesson 1.2 to a new class
- Work with minimal scaffolding to reinforce pattern understanding
- Create potion variations using the same techniques you learned with coins
- Build confidence in implementing property-based object configuration

## What We're Building
Using the **exact same pattern** you learned with coins, you'll enhance the HealthPotion class to support different potion types: minor (20 HP), major (50 HP), and super (100 HP).

## Part 1: Pattern Review

### Step 1: Review the Coin Pattern
Before starting, examine your coin implementation from Lesson 1.2:

1. **Open** `scripts/coin.gd`
2. **Look at** the `coin_type` property
3. **Study** the `configure_coin_type()` method structure
4. **Notice** how `_ready()` calls the configuration method
5. **Observe** the return value testing pattern

**Question**: What are the key elements of the property configuration pattern?

## Part 2: Applying the Pattern to Potions

### Step 2: Enhance HealthPotion Class
Open `scripts/health_potion.gd` and apply the same pattern you used for coins:

```gdscript
extends Area2D
class_name HealthPotion

# Existing properties
@export var heal_amount: int = 30
@export var auto_pickup: bool = true

# TODO: Add potion_type property (like coin_type)
# What should the default value be?

func configure_potion_type() -> bool:
    # TODO: Follow the coin pattern exactly
    # minor = 20 HP, major = 50 HP, super = 100 HP
    # TODO: Use match statement
    # TODO: Set heal_amount based on potion_type
    # TODO: Print debug messages
    # TODO: Return true for valid types, false for invalid
    pass

func _ready():
    # TODO: Call configure_potion_type() and test return value
    # TODO: Print appropriate success/failure messages
    # TODO: Keep existing signal connection
    body_entered.connect(_on_body_entered)
```

**Reference**: Look at how your coin class does this - the pattern is identical!

### Step 3: Test Your Implementation
1. **Change the `potion_type`** in the Inspector to "major"
2. **Run the game** - does it show 50 HP?
3. **Try "super"** - what heal amount appears?
4. **Try an invalid type** - does it handle the error?

## Part 3: Creating Multiple Potion Instances

### Step 4: Create Potion Variations
Following the same process you used for coins:

1. **Duplicate your HealthPotion node** twice in main.tscn
2. **Set different potion_type values**: "minor", "major", "super"  
3. **Position them** around the game world
4. **Test each one** - do they show different heal amounts?

## Part 4: Advanced Implementation

### Step 5: Add Validation (Optional Challenge)
If you created validation for coins, apply the same concept to potions:

```gdscript
func validate_potion() -> bool:
    # TODO: Check if potion_type is valid
    # TODO: Check if heal_amount makes sense for the type
    # TODO: Return validation result
    pass
```

### Step 6: Debug and Test Systematically
Create a testing approach similar to what you did with coins:

1. **Run the game** and check all setup messages
2. **Touch each potion type** and verify different healing amounts
3. **Test edge cases** like empty potion_type or invalid types

**Debug Question**: How can you prove your potion configuration is working correctly?

## Part 5: Pattern Recognition

### Step 7: Compare Your Implementations
Open both `coin.gd` and `health_potion.gd` side by side:

**What's Similar?**
- Property structure
- Configuration method pattern
- Return value testing
- Error handling approach

**What's Different?**
- Property names (`coin_type` vs `potion_type`)
- Values being set (`gold_value` vs `heal_amount`)  
- Type names and amounts

**Realization**: You've used the same pattern for two different classes!

## Reflection Questions

Write down or discuss your answers:

1. **Pattern Application**: How easy was it to apply the coin pattern to potions? What does this tell you about good code patterns?

2. **Minimal Scaffolding**: How did it feel to implement this with less guidance? What did you learn from having to figure it out yourself?

3. **Code Similarity**: Looking at both classes, what code is nearly identical between them?

4. **Future Applications**: What other game objects could use this same property configuration pattern?

5. **Testing Consistency**: Did you use similar debugging and testing approaches for both coins and potions?

## Deliverables
By the end of this lesson, you should have:
- [ ] Enhanced HealthPotion class with `potion_type` property
- [ ] Working `configure_potion_type()` method
- [ ] Three different potions (minor, major, super) with different healing amounts
- [ ] Understanding that the same pattern works across different classes
- [ ] Confidence in applying patterns with minimal guidance
- [ ] Recognition of code similarities between coin and potion implementations

## Next Lesson Preview
In Lesson 1.4, we'll tackle **Player Interaction** - making these pickups actually work! We'll add the missing `heal()` and `add_gold()` methods to the Player class so coins and potions finally do what they're supposed to do.

**Big Question**: You've built pickup objects, but they're still waiting for player methods. How will you design player methods that work with your return-value testing approach?

## Troubleshooting

**"I'm not sure how to start"**
- Look at your coin implementation from Lesson 1.2
- Copy the exact pattern but change the names and values
- Start with the property, then the configuration method, then update _ready()

**"My potions all have the same heal_amount"**
- Check that you set different `potion_type` values in the Inspector
- Make sure your match statement covers all types
- Verify you're calling `configure_potion_type()` in `_ready()`

**"The pattern seems repetitive"**
- This repetition is intentional - you're learning a fundamental pattern
- The similarity shows you understand how to apply consistent approaches
- Future lessons will address this code duplication with inheritance!

**"I want more help with the implementation"**
- Resist the urge to look up complete solutions
- Use your coin implementation as a reference
- Ask specific questions about parts you don't understand
- The struggle helps you learn the pattern more deeply

Excellent work! You're becoming independent at applying programming patterns. This is exactly how real game development works! 🧪✨