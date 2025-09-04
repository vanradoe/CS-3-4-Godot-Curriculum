# Lesson 1: What is a Class? Creating Your First Coin

## Learning Objectives
By the end of this lesson, you will:
- Understand what a class is and why we use them
- Create your first custom class in Godot
- Learn the difference between a class and an object (instance)
- See your class in action in the game

## Getting Started

### What's Already in the Project
Before we create our first class, let's see what's already there:
1. **Run the project** (press F5) and use arrow keys to move the player
2. Look in the `scripts/` folder - you'll see `player.gd` and `game_world.gd`
3. The **Player** is actually a class! Let's examine it.

### Investigation: Understanding the Player Class
Open `scripts/player.gd` and answer these questions:
1. What line declares this as a class? (Hint: look for `class_name`)
2. What does `extends CharacterBody2D` mean?
3. What properties does this class have? (Hint: look for variables)
4. What methods (functions) does this class have?

## Part 1: What is a Class?

### Think About It
Before we dive into code, think about these questions:
- In the real world, what's the difference between the **idea** of a car and an **actual** car?
- If you have the blueprint for a house, how many houses can you build from it?

### Classes in Programming
A **class** is like a blueprint or template. It describes:
- What **properties** an object has (like variables)
- What **behaviors** an object can do (like methods/functions)

An **object** (or **instance**) is the actual thing created from the class.

**Example:** 
- **Car class** = the blueprint (has properties like color, speed, fuel)
- **My red Honda** = an object/instance of the Car class

## Part 2: Creating Your First Class

### The Plan
We're going to create a **Coin** class. Here's what we want our coin to do:
- Exist in the game world
- Have a position where players can see it
- Eventually be collectable (in future lessons)

### Step 1: Create the Script File
1. In the `scripts/` folder, create a new file called `coin.gd`
2. **Don't attach it to anything yet** - we're just creating the class

### Step 2: Write the Class Code
In your `coin.gd` file, write this code (but think about what each line means):

```gdscript
extends Area2D
class_name Coin

func _ready():
    print("A coin has been created!")
```

### Understanding the Code
**Research Challenge**: Look up these concepts in the Godot documentation:
- What is an `Area2D`? Why might we use it for a coin?
- What does `class_name` do?
- When does `_ready()` get called?

**Documentation Links:**
- [Area2D Documentation](https://docs.godotengine.org/en/stable/classes/class_area2d.html)
- [Node._ready()](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-ready)

## Part 3: Creating the Coin Scene

### Step 3: Make a Scene for the Coin
1. Create a new scene in Godot
2. Add an **Area2D** as the root node
3. Rename it to "Coin"
4. Add these child nodes to the Area2D:
   - **Sprite2D** (for the visual)
   - **CollisionShape2D** (so things can collide with it)

### Step 4: Set Up the Visual
1. For the **Sprite2D**, you can either:
   - Use a simple colored square (create a PlaceholderTexture2D)
   - Find a coin sprite online and add it to your `sprites/` folder
2. For the **CollisionShape2D**:
   - Create a new RectangleShape2D
   - Size it to match your sprite

### Step 5: Attach Your Script
1. Select the root "Coin" node
2. Attach the `coin.gd` script to it
3. Save the scene as `coin.tscn` in the `scenes/` folder

## Part 4: Testing Your Class

### Step 6: Add a Coin to the Game
1. Open `main.tscn`
2. **Instance** your coin scene (drag `coin.tscn` into the main scene)
3. Position it somewhere the player can see it
4. Run the game!

### What Should Happen
- You should see your coin in the game world
- Check the Output panel - you should see "A coin has been created!"
- The player should be able to move around (but can't collect the coin yet)

## Part 5: Understanding Instances

### Experiment Time
Try this experiment to understand the difference between classes and instances:

1. **Add MORE coins** to your main scene:
   - Instance the coin scene 3-4 more times
   - Place them in different positions
   - Run the game again

### Questions to Think About
1. How many times did you see "A coin has been created!" in the output?
2. You wrote the Coin class code once, but how many coin objects exist in the game?
3. What would happen if you changed the `print` message in `coin.gd` and ran the game again?

## Part 6: Reflection Questions

Answer these questions (write them down or discuss with a partner):

1. **Class vs Instance**: Explain the difference between the Coin class and a coin instance in your own words.

2. **Benefits of Classes**: Why is it better to create a Coin class instead of just adding individual coins with duplicate code?

3. **Real-World Analogy**: Think of another real-world example where you have a "template" and many "instances" made from it.

4. **Prediction**: What do you think we'll add to our Coin class in the next lesson?

## Deliverables
By the end of this lesson, you should have:
- [ ] A working `coin.gd` script with the Coin class
- [ ] A `coin.tscn` scene file
- [ ] At least 3 coins visible in your game
- [ ] Written answers to the reflection questions
- [ ] A screenshot or video showing your coins in the game

## Next Lesson Preview
In Lesson 2, we'll add **properties** to our Coin class. Different coins will have different values, and we'll learn how to customize each coin instance while using the same class.

## Troubleshooting

**"My coin doesn't appear in the game"**
- Make sure you saved the coin scene
- Check that you actually added the coin instance to main.tscn
- Verify the coin is positioned within the camera view

**"I don't see the print message"**
- Check the Output tab at the bottom of Godot
- Make sure the script is attached to the coin scene's root node

**"I get an error when running"**
- Check that your script syntax is correct
- Make sure you saved all files
- Try closing and reopening the project

## Additional Resources
- [Godot's Introduction to Classes](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#classes)
- [Understanding Nodes and Scenes](https://docs.godotengine.org/en/stable/getting_started/step_by_step/nodes_and_scenes.html)
- [GDScript Class Reference](https://docs.godotengine.org/en/stable/classes/index.html)
