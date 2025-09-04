# Setup Instructions for Classes Unit - Beginner Friendly

## What I've Created

This project has been redesigned for students who are new to Godot and learning about classes for the first time. The focus is on building concepts slowly and incrementally.

### Lesson Materials (Classes Unit)
1. **lesson_01_what_is_a_class.md** - Introduction to classes using coins
2. **lesson_01_teacher_guide.md** - Teacher solutions and explanations
3. **lesson_02_adding_properties.md** - Adding properties to classes  
4. **lesson_02_teacher_guide.md** - Teacher guide for properties lesson

### Project Foundation
- **Simple player** with just movement (no complex RPG stats)
- **Clean project structure** ready for student-created classes
- **Minimal starter code** - students build most things from scratch
- **Complex examples moved** to `scripts/advanced_examples/` for later use

## Current Project State

### What Works Right Now:
- ✅ Player moves with arrow keys
- ✅ Simple UI with instructions  
- ✅ No errors when running
- ✅ Clean script directory for student work

### What Students Will Build:
- 🎯 **Lesson 1**: Create their first Coin class
- 🎯 **Lesson 2**: Add properties (value, type, size) to coins
- 🎯 **Lesson 3**: Add methods (collect behavior, effects)
- 🎯 **Lesson 4**: Create different collectible classes (gems, power-ups)
- 🎯 **Lesson 5**: Player interaction with collectibles (collision detection)

## Setup Instructions (Minimal!)

### 1. Before Class Checklist
- [ ] **Run the project** - Should load without errors
- [ ] **Test movement** - Arrow keys move the player
- [ ] **Check file structure** - `scripts/` and `scenes/` folders exist and are mostly empty
- [ ] **Verify simplicity** - No complex UI or systems visible

### 2. Optional Visual Assets
If you want to provide sprites (completely optional):

```
sprites/
├── collectibles/     # Coin, gem, power-up sprites (32x32 recommended)  
│   ├── coin.png
│   ├── gem.png
│   └── powerup.png
└── characters/       # Player sprite (32x48 recommended)
    └── player.png
```

Students can also use:
- Godot's PlaceholderTexture2D (colored rectangles)
- Simple shapes drawn in any art program
- Free sprites from online (itch.io, OpenGameArt, etc.)

### 3. No Additional Scenes Required
Students will create their own scenes as part of the learning process:
- `main.tscn` ✅ - Already exists and ready
- `player.tscn` ✅ - Already exists and ready  
- `coin.tscn` - Students create in Lesson 1
- `gem.tscn` - Students create in later lessons

### 4. Classroom Management Tips

**For Mixed Experience Levels:**
- Advanced students can help beginners with Godot interface
- Encourage exploration - multiple solutions are OK
- Pair programming works well for these lessons

**For Complete Beginners:**
- Show how to create new scripts and scenes
- Demonstrate attaching scripts to nodes
- Point out where to find the Output panel for print statements

## Teaching Approach (Key Points)

### 🎯 **Exploratory Learning**
- Students discover concepts through guided questions
- Documentation links provided for research
- Multiple valid solutions encouraged

### 🔨 **Incremental Building**  
- Each lesson adds ONE new concept
- Previous lessons' work carries forward
- No overwhelming complexity dumps

### 💡 **Concrete Examples**
- Start with familiar objects (coins, gems)
- Connect to real-world analogies
- Visual feedback for abstract concepts

## Lesson Progression Overview

### **Lesson 1: What is a Class?**
- **Concept**: Class vs instance (blueprint vs object)
- **Practice**: Create Coin class, see multiple instances
- **Time**: 60-75 minutes
- **Deliverable**: Working coin that appears in game

### **Lesson 2: Adding Properties**
- **Concept**: Objects have characteristics (variables)
- **Practice**: Coin value, type, size properties with @export
- **Time**: 75-90 minutes  
- **Deliverable**: Different coins with different properties

### **Lesson 3: Adding Methods** (future)
- **Concept**: Objects have behaviors (functions)
- **Practice**: collect() method, visual effects
- **Time**: 75-90 minutes
- **Deliverable**: Coins that respond to player interaction

### **Future Lessons**: 
- Class variations (different collectible types)
- Player interaction (collision detection)
- Multiple class interactions

## Assessment Approach

### **Formative Assessment** (during class):
- Check student screens during work time
- Listen to peer discussions and questions
- Watch for common misconceptions

### **Summative Assessment** (lesson completion):
- Working code that meets deliverable requirements
- Answers to reflection questions
- Evidence of experimentation/creativity

### **Differentiation**:
- **Struggling students**: Focus on core concepts, provide extra scaffolding
- **Advanced students**: Challenge problems, help others, extend concepts

## Troubleshooting Common Issues

### **Technical Problems**:
- **Project won't run**: Check for script errors, verify scene paths
- **Scripts don't attach**: Show proper script attachment process
- **Properties don't show**: Verify @export syntax, try reselecting node

### **Conceptual Problems**:
- **Class vs instance confusion**: Use more real-world analogies
- **Property vs method confusion**: "Properties are traits, methods are actions"
- **Code structure confusion**: Show where different parts go step-by-step

## Parent Communication

If parents ask what students are learning:
> "Students are learning object-oriented programming through game development. They're creating classes (blueprints for game objects) and learning how objects can have different properties and behaviors. This builds foundation skills for software development while creating something fun and visual."

## Questions or Issues?

Common teacher questions:
- **"What if I don't know Godot?"** - The teacher guides provide complete solutions and explanations
- **"Students are at different levels"** - Encourage peer helping, provide extension activities
- **"Code isn't working"** - Check the teacher guides for common mistakes and solutions

The key is encouraging experimentation and not being afraid to try things - the lessons are designed to be forgiving and educational!
