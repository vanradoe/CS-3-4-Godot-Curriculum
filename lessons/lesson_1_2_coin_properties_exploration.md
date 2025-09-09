# Lesson 1.2: Exploring Coin Properties and Variations

## Learning Objectives
By the end of this lesson, you will:
- Understand how @export properties make each instance unique
- Explore how to create different coin types using the same class
- Debug and test property changes systematically
- Experience the power of one class creating many different objects

## What We're Building
Today we're creating **different types of coins** (copper, silver, gold) using the same Coin class blueprint. You'll discover how properties make each coin unique while sharing the same code structure.

## Part 1: Property Investigation

### Step 1: Examine Current Properties
Let's investigate how properties currently work:

1. **Run the game** and touch your coin
2. **Open** `scenes/main.tscn`  
3. **Select the Coin node** in the scene tree
4. **Look at the Inspector panel** - what properties do you see?
5. **Change the `gold_value` from 10 to 50**
6. **Run the game again** - if you could pick up the coin, what would changing this value do in the game?

### Step 2: Predict Multi-Coin Behavior
Before making changes, answer these questions:

- If you duplicate the coin node, will both coins have the same gold_value?
- What if you change the gold_value on just one of the duplicated coins?
- How could you make coins automatically set their value based on their type?

## Part 2: Understanding Property Patterns

### Documentation: Property-Based Configuration
Here's a common pattern in game development - using properties to configure object behavior:

```gdscript
# Example: Weapon class that configures itself based on weapon_type
extends Node
class_name Weapon

@export var weapon_type: String = "sword"
@export var damage: int = 10

func configure_weapon() -> bool:
	match weapon_type:
		"sword":
			damage = 25
			return true
		"bow":
			damage = 15
			return true
		"club":
			damage = 35
			return true
		_:
			print("Unknown weapon type!")
			return false

func _ready():
	var success = configure_weapon()
	if success:
		print("Weapon configured: " + weapon_type + " deals " + str(damage) + " damage")
```

**Key Pattern Elements:**
- Use `@export` properties to define what makes each instance unique
- Create a configuration method that sets values based on type
- Return `bool` to indicate if configuration succeeded
- Use `match` statements for clean type handling

## Part 3: Implementing Coin Types

### Step 3: Add Coin Type Property
Open `scripts/coin.gd` and add this property:

```gdscript
@export var coin_type: String = "copper"  # Add this after your existing properties
```

### Step 4: Create Configuration Method
Following the weapon example above, create this method in your Coin class:

```gdscript
func configure_coin_type() -> bool:
	# TODO: Use match statement like the weapon example
	# TODO: Set gold_value based on coin_type
	# copper = 5, silver = 25, gold = 100
	# TODO: Print debug message for each type
	# TODO: Return true for valid types, false for invalid types
	pass
```

**Debug Challenge**: How will you test that this method works correctly?

### Step 5: Update _ready() Method
Modify your `_ready()` method to use the new configuration:

```gdscript
func _ready():
	# TODO: Call configure_coin_type() and store the result
	# TODO: Print success/failure message based on the return value
	# TODO: Keep your existing signal connection code
```

## Part 4: Testing Coin Variations

### Step 6: Test Single Type Change
1. **In the Inspector**, change your coin's `coin_type` to "silver"
2. **Run the game** - what value does it show?
3. **Try "gold"** - what happens?
4. **Try "platinum"** (invalid type) - what should happen?

### Step 7: Create Multiple Coins
1. **Duplicate your coin node** twice (Ctrl+D on the coin)
2. **Position them** in different locations
3. **Set different coin_type values**: "copper", "silver", "gold"
4. **Run the game** - do they show different values?

### Step 8: Debug Your Implementation
Add this test method to verify your coins work correctly:

```gdscript
func test_coin_setup() -> bool:
    # TODO: Check if gold_value matches what you expect for coin_type
    # TODO: Print the actual vs expected values
	# TODO: Return true if they match, false if they don't
	pass
```

Call this in your `_ready()` method after configuration to verify everything worked.

## Part 5: Property Validation and Error Handling

### Step 9: Explore Edge Cases
Test what happens with problematic inputs:

1. **Set coin_type to an empty string** `""` - what happens?
2. **Set gold_value to 0 manually** - should this be allowed?
3. **Set coin_type to "GOLD"** (uppercase) - does your match handle this?

### Step 10: Improve Your Implementation
Based on your testing, consider adding validation:

```gdscript
func validate_coin() -> bool:
	# TODO: Check if coin_type is not empty
	# TODO: Check if gold_value is positive  
	# TODO: Print helpful error messages
	# TODO: Return true if valid, false if problems found
	pass
```

## Part 6: Systematic Testing

### Step 11: Create Testing Protocol
Write a simple test to verify all your coins:

1. **Run the game**
2. **Check console** - do all coins show correct setup messages?
3. **Touch each coin** - do they give different amounts of gold?
4. **Answer**: How do you know each coin is working correctly?

### Step 12: Document Your Findings
In the console output, you should see patterns like:
```
Copper coin configured: 5 gold
Silver coin configured: 25 gold  
Gold coin configured: 100 gold
```

**Debugging Questions:**
- If a coin shows the wrong value, where would you look first?
- How can you test your `configure_coin_type()` method returns the right values?
- What evidence proves that properties make instances unique?

## Reflection Questions

Write down or discuss your answers:

1. **Property Power**: How do @export properties let you create different objects from the same class?

2. **Configuration Pattern**: Why use a separate `configure_coin_type()` method instead of setting values directly in properties?

3. **Return Value Testing**: How does returning `bool` from configuration methods help with debugging?

4. **Error Handling**: What should happen when someone sets an invalid `coin_type`?

5. **Testing Strategy**: How would you systematically test that all coin types work correctly?

## Deliverables
By the end of this lesson, you should have:
- [ ] Enhanced Coin class with `coin_type` property
- [ ] Working `configure_coin_type()` method that returns bool
- [ ] Three different coins (copper, silver, gold) with different values
- [ ] Testing method to verify coin configuration
- [ ] Understanding of property-based object configuration
- [ ] Experience debugging return values and property settings

## Next Lesson Preview
In Lesson 1.3, you'll apply the same pattern to **HealthPotions** but with minimal guidance! You'll create minor, major, and super potions using the same property configuration approach you just learned with coins.

**Challenge Preview**: Can you figure out how to make potions configure themselves based on `potion_type` without being given the complete code?

## Troubleshooting

**"All coins have the same value"**
- Check that you set different `coin_type` values in the Inspector for each coin instance
- Make sure you called `configure_coin_type()` in `_ready()`
- Verify the match statement covers your coin types

**"Configuration method not working"**
- Check spelling in your match cases ("copper" not "Copper")
- Make sure you're actually calling the method in `_ready()`
- Add print statements to see if the method is running

**"Invalid type not handled"**
- Test your default case (`_:`) in the match statement
- Make sure it prints a helpful message and returns false
- Consider adding validation before configuration

Great work exploring properties! You've discovered how one class blueprint can create many unique objects. 🪙
