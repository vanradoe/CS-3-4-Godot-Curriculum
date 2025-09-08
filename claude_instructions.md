# Claude Instructions for Lesson Creation

## Overview
You are creating lessons for a high school second-year curriculum building a 2D top-down RPG in Godot. Students will learn game development patterns while building a complete game with enemies, skill trees, experience, inventory/loot systems, puzzles, dialogue, and more.

## Student Background
- **Half the students**: One year of Godot experience (know basics)
- **Half the students**: One year of GameMaker experience (new to Godot)
- **All students**: Understand basic programming concepts (variables, functions, loops, conditionals)

## Current Codebase State
Students start with:
- **Player class** with working movement and animation, but missing health/combat methods (has TODOs for health properties, character identity, combat stats, and methods like take_damage, heal, level_up, attack)
- **Spike class** that deals damage when touched (waits for Player.take_damage method)
- **HealthPotion class** that heals when touched (waits for Player.heal method)  
- **GameWorld class** with debug systems and references to player/objects
- **Basic scene structure** with main.tscn, player.tscn, spike.tscn
- **Debug systems** in place (Space for info, Enter for experience)

**Note**: Update this codebase overview as the curriculum evolves.

## Core Principles

### One New Concept Per Lesson
Each lesson introduces exactly ONE new programming concept:
- New class creation
- New method type
- New design pattern
- New data structure
- New Godot feature

### Exploratory Learning Flow
Every lesson follows this structure:
1. **Examine existing code** - students read and analyze provided code
2. **Predict behavior** - students hypothesize what will happen
3. **Study documentation** - provide code examples and explanations
4. **Build solution** - students implement similar functionality
5. **Test and iterate** - students verify their implementation works

### Scaffolding Progression
Adjust scaffolding based on what students have learned:
- **Early lessons (X.1)**: Function stubs with detailed TODO comments and code examples
- **Mid lessons (X.2-X.3)**: Function signatures with brief guidance
- **Advanced lessons (X.4+)**: Function names only with minimal hints
- **Never give complete solutions** unless immediately followed by similar problem to prove understanding

### Authentic Game Development
All lessons build toward the 2D top-down RPG:
- Use realistic game development scenarios
- Follow Godot best practices
- Integrate data structures only when they solve real game problems
- Make every feature serve the larger game vision

### Function Design Philosophy
Encourage students to **almost always return something** from their functions:
- **Makes functions testable**: Easy to verify what the function accomplished
- **Improves debugging**: Clear indication of success/failure or actual values
- **Enables composition**: Functions can be chained and combined effectively
- **Encourages intentional design**: Forces thinking about what the function should produce

**Game-specific examples:**
- `take_damage(amount)` → return `bool` (did target die?) or `int` (damage actually dealt)
- `heal(amount)` → return `int` (actual healing done after caps/limits)
- `pickup_item(item)` → return `bool` (was pickup successful?)
- `attack_target(target)` → return `AttackResult` or `bool` (hit/miss)
- `move_to(position)` → return `bool` (movement succeeded?) or `Vector2` (final position)
- `use_potion()` → return `bool` (was potion consumed?)

**Exceptions**: Only void returns for pure side effects like `print()`, `queue_free()`, or `play_animation()`

## Topic Progression

### Topic 1: Classes (Lessons 1.1-1.6)
Start with HealthPotion class to create pickup system:
- 1.1: Understanding existing HealthPotion class, create Coin class
- 1.2: Adding properties (healing amounts, coin values, pickup effects) 
- 1.3: Methods and behaviors (use_item, pickup_effects, value_calculations)
- 1.4: Player interaction (inventory basics, stat modifications)
- 1.5: Multiple instances and variations (different potion types, coin denominations)
- 1.6: Pickup base class introduction (prepare for inheritance)

### Topic 2: Inheritance (Lessons 2.1-2.4)
Build enemy system with shared functionality:
- 2.1: Create Enemy base class from duplicated slime/goblin code
- 2.2: Slime and Goblin inherit from Enemy
- 2.3: Adding specialized enemy types (archer, mage, tank)
- 2.4: Pickup inheritance system (refactor coins/potions)

### Topic 3: State Pattern (Lessons 3.1-3.4)
Complex entity behaviors:
- 3.1: Enemy AI states (patrol, chase, attack, die)
- 3.2: Player state management (idle, moving, attacking, casting)
- 3.3: Game state management (menu, playing, paused, game_over)
- 3.4: NPC dialogue states

### Topic 4: Command Pattern (Lessons 4.1-4.4)
Actions and history:
- 4.1: Player action commands (move, attack, cast_spell)
- 4.2: Undo/redo system for puzzle mechanics
- 4.3: Save/load as commands (serializing game state)
- 4.4: Cutscene and scripted event commands

### Topic 5: Observer Pattern/Signals (Lessons 5.1-5.4)
Decoupled communication:
- 5.1: Health changed signals (UI updates, death events)
- 5.2: Experience/leveling signals (skill tree updates, notifications)
- 5.3: Inventory signals (item added/removed, UI updates)
- 5.4: Event bus for global communication

### Topic 6: Strategy Pattern (Lessons 6.1-6.4)
Interchangeable behaviors:
- 6.1: Weapon attack strategies (sword, bow, magic staff)
- 6.2: Enemy AI strategies (aggressive, defensive, support)
- 6.3: Loot drop strategies (common, rare, boss-specific)
- 6.4: Dialogue response strategies

### Topic 7: Object Pooling (Lessons 7.1-7.3)
Performance optimization:
- 7.1: Projectile pooling (arrows, fireballs, bullets)
- 7.2: Enemy pooling for spawning systems
- 7.3: UI element pooling (damage numbers, notifications)

### Topic 8: Additional Patterns (Lessons 8.1-8.6)
- 8.1: Singleton pattern (GameManager, AudioManager)
- 8.2: Resource pattern (Godot .tres files for items, enemies)
- 8.3: Flyweight pattern (shared textures, audio)
- 8.4: Composition pattern (modular enemy abilities)
- 8.5: Advanced save/load systems
- 8.6: Local multiplayer implementation

## Data Structure Integration
Introduce data structures when they solve authentic game problems:
- **Arrays**: Enemy spawn lists, inventory slots, skill trees
- **Dictionaries**: Item stats, player attributes, dialogue choices
- **Lists**: Dynamic inventory, quest logs, active buffs
- **Trees**: Skill progression, dialogue trees
- **Linked Lists**: Turn-based combat order, undo history

## Lesson Structure Template

### Lesson Header
```markdown
# Lesson X.Y: [Descriptive Title]

## Learning Objectives
- Understand [one specific concept]
- Implement [specific functionality]
- Experience [real game development scenario]

## What We're Building
Brief description of the game feature being added.
```

### Exploration Phase
```markdown
## Part 1: Code Investigation
### Step 1: Examine Existing Code
[Direct students to specific files/code sections]

### Step 2: Predict Behavior  
[Questions about what the code does/will do]

### Step 3: Test Current State
[Have students run/test existing functionality]
```

### Documentation Phase
```markdown
## Part 2: Understanding [Concept]
### Code Examples
[Provide similar code examples for reference]

### Key Concepts
[Explain the programming concept being learned]
```

### Implementation Phase
```markdown
## Part 3: Building [Feature]
### Step X: [Specific Task]
[Function stubs with appropriate scaffolding level]

```gdscript
func example_function():
    # TODO: [Detailed guidance based on scaffolding level]
    pass
```
```

### Testing Phase
```markdown
## Part 4: Testing and Integration
[Steps to verify implementation works]
[Integration with existing game systems]
```

### Reflection
```markdown
## Reflection Questions
[3-5 questions about the concept learned]

## Next Lesson Preview
[Brief hint about what's coming next]
```

## Code Scaffolding Guidelines

### High Scaffolding (Early in Topic)
- Complete function signatures
- Detailed TODO comments explaining each step
- Code examples showing similar patterns
- Expected output examples

### Medium Scaffolding (Mid Topic)
- Function signatures with parameter hints
- Brief TODO comments with key steps
- Reference to documentation examples
- General expected behavior

### Low Scaffolding (Advanced in Topic)
- Function names only
- Minimal comments
- Students expected to reference previous lessons
- Focus on problem-solving

## Quality Standards
- **One concept per lesson**: Never introduce multiple new programming concepts
- **Working code**: Every lesson must result in functional game features
- **Progressive complexity**: Each lesson builds on previous knowledge
- **Authentic scenarios**: All examples serve the game development goal
- **Clear testing**: Students can verify their implementation works

## Lesson Creation Process
1. **Create only ONE lesson per response**
2. **Include any necessary code stubs/files for that lesson**
3. **End with suggested prompt for next lesson creation**
4. **Wait for human review before proceeding**

## Example Next Prompt Template
"Please create Lesson [X.Y] titled '[Title]' that teaches [specific concept]. Students should [specific learning goal]. The lesson should build on [previous lesson elements] and prepare for [future concept]. Focus on implementing [specific game feature]."

## Important Notes
- Always end each response with a suggested prompt for the next step
- Only create or edit one lesson and accompanying code before requesting review
- Keep the student's learning journey progressive and achievable
- Maintain authentic game development context throughout