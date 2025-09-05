extends Node2D
class_name EnemySpawner

# Array to hold Enemy objects - this is our object array!
var active_enemies: Array[Enemy] = []

# Alternative example - array of Pickup objects
var available_loot: Array[Pickup] = []

# Spawn configuration
@export var max_enemies: int = 5
@export var spawn_radius: float = 300.0

func _ready():
    print("=== ENEMY SPAWNER PRACTICE ===")
    print("Learning about arrays of objects!")
    
    # Demonstrate the difference
    demonstrate_simple_vs_object_arrays()
    
    # Practice with object arrays
    practice_enemy_object_arrays()
    
    # Advanced examples
    create_dynamic_squad_system()
    practice_pickup_object_arrays()
    summarize_object_array_benefits()
    
    print("===============================")

func demonstrate_simple_vs_object_arrays():
    print("\n--- Simple Arrays vs Object Arrays ---")
    
    # OLD WAY: Separate arrays for enemy data
    var enemy_names: Array[String] = ["Goblin", "Orc"]
    var enemy_health: Array[int] = [50, 80]
    var enemy_damage: Array[int] = [10, 15]
    
    print("Old way - separate arrays:")
    for i in range(enemy_names.size()):
        print("  " + enemy_names[i] + " - HP: " + str(enemy_health[i]) + ", Damage: " + str(enemy_damage[i]))
    
    print("\nProblems with separate arrays:")
    print("  - Must keep arrays synchronized")
    print("  - Adding enemy requires updating 3 arrays")
    print("  - Easy to make mistakes with indexes")
    
    print("\nNEW WAY: Array of Enemy objects")
    print("  - Each array element is a complete Enemy")
    print("  - All data stays together automatically")
    print("  - Add/remove complete objects easily")

func practice_enemy_object_arrays():
    print("\n--- Object Array Practice ---")
    
    # Clear any existing enemies
    active_enemies.clear()
    print("Starting with empty enemy array")
    print("Active enemies: " + str(active_enemies.size()))
    
    # Create enemy objects and add them to array
    create_test_enemies()
    
    # Practice accessing object properties
    access_enemy_properties()
    
    # Practice calling object methods
    call_enemy_methods()
    
    # Practice finding specific enemies
    find_enemies_by_criteria()

func create_test_enemies():
    print("\n--- Creating Enemy Objects ---")
    
    # Method 1: Create enemy and configure it, then add to array
    var goblin = Enemy.new()
    goblin.character_name = "Sneaky Goblin"
    goblin.max_health = 50
    goblin.current_health = 50
    goblin.damage = 12
    goblin.level = 2
    active_enemies.append(goblin)
    print("Created and added: " + goblin.character_name)
    
    # Method 2: Create enemy with different stats
    var orc = Enemy.new()
    orc.character_name = "Fierce Orc"
    orc.max_health = 80
    orc.current_health = 80
    orc.damage = 18
    orc.level = 4
    active_enemies.append(orc)
    print("Created and added: " + orc.character_name)
    
    # Method 3: Create a wounded enemy
    var wounded_troll = Enemy.new()
    wounded_troll.character_name = "Wounded Troll"
    wounded_troll.max_health = 120
    wounded_troll.current_health = 30  # Already damaged!
    wounded_troll.damage = 25
    wounded_troll.level = 6
    active_enemies.append(wounded_troll)
    print("Created and added: " + wounded_troll.character_name)
    
    print("Total enemies in array: " + str(active_enemies.size()))

func access_enemy_properties():
    print("\n--- Accessing Object Properties ---")
    
    # Loop through all enemies and show their stats
    print("Enemy roster:")
    for i in range(active_enemies.size()):
        var enemy = active_enemies[i]
        print("  " + str(i + 1) + ". " + enemy.character_name)
        print("     Health: " + str(enemy.current_health) + "/" + str(enemy.max_health))
        print("     Damage: " + str(enemy.damage))
        print("     Level: " + str(enemy.level))
        
        # Calculate health percentage
        var health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
        print("     Health: " + str(int(health_percent)) + "%")
    
    # Access specific enemy by index
    if active_enemies.size() > 0:
        var first_enemy = active_enemies[0]
        print("\nFirst enemy details:")
        print("  Name: " + first_enemy.character_name)
        print("  Is alive: " + str(first_enemy.current_health > 0))

func call_enemy_methods():
    print("\n--- Calling Object Methods ---")
    
    # Call methods on enemies in the array
    print("Testing enemy methods:")
    
    for enemy in active_enemies:
        print("\nTesting " + enemy.character_name + ":")
        
        # Test take_damage method (inherited from Character)
        if enemy.current_health > 0:
            print("  Before damage - Health: " + str(enemy.current_health))
            enemy.take_damage(10)
            print("  After damage - Health: " + str(enemy.current_health))
        
        # Test heal method (inherited from Character)  
        if enemy.current_health < enemy.max_health and enemy.current_health > 0:
            print("  Healing " + enemy.character_name)
            enemy.heal(15)
    
    # Remove dead enemies from array
    remove_dead_enemies()

func remove_dead_enemies():
    print("\n--- Removing Dead Enemies ---")
    
    # Count living enemies before cleanup
    var living_count = 0
    for enemy in active_enemies:
        if enemy.current_health > 0:
            living_count += 1
    
    print("Living enemies before cleanup: " + str(living_count))
    
    # Remove dead enemies (health <= 0)
    # Loop backwards to avoid index shifting issues
    for i in range(active_enemies.size() - 1, -1, -1):
        var enemy = active_enemies[i]
        if enemy.current_health <= 0:
            print("Removing dead enemy: " + enemy.character_name)
            active_enemies.remove_at(i)
    
    print("Enemies remaining: " + str(active_enemies.size()))

func find_enemies_by_criteria():
    print("\n--- Finding Enemies by Criteria ---")
    
    # Find enemies with low health (< 50%)
    print("Enemies with low health:")
    for enemy in active_enemies:
        var health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
        if health_percent < 50.0:
            print("  " + enemy.character_name + " (" + str(int(health_percent)) + "% health)")
    
    # Find the strongest enemy (highest damage)
    if active_enemies.size() > 0:
        var strongest_enemy = active_enemies[0]
        for enemy in active_enemies:
            if enemy.damage > strongest_enemy.damage:
                strongest_enemy = enemy
        print("Strongest enemy: " + strongest_enemy.character_name + " (Damage: " + str(strongest_enemy.damage) + ")")
    
    # Find enemies by level range
    print("High-level enemies (level 4+):")
    for enemy in active_enemies:
        if enemy.level >= 4:
            print("  " + enemy.character_name + " (Level " + str(enemy.level) + ")")
    
    # Count enemies by name pattern
    var goblin_count = 0
    for enemy in active_enemies:
        if "Goblin" in enemy.character_name:
            goblin_count += 1
    print("Goblin-type enemies: " + str(goblin_count))

func create_dynamic_squad_system():
    print("\n--- Dynamic Squad System ---")
    
    # Create a mixed squad of enemies
    create_balanced_squad()
    
    # Squad management
    manage_squad_health()
    
    # Squad coordination
    coordinate_squad_actions()

func create_balanced_squad():
    print("Creating balanced enemy squad...")
    
    # Clear existing enemies
    active_enemies.clear()
    
    # Squad composition: Tank, DPS, Support
    var tank = Enemy.new()
    tank.character_name = "Orc Guardian"
    tank.max_health = 150
    tank.current_health = 150
    tank.damage = 12
    tank.level = 5
    active_enemies.append(tank)
    
    var dps = Enemy.new()
    dps.character_name = "Goblin Assassin"
    dps.max_health = 60
    dps.current_health = 60
    dps.damage = 30
    dps.level = 4
    active_enemies.append(dps)
    
    var support = Enemy.new()
    support.character_name = "Shaman Healer"
    support.max_health = 80
    support.current_health = 80
    support.damage = 8
    support.level = 6
    active_enemies.append(support)
    
    print("Squad created with " + str(active_enemies.size()) + " members:")
    for enemy in active_enemies:
        print("  " + enemy.character_name + " (Role based on stats)")

func manage_squad_health():
    print("\nSquad health management:")
    
    # Calculate total squad health
    var total_health = 0
    var max_total_health = 0
    
    for enemy in active_enemies:
        total_health += enemy.current_health
        max_total_health += enemy.max_health
    
    var squad_health_percent = (float(total_health) / float(max_total_health)) * 100.0
    print("Squad health: " + str(total_health) + "/" + str(max_total_health) + " (" + str(int(squad_health_percent)) + "%)")
    
    # Find the most wounded squad member
    if active_enemies.size() > 0:
        var most_wounded = active_enemies[0]
        var lowest_health_percent = (float(most_wounded.current_health) / float(most_wounded.max_health)) * 100.0
        
        for enemy in active_enemies:
            var enemy_health_percent = (float(enemy.current_health) / float(enemy.max_health)) * 100.0
            if enemy_health_percent < lowest_health_percent:
                most_wounded = enemy
                lowest_health_percent = enemy_health_percent
        
        print("Most wounded: " + most_wounded.character_name + " (" + str(int(lowest_health_percent)) + "% health)")

func coordinate_squad_actions():
    print("\nSquad coordination:")
    
    # Simulate combat round where each enemy acts
    for i in range(active_enemies.size()):
        var enemy = active_enemies[i]
        print("  " + enemy.character_name + " attacks for " + str(enemy.damage) + " damage!")
        
        # More complex AI could go here:
        # - Healers prioritize healing wounded allies
        # - Tanks focus on protecting weaker members
        # - DPS focuses on maximum damage output

func practice_pickup_object_arrays():
    print("\n--- Pickup Object Arrays ---")
    
    # Clear existing loot
    available_loot.clear()
    
    # Create different types of pickups (if classes exist)
    # Note: These require HealthPotion, Coin, ExperienceGem classes from previous lessons
    
    # Placeholder example using generic approach
    print("Demonstrating pickup arrays concept:")
    print("  (This would work with HealthPotion, Coin, ExperienceGem objects)")
    print("  - Each pickup has its own properties and behaviors")
    print("  - Array holds complete pickup objects")
    print("  - Can call methods like get_pickup_name() on any pickup")
    
    # If the pickup classes exist, uncomment this code:
    # var health_potion = HealthPotion.new()
    # health_potion.heal_amount = 50
    # available_loot.append(health_potion)
    
    # var coin = Coin.new()
    # coin.coin_value = 25
    # available_loot.append(coin)
    
    # var exp_gem = ExperienceGem.new()
    # exp_gem.exp_value = 100
    # available_loot.append(exp_gem)

func summarize_object_array_benefits():
    print("\n--- Object Array Benefits Summary ---")
    
    print("✅ Complete entities: Each array element is a full object")
    print("✅ Data integrity: Properties stay synchronized automatically")
    print("✅ Method access: Can call methods on objects in arrays")
    print("✅ Polymorphism: Same array can hold different object types")
    print("✅ Easy management: Add/remove complete functional objects")
    print("✅ Type safety: Array[Enemy] only holds Enemy objects")
    
    print("\nReal game applications:")
    print("  - Enemy spawning and management systems")
    print("  - Player inventory holding different item types")
    print("  - Projectile arrays for bullets, arrows, spells")
    print("  - UI element arrays for menus and interfaces")
    print("  - Save data arrays for player progress")
